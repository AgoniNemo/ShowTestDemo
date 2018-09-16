//
//  ASCountDownView.h
//  ASCountDownToolKit
//
//  Created by haohao on 16/10/28.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ShowTimeType) {
    ShowTimeTypeChineseDayHourMinuteSec    = 1,//default   显示格式为00天00时00分00秒
    ShowTimeTypeChineseHourMinuteSec       = 2,//00时00分00秒
    ShowTimeTypeColonDayHourMinuteSec    = 3,//00天 00:00:00
    ShowTimeTypeColonHourMinuteSec,          //00:00:00
};
typedef NS_ENUM(NSInteger, TimeType) {
    TimeTypeNomal              = 0,///正常状态
    TimeTypeCountdowning       = 1,///倒计时状态
    TimeTypeCountdownEnd       = 2,///活动结束
};
@interface ASCountDownView : UIView
@property (nonatomic, assign) ShowTimeType showType;
@property (nonatomic, assign) TimeType type;
@property (nonatomic, copy) NSString *endTime;

@property (strong, nonatomic) UIColor *activityColor;/// 倒计时颜色
@property (strong, nonatomic) UIColor *endColor;/// 倒计时完成时的颜色


@property (copy, nonatomic) void (^finisedBlock)(void);

@end
