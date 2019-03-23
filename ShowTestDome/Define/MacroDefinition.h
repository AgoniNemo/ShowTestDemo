//
//  MacroDefinition.h
//  CQ_App
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

#define HOMECOLOR RGBCOLOR(112,112,112)

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        (AppDelegate *)[NSApplication sharedApplication].delegate
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define SCREENWIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT       [[UIScreen mainScreen] bounds].size.height
#define kSafeAreaTopHeight  (ScreenHeight == 812.0 ? 88 : 64)


#pragma mark ****** 宏方法 ******
//iOS 11.0 配置
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark ————— UICOLOR宏方法 —————
/**
 *  输入RGBA值获取颜色
 *
 *  @param r RED值
 *  @param g GREEN值
 *  @param b BLUE值
 *  @param a 透明度
 *
 *  @return UIColor
 */
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r) / 255.0f \
green:(g) / 255.0f \
blue:(b) / 255.0f \
alpha:(a)]

/**
 输入RGB值获取颜色
 
 @param r RED值
 @param g GREEN值
 @param b BLUE值
 @return UIColor
 */
#define RGBCOLOR(r, g, b)   [UIColor colorWithRed:(r) / 255.0f \
green:(g) / 255.0f \
blue:(b) / 255.0f \
alpha:1.0]

/**
 *  输入16进制值获取颜色
 *
 *  @param rgbValue 16进制值
 *
 *  @return UIColor
 */
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0\
alpha:1.0]

/**
 随机颜色
 
 @param 256 最大颜色值
 @return 随机颜色
 */
#define RandomColor    [UIColor colorWithRed:arc4random_uniform(256) / 255.0f \
green:arc4random_uniform(256) / 255.0f \
blue:arc4random_uniform(256) / 255.0f \
alpha:1]

#pragma mark ————— 通知中心 —————

/**
 通知中心发送通知
 
 @param name 通知名称
 @param obj 通知参数
 @return 无返回
 */
#define KNOTEPost(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

/**
 移除通知监听
 
 @param name 通知名称
 @return 无返回
 */
#define KNOTERemoveObserver(name) [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];


/**
 添加通知观察者
 
 @param observer 观察对象
 @param selector 相应事件
 @param name 通知名称
 @return 无返回
 */
#define KNOTEAddObserver(observer, selector, name) [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(selector) name:name object:nil];

#pragma mark ————— 偏好设置UserDefault —————

/**
 用户设置偏好设置
 
 @param keyName 偏好名称
 @param object 值
 @return 无返回
 */
#define UserDefaults_Set_WithKey(keyName,object)\
[[NSUserDefaults standardUserDefaults] setObject:object forKey:keyName];\
[[NSUserDefaults standardUserDefaults] synchronize];


/**
 用户设置偏好获取
 
 @param keyName 偏好名称
 @return 无返回
 */
#define UserDefaults_Get_WithKey(keyName)\
[[NSUserDefaults standardUserDefaults] objectForKey:keyName];

/**
 用户设置偏好删除
 
 @param keyName 偏好名称
 @return 无返回
 */
#define UserDefaults_Del_WithKey(keyName)\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:keyName];\
[[NSUserDefaults standardUserDefaults] synchronize];

#pragma mark ————— 多线程宏定义 —————
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

//增删改NSUserDefaults
#define GetUserDefaultsWithKey(keyName)\
[[NSUserDefaults standardUserDefaults] objectForKey:keyName]

#define DelUserDefaultsWithKey(keyName)\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:keyName];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define SetUserDefaultsWithKey(keyName,object)\
[[NSUserDefaults standardUserDefaults] setObject:object forKey:keyName];\
[[NSUserDefaults standardUserDefaults] synchronize];

//基础数据转字符串
#define IntegerString(integer)\
[NSString stringWithFormat:@"%li",integer]

#define FloatString(float)\
[NSString stringWithFormat:@"%.f",float]



//弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

#endif /* MacroDefinition_h */
