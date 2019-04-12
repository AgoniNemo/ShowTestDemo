//
//  CustomVideoPlayerControl.h
//  TestDemo
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomVideoPlayerControl : UIView

@property (nonatomic, assign) CGFloat cornerRadius;


//播放器调用方法
- (void)videoPlayerDidLoading;

- (void)videoPlayerDidBeginPlay;

- (void)videoPlayerDidEndPlay;

- (void)videoPlayerDidFailedPlay;

//外部方法播放
- (void)playerControlPlay;
//外部方法暂停
- (void)playerControlPause;

//设置背景
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;

@end

NS_ASSUME_NONNULL_END
