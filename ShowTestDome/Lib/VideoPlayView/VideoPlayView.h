//
//  VideoPlayView.h
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayView : UIView

/// 设置数据
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, strong) UIImage *coverImage;


/// 播放视频
- (void)paly;

/// 暂停视频
- (void)pause;

/// 播放视频
- (void)playWithViedeoUrl:(NSString *)videoUrl;

/// 移除视频
- (void)removePlayer;

/// 是否静音播放
- (void)isMutePlay:(BOOL)b;

@end
