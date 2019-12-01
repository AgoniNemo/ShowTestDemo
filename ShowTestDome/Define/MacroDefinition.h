//
//  MacroDefinition.h
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 mac. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

//iOS 11.0 配置
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define kStatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kStatusBarAndNavigationBarHeight (nScreenHeight() >= 812.0 ? 88.f : 64.f)
#define kSafeAreaBottomHeight (nScreenHeight() >= 812.0 ? 34.0f : 0.0)
#define kTabbarHeight (nScreenHeight() >= 812.0 ? 83.f : 49.f)


//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]] && [f count]>0)
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
static className *shared##className = nil;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
if (shared##className == nil) {\
shared##className = [super allocWithZone:zone];\
}\
});\
return shared##className;\
}\
+(instancetype)shared##className\
{\
return [[self alloc] init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return shared##className;\
}\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return shared##className;\
}



#pragma mark ————— 获取系统对象内联方法 —————

CG_INLINE UIApplication *kApplication() {
    return [UIApplication sharedApplication];
}
CG_INLINE UIView *kAppWindow() {
    return [UIApplication sharedApplication].delegate.window;
}
CG_INLINE UIViewController *kRootViewController() {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

CG_INLINE CGFloat nScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}
CG_INLINE CGFloat nScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}
CG_INLINE CGFloat kSafeAreaTopHeight() {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
CG_INLINE CGFloat tabBarHeight() {
    return 40+(nScreenHeight() >= 812.0 ? 34.0f : 5.0);
}

CG_INLINE CGFloat kKeyboardHeight() {
    
    if(nScreenHeight() == 812 && nScreenWidth() == 375){
        return 291.f;
    }else if(nScreenHeight() == 736 && nScreenWidth() == 414){
        return 216.f;
    }else if(nScreenHeight() == 667 && nScreenWidth() == 375){
        return 216.f;
    }else if(nScreenHeight() == 568 && nScreenWidth() == 320){
        return 253.f;
    }else{
        return 216.f;
    }
}
#pragma mark ————— UICOLOR内联方法 —————
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

CG_INLINE UIColor * RGBACOLOR(CGFloat r,CGFloat g,CGFloat b,CGFloat a) {
    return [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f  alpha:(a)];
}

/**
 输入RGB值获取颜色
 
 @param r RED值
 @param g GREEN值
 @param b BLUE值
 @return UIColor
 */
CG_INLINE UIColor * RGBCOLOR(CGFloat r,CGFloat g,CGFloat b) {
    return [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f  alpha:1];
}
/**
 *  输入16进制值获取颜色
 *
 *  @param rgbValue 16进制值
 *
 *  @return UIColor
 */
CG_INLINE UIColor * HEXCOLOR(NSUInteger rgbValue) {
    return [UIColor colorWithRed:(((float)((rgbValue & 0xFF0000) >> 16))) / 255.0f green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0f blue:((float)(rgbValue & 0xFF)) / 255.0f  alpha:1];
}
/**
 随机颜色
 
 @return 随机颜色
 */
CG_INLINE UIColor * RandomColor() {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0f green:arc4random_uniform(256) / 255.0f blue:arc4random_uniform(256) / 255.0f  alpha:1];
}

#pragma mark ————— 通知中心 —————
/**
 通知中心
 @return NSNotificationCenter
 */
CG_INLINE NSNotificationCenter * KNOTE() {
    return [NSNotificationCenter defaultCenter];
}
/**
 通知中心发送通知
 
 @param name 通知名称
 @param obj 通知参数
 */
CG_INLINE void KNOTEPost(NSString *name,id obj) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}
/**
 移除通知监听
 
 @param name 通知名称
 */
CG_INLINE void KNOTERemoveObserver(NSString *name,id _self) {
    [[NSNotificationCenter defaultCenter] removeObserver:_self name:name object:nil];
}

/**
 添加通知观察者
 @param observer 观察对象
 @param selector 相应事件
 @param name 通知名称
 */
CG_INLINE void KNOTEAddObserver(NSString *name,NSString *selector,id observer) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(selector) name:name object:nil];
}

#pragma mark ————— 偏好设置UserDefault —————

/**
 用户设置偏好设置
 
 @param keyName 偏好名称
 @param object 值
 */
CG_INLINE void UserDefaults_Set_WithKey(NSString *keyName,id object) {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 用户设置偏好获取
 
 @param keyName 偏好名称
 */
CG_INLINE id UserDefaults_Get_WithKey(NSString *keyName) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
}
/**
 用户设置偏好删除
 
 @param keyName 偏好名称
 */
