//
//  CaptionView.h
//  TableViewDemo
//
//  Created by Nemo on 2018/9/8.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionView : UIView

/// 显示文字数组
@property (nonatomic, strong) NSArray *captionDatas;

/// 文字UIFont
@property (nonatomic, strong) UIFont *font;

/// 文字numberOfLines
@property(nonatomic, assign) NSInteger numberOfLines;

/// 文字内边距
@property(nonatomic)  UIEdgeInsets textEdgeInsets;

/// 文字显示的时间
@property (nonatomic, assign) CGFloat showTime;

/// 文字与文字显示的时间间隔
@property (nonatomic, assign) CGFloat showIntervalTime;

/// 文字透明度
@property (nonatomic, assign) CGFloat textAlpha;

/// 点击文字事件
@property (nonatomic, copy) void (^textClickBlock)(void);

/// 是否循环显示（默认YES）
@property (nonatomic, assign) BOOL cycleAuto;


@end
