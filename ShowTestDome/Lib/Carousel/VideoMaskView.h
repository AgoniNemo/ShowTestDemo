//
//  VideoMaskView.h
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlayerState) {
    PlayerStateStart,
    PlayerStateReplay
};

typedef void(^StartButtonTapedBlock)(PlayerState state);

@interface VideoMaskView : UIView

/*
 * 底部进度条的值
 */
@property (nonatomic, assign) CGFloat progressValue;

/*
 * 开始按钮的状态
 */
@property (nonatomic, assign) BOOL isStartButton;

/*
 * 开始按钮点击Block
 */
@property (nonatomic, copy) StartButtonTapedBlock buttonValue;

- (void)playerCurrentTime:(NSInteger)currentTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue;

@end
