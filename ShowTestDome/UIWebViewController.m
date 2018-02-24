//
//  UIWebViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/16.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "UIWebViewController.h"
#import "PrefixHeader.pch"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSObject.h"

@interface UIWebViewController ()<UIWebViewDelegate>
@property (nonatomic ,assign) BOOL isSkip;
@property (nonatomic ,strong) UIWebView *webView;
@property (nonatomic ,strong) NSMutableArray *urlArray;
@property (nonatomic ,strong) NSString *vcTitle;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
}
-(void)setVcTitle:(NSString *)vcTitle
{
    _vcTitle = vcTitle;
    self.title = vcTitle;
}

-(void)createWebView{
    
    if (_webView != nil) {
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
        }
    }
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
    NSURL * url = [NSURL fileURLWithPath:path];
    NSString *fragment = @"#!/keypoint";
    url = [NSURL URLWithString:fragment relativeToURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    NSLog(@"url后的：%@",url.fragment);
    
    [self.view addSubview:_webView];
    
    [self createJSContext];
    
    [self createItem];
    
}

-(void)reload{
    [self.webView reload];
}
-(void)createJSContext{
    
    // 通过UIWebView获得网页中的JavaScript执行环境
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 设置处理异常的block回调
    [context setExceptionHandler:^(JSContext *ctx, JSValue *value) {
        NSLog(@"error: %@", value);
    }];
    
    //    [context evaluateScript:[self observerJs]];
    
    JSObject *obj = [[JSObject alloc] init];
    context[@"iOS"] = obj;
    
    WEAKSELF(self)
    obj.block =^(NSString *title){
        NSLog(@"%@",title);
        weakSelf.vcTitle = title;
        weakSelf.isSkip = YES;
    };
}
-(NSString *)observerJs{
    
    return @"\
    var target = document.querySelector('title');\
    var observer = new window.WebKitMutationObserver(function(mutations) {\
    mutations.forEach(function(mutation) {\
    iOS.setTitle(target.innerHTML);});});\
    observer.observe(target, {characterData: true,childList: true});";
}
#pragma mark - UIWebView

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSLog(@"%s",__func__);
    
    [self getTitle];
    
    NSString *observer = [webView stringByEvaluatingJavaScriptFromString:[self observerJs]];
    
    NSLog(@"observer:%@",observer);
    
}

-(void)getTitle{
    
    WEAKSELF(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *js = @"document.title";
        
        NSString *title = [weakSelf.webView stringByEvaluatingJavaScriptFromString:js];
        
        weakSelf.vcTitle = title;
        
        NSLog(@"title:%@",title);
        
    });
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    [self.urlArray addObject:url];
    NSLog(@"界面跳转的url：%@",url);
    if (navigationType == UIWebViewNavigationTypeReload) {
        /**
         [self createWebView];//这个是比较暴力的刷新
         return NO;
         */
        NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
        NSString *urlPath = [NSString stringWithFormat:@"%@",path];
        NSURL * url = [NSURL fileURLWithPath:urlPath];
        NSString *fragment = @"#!/keypoint";
        url = [NSURL URLWithString:fragment relativeToURL:request.URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        return YES;
    }
    
//    if (![self.url isEqualToString:url] && self.isSkip) {
//        
//        NSLog(@"跳转BIChildViewController!");
//        
//        UIWebViewController *childVc = [[UIWebViewController alloc] init];
//        childVc.url = url;
//        [self.navigationController pushViewController:childVc animated:YES];
//        return NO;
//        
//    }
    
//    if (self.urlArray.count > 1) {
//        self.isSkip = YES;
//    }
    
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载出错:%@",error);
    
}
-(void)createItem{
    
    /**
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftbtn.frame = CGRectMake(0, 0, 23, 23);
    [leftbtn setImage:[UIImage imageNamed:@"back_white-0"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    */
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 70, 23);
    [rightBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    /**
     [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moreadd_white"] style:UIBarButtonItemStyleDone target:self action:@selector(clickedBarButtonItemAction:event:)]];
     */
    
}

-(void)goHome{
    [self.webView reload];
//    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}
-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableArray *)urlArray
{
    if (_urlArray == nil) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}
-(void)dealloc{
    
    [_webView stopLoading];
    _webView.delegate = nil;
    _webView = nil;
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    /**
     *  清理缓存
     */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSLog(@"我被释放了");
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
