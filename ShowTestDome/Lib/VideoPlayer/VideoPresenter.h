//
//  VideoPresenter.h
//  ShowTestDome
//
//  Created by Nemo on 2019/4/12.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomVideoPlayerControl.h"

@class VideoPresenter;
@protocol VideoPresenterDelegate <NSObject>
@optional
- (void)videoPresenterDidBackBtnClick;
- (void)videoPlayProgressCurrentTime:(NSInteger)currentSeconds;

@end
@interface VideoPresenter : NSObject

@property (nonatomic, weak)   id <VideoPresenterDelegate> delegate;

@property (nonatomic, assign, readonly) CGFloat totalSeconds;

/// 静音 default is NO
@property (nonatomic, assign) BOOL mute;

///用于控制视频播放界面的View
@property (nonatomic, strong) CustomVideoPlayerControl *videoPlayControl;

///根据url播放视频（初始化播放）
- (void)playWithUrl:(NSString *)url addInView:(UIView *)view;

/**
 播放
 */
- (void)playVideo;

/**
 暂停
 */
- (void)pauseVideo;

/**
 停止播放/清空播放器
 */
- (void)stopVideo;

/**
 @param toTime 从指定的时间开始播放（秒）
 */
- (void)seekToTimePlay:(float)toTime;

@end