CG_INLINE void UserDefaults_Del_WithKey(NSString *keyName) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyName];\
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ————— 多线程内联函数 —————
//GCD - 一次性执行
CG_INLINE void kDISPATCH_ONCE_BLOCK(id onceBlock) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, onceBlock);
}

//GCD - 在Main线程上运行
CG_INLINE void kDISPATCH_MAIN_THREAD(void(^mainQueueBlock)(void)) {
    dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
}
//GCD - 开启异步线程
CG_INLINE void kDISPATCH_GLOBAL_QUEUE_DEFAULT(void(^globalQueueBlock)(void)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);
}
//GCD - 延时
CG_INLINE void kDISPATCH_AFTER(CGFloat seconds,void(^queueBlock)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), queueBlock);;
}

//基础数据转字符串
CG_INLINE NSString *IntegerString(NSInteger integer) {
    return [NSString stringWithFormat:@"%li",integer];
}

//CGFloat转字符串
CG_INLINE NSString *FloatString(CGFloat f) {
    return [NSString stringWithFormat:@"%.f",f];
}

#pragma mark - ——————— 字体与颜色相关 ————————

CG_INLINE UIFont *FONTSIZE(CGFloat a) {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:a];
}
CG_INLINE UIFont *FONTBOLDSIZE(CGFloat a) {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:a];
}


//品牌色
CG_INLINE UIColor *BRANDCOLOR() {
    return RGBACOLOR(0, 212, 231, 1.0);
}
//辅助色
CG_INLINE UIColor *AUXILIARYCOLOR() {
    return RGBACOLOR(199, 164, 104, 1.0);
}
//辅助色2
CG_INLINE UIColor *AUXILIARYCOLOR2() {
    return RGBACOLOR(250, 244, 235, 1.0);
}
//成功色
CG_INLINE UIColor *SUCCESSCOLOR() {
    return HEXCOLOR(0x4CD964);
}
//警告色
CG_INLINE UIColor *WARNINGCOLOR() {
    return RGBACOLOR(230, 47, 92, 1.0);
}

CG_INLINE UIColor *SHADOWCOLOR() {
    return RGBACOLOR(0, 26, 37, 0.2);
}
// 黑色 COLOR222222(透明度)
CG_INLINE UIColor *MAINCOLORA(CGFloat alpha) {
    return RGBACOLOR(34, 34, 34, alpha);
}
// 黑色 COLOR222222
CG_INLINE UIColor *MAINCOLOR() {
    return MAINCOLORA(1.0);
}
// 白色
CG_INLINE UIColor *COLORFFFFFF() {
    return [UIColor whiteColor];
}
// 灰色1
CG_INLINE UIColor *COLOR555555() {
    return RGBACOLOR(85, 85, 85, 1.0);
}
// 灰色2 COLOR888888
CG_INLINE UIColor *GRAYCOLOR() {
    return RGBACOLOR(136, 136, 136, 1.0);
}
//灰色2 (和GRAYCOLOR 重复)
CG_INLINE UIColor * COLOR888888() {
    return RGBACOLOR(136, 136, 136, 1.0);
}
// 灰色3
CG_INLINE UIColor *COLORCCCCCC() {
    return RGBACOLOR(204, 204, 204, 1.0);
}
//灰色4 分割线颜色
CG_INLINE UIColor *COLOREDEDED() {
    return RGBACOLOR(237, 237, 237, 1.0);
}
//键盘灰色
CG_INLINE UIColor *COLORF5F5F5() {
    return HEXCOLOR(0xF5F5F5);
}
//灰色5
CG_INLINE UIColor *COLORF9F9F9() {
    return RGBACOLOR(249, 249, 249, 1.0);
}

/// 肤色 #FAF4EB
CG_INLINE UIColor *COLORFAF4EB() {
    return HEXCOLOR(0xFAF4EB);
}
/// #F9F4EC
CG_INLINE UIColor *COLORF9F4EC() {
    return HEXCOLOR(0xF9F4EC);
}
/// 性别蓝色
CG_INLINE UIColor *COLOR0091FF() {
    return RGBACOLOR(0, 145, 255, 1.0);
}
/// 活力圈标签颜色 #C77D68
CG_INLINE UIColor *COLORC77D68() {
    return RGBACOLOR(199, 125, 104, 1.0);
}
/// 活力圈创建时间颜色 #C7A468
CG_INLINE UIColor *COLORC7A468() {
    return RGBACOLOR(199, 164, 104, 1.0);
}
/// 活力圈黄颜色 #F7B500
CG_INLINE UIColor *COLORF7B500() {
    return RGBACOLOR(247, 181, 0, 1);
}

//弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
#endif /* MacroDefinition_h */
