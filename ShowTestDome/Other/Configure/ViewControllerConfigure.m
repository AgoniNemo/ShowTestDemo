//
//  ViewControllerConfigure.m
//  CQ_App
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewControllerConfigure.h"
//#import <Aspects.h>

@implementation ViewControllerConfigure

+(void)load {
    [super load];
    [ViewControllerConfigure sharedInstance];
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ViewControllerConfigure *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ViewControllerConfigure alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /* 在这里做好方法拦截 */
//        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
//            [self loadView:[aspectInfo instance]];
//        } error:NULL];
//
//        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
//            [self viewWillAppear:animated viewController:[aspectInfo instance]];
//        } error:NULL];
//
//        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
//            [self viewDidLoad:animated viewController:[aspectInfo instance]];
//        } error:NULL];
    }
    return self;
}

/*
 下面的这些方法中就可以做到自动拦截了。
 所以在你原来的架构中，大部分封装UIViewController的基类或者其他的什么基类，都可以使用这种方法让这些基类消失。
 */
#pragma mark - fake methods
- (void)loadView:(UIViewController *)viewController
{
    NSLog(@" loadView");
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"viewWillAppear");
}

- (void)viewDidLoad:(BOOL)animated viewController:(UIViewController *)viewController
{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"viewDidLoad");
    [self setupViewsViewController:viewController];
    
    // 判断是否有上级页面，有的话再调用
    if ([viewController.navigationController.viewControllers indexOfObject:viewController] > 0) {
        [self setupLeftBarButtonViewController:viewController];
    }
}

- (void)setupViewsViewController:(UIViewController *)viewController {
    // 设置应用的背景色
    viewController.view.backgroundColor = [UIColor whiteColor];
    // 不允许 viewController 自动调整，我们自己布局；如果设置为YES，视图会自动下移 64 像素
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setupLeftBarButtonViewController:(UIViewController *)viewController{
    // 自定义 leftBarButtonItem ，UIImageRenderingModeAlwaysOriginal 防止图片被渲染
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[[UIImage imageNamed:@"m_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                             style:UIBarButtonItemStylePlain
                                             target:self  action:@selector(leftBarButtonClickViewController:)];
    // 防止返回手势失效
    viewController.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - 返回按钮的点击事件
- (void)leftBarButtonClickViewController:(UIViewController *)viewController {
    [viewController.navigationController popViewControllerAnimated:YES];
}
@end
