//
//  VideoView.h
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoView : UIView

+ (instancetype)videoViewFrame:(CGRect)frame videoUrl:(NSString *)videoUrl;

// ******* 是否处于播放状态 ******
@property (nonatomic, assign) BOOL isPlay;
// ******* 视频播放地址 ******
@property (nonatomic, strong) NSString *videoUrl;

/*
 * 开始播放
 */
- (void)start;

/*
 * 暂停播放
 */
- (void)stop;

@end
