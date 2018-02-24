//
//  ShowLable.h
//  JS_OC_Demo
//
//  Created by Mjwon on 2017/2/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShowLableTypeTop,
    ShowLableTypeLeft,
    ShowLableTypeShow,
    ShowLableTypeClick,
} ShowLableType;

typedef void(^BeginEditingAction)();

@interface ShowLable : UIView

@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,strong) NSString *subTitle;
@property (nonatomic ,assign) BOOL isChangeFrame;
@property (nonatomic ,assign) CGFloat titleFont;
@property (nonatomic ,assign) CGFloat subTitleFont;
@property (nonatomic ,assign) CGFloat height;
@property (nonatomic ,assign) CGFloat titleWidth;
@property (nonatomic ,strong) UIColor *subTitleBgColor;
@property (nonatomic ,assign) ShowLableType type;

@property (nonatomic, copy) BeginEditingAction beginEditingAction;

-(instancetype)initWithFrame:(CGRect)frame type:(ShowLableType)type;

@end
