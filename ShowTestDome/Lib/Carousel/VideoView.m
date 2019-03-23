//
//  VideoView.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "VideoView.h"
#import "VideoMaskView.h"
@import AVFoundation;
@import AVKit;

@interface VideoView ()<AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayerViewController *videoPlayer;

@property (nonatomic, strong) VideoMaskView *videoMaskView;

@property (nonatomic, strong) id timeObserve;

@end

@implementation VideoView

+ (instancetype)videoViewFrame:(CGRect)frame videoUrl:(NSString *)videoUrl {
    VideoView *videoView = [[self alloc] initWithFrame:frame];
    videoView.videoUrl = videoUrl;
    return videoView;
}

- (void)loadUI {
    
    [self addSubview:self.videoPlayer.view];
    [self addSubview:self.videoMaskView];
    
    __weak typeof(self) weakSelf = self;
    self.videoMaskView.buttonValue = ^(PlayerState state) {
        switch (state) {
            case PlayerStateStart: {
                weakSelf.videoMaskView.isStartButton = !weakSelf.videoMaskView.isStartButton;
                weakSelf.isPlay = weakSelf.videoMaskView.isStartButton;
                weakSelf.videoMaskView.isStartButton ? [weakSelf.videoPlayer.player play] : [weakSelf.videoPlayer.player pause];
            }
                break;
            case PlayerStateReplay: { //重新播放  归0、
                
                weakSelf.videoMaskView.isStartButton = YES;
                weakSelf.isPlay = weakSelf.videoMaskView.isStartButton;
                
                CMTime dragedCMTime = CMTimeMake(0, 1);
                [weakSelf.videoPlayer.player seekToTime:dragedCMTime toleranceBefore:CMTimeMake(1,1) toleranceAfter:CMTimeMake(1,1) completionHandler:^(BOOL finished) {
                    [weakSelf.videoPlayer.player play];
                }];
                
            }
                break;
                
            default:
                break;
        }
    };
    
    // ******* 监听player *******
    [self.videoPlayer.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        [self createTimer];
    }
}

- (void)setVideoUrl:(NSString *)videoUrl {
    _videoUrl = videoUrl;
    [self loadUI];
}

- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.videoPlayer.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time){
        AVPlayerItem *currentItem = weakSelf.videoPlayer.player.currentItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime     = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value         = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            [weakSelf.videoMaskView playerCurrentTime:currentTime totalTime:totalTime sliderValue:value];
        }
    }];
}

- (void)start {
    [self.videoPlayer.player play];
}

- (void)stop {
    [self.videoPlayer.player pause];
}

- (AVPlayerViewController *)videoPlayer {
    if (!_videoPlayer) {
        _videoPlayer = [[AVPlayerViewController alloc]init];
        _videoPlayer.view.frame = self.frame;
        _videoPlayer.delegate = self;
        _videoPlayer.showsPlaybackControls = NO;
        _videoPlayer.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.videoUrl]];
    }
    return _videoPlayer;
}

- (VideoMaskView *)videoMaskView {
    if (!_videoMaskView) {
        _videoMaskView = [[VideoMaskView alloc]initWithFrame:self.frame];
    }
    return _videoMaskView;
}

- (void)dealloc {
    [self stop];
    [self.videoPlayer.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    // 移除time观察者
    if (self.timeObserve) {
        [self.videoPlayer.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
}


@end
