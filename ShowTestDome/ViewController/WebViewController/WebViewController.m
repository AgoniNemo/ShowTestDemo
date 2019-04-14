//
//  WebViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/14.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "PrefixHeader.pch"
#import "WeakScriptMessageDelegate.h"

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic ,strong) WKWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = @"0d6ef5aa-f16b-4ba6-9839-8788759d15ff";
    
    NSString *sendToken = [NSString stringWithFormat:@"localStorage.setItem(\"accessToken\",'%@');",token];
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:sendToken injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"iOS"];
    [config.userContentController addUserScript:wkUScript];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"web_bi_app"];
    NSURL * url = [NSURL fileURLWithPath:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    _webView.allowsBackForwardNavigationGestures = true;
    [self.view addSubview:_webView];

}
#pragma mark- WKNavigationDelegate

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
    
    //如果需要回调，直接调用OC调用JS的方法 window.
    NSString *sendToken = [NSString stringWithFormat:@"window.iosORandroid.getAccessToken(\"%@\");",@""];
    NSLog(@"send:%@",sendToken);
    
    //    [self.webview evaluateJavaScript:sendToken completionHandler:^(id _Nullable string, NSError * _Nullable error) {
    //        //js返回值
    //        NSLog(@"执行结果：%@  error:%@",string,error);
    //    }];
    
}

//准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
    
}
//内容开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    NSLog(@"%s",__func__);
    
}
//内容加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"%s",__func__);
    /**
     NSString *jsToGetHTMLSource = @"document.documentElement.innerHTML";
     
     [webView evaluateJavaScript:jsToGetHTMLSource completionHandler:^(id _Nullable string, NSError * _Nullable error) {
     //js返回值
     NSLog(@"%@  error:%@",string,error);
     }];
     */
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURL *url = navigationAction.request.URL;
    NSLog(@"请求状态：%ld--%@",navigationAction.navigationType,url.scheme);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//在收到服务器的响应头后，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"url:%@",navigationResponse.response.URL.absoluteString);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//当主机接收到的服务重定向时调用（不一定调用）
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"重定向:%@",navigation);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"加载出错:%@",error);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
