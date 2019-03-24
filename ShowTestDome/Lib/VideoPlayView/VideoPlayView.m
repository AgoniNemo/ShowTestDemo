//
//  VideoPlayView.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "VideoPlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@interface VideoPlayView()
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong, readwrite) UIView *controlView;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation VideoPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self configNotification];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self configNotification];
}


- (void)setupUI{
    
//    [self addSubview:self.controlView];
//    [self.controlView addSubview:self.bgImageView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(CGRectGetWidth(self.bounds)-34, CGRectGetHeight(self.bounds)-40, 24, 24);
//    [btn setImage:[UIImage imageNamed:@"m_mute"] forState:UIControlStateNormal];
//    [self addSubview:btn];
    
}
- (void)configNotification{
    [self removePlayer];
}

- (void)paly {
    [self.player play];
}

- (void)playWithViedeoUrl:(NSString *)videoUrl{
    
    // 获取播放内容
    self.playerItem = [self getPlayItemWithUrl:videoUrl];
    
    // 创建视频播放器
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    // 添加播放内容KVO监听
    [self addPlayerItemObserver];
    // 添加通知中心监听播放完成
    [self addNotificationToPlayerItem];
    
    // 初始化播放器图层对象
    [self initAVPlayerLayer];
    
//    [self.player play];
    
    [self isMutePlay:YES];
    
}

- (void)isMutePlay:(BOOL)b {
    self.player.volume = b ? 0 : 3.0f;
}
//设置声音模式，在播放器页面直接调用这个方法(根据自己的需求设置模式即可)
/**
 AVAudioSessionCategoryAmbient 或 kAudioSessionCategory_AmbientSound
 ———用于非以语音为主的应用，使用这个category的应用会随着静音键和屏幕关闭而静音。并且不会中止其它应用播放声音，可以和其它自带应用如iPod，safari等同时播放声音。注意：该Category无法在后台播放声音
 AVAudioSessionCategorySoloAmbient 或 kAudioSessionCategory_SoloAmbientSound
 ———类似于AVAudioSessionCategoryAmbient 不同之处在于它会中止其它应用播放声音。 这个category为默认category。该Category无法在后台播放声音
 AVAudioSessionCategoryPlayback 或 kAudioSessionCategory_MediaPlayback
 ———用于以语音为主的应用，使用这个category的应用不会随着静音键和屏幕关闭而静音。可在后台播放声音
 AVAudioSessionCategoryRecord 或 kAudioSessionCategory_RecordAudio
 ———用于需要录音的应用，设置该category后，除了来电铃声，闹钟或日历提醒之外的其它系统声音都不会被播放。该Category只提供单纯录音功能。
 AVAudioSessionCategoryPlayAndRecord 或 kAudioSessionCategory_PlayAndRecord
 ———用于既需要播放声音又需要录音的应用，语音聊天应用(如微信）应该使用这个category。该Category提供录音和播放功能。如果你的应用需要用到iPhone上的听筒，该category是你唯一的选择，在该Category下声音的默认出口为听筒（在没有外接设备的情况下）。
 */
- (void)setMute{
    
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: &setCategoryError];
    
    if (!success) {
        NSLog(@"设置失败，其他处理！");
    }
}

- (void)pause {
    [self.player pause];
}

- (void)removePlayer {
    if (self.player) {
        [self.player pause];
        [self.player.currentItem cancelPendingSeeks];
        [self.player.currentItem.asset cancelLoading];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        self.playerItem = nil;
        self.player = nil;
        self.playerLayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

// 初始化播放器图层对象
- (void)initAVPlayerLayer {
    // 创建视频播放器图层对象
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // 尺寸大小
    layer.frame = self.bounds;
    // 视频填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    layer.backgroundColor = [UIColor blackColor].CGColor;
    // 添加进控件图层
    [self.layer addSublayer:layer];
    self.playerLayer = layer;
    self.layer.masksToBounds = YES;
}

// 初始化AVPlayerItem视频内容对象
- (AVPlayerItem *)getPlayItemWithUrl:(NSString *)videoUrl {
    // 编码文件名，以防含有中文，导致存储失败
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlStr = [videoUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建播放内容对象
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    return item;
}
#pragma mark - 通知中心

- (void)addNotificationToPlayerItem {
    // 添加通知中心监听视频播放完成
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(playerDidFinished:)
                   name:AVPlayerItemDidPlayToEndTimeNotification
                 object:self.player.currentItem];
}

// 播放完成
- (void)playerDidFinished:(NSNotification *)notification {
    self.bgImageView.hidden = NO;
}

// 添加KVO，监听播放状态和缓冲加载状况
- (void)addPlayerItemObserver {
    // 监控状态属性
    [self.playerItem addObserver:self
                      forKeyPath:@"status"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    // 监控缓冲加载情况属性
    [self.playerItem addObserver:self
                      forKeyPath:@"loadedTimeRanges"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
}
// 属性发生变化，KVO响应函数
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    // 状态发生改变
    if ([keyPath isEqualToString:@"status"]) {
        
        AVPlayerStatus status = [[change objectForKey:@"new"] integerValue];
        if (status == AVPlayerStatusReadyToPlay) {
//            self.bgImageView.hidden = YES;
            NSLog(@"成功并开始播放！！！");
            NSLog(@"%@ %@",self.subviews,self.bgImageView);
        } else {
            NSLog(@"失败！！！");
        }
    }
    // 缓冲区域变化
    else if ( [keyPath isEqualToString:@"loadedTimeRanges"] ) {
        NSArray *array = playerItem.loadedTimeRanges;
        // 已缓冲范围
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
        NSTimeInterval totalDuration = CMTimeGetSeconds(playerItem.duration);
        NSLog(@"%f", totalBuffer / totalDuration);
    }
}

// 获取视频第一帧
- (UIImage *)getFirstFrameWithVideoURL:(NSURL *)url size:(CGSize)size{
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = size;
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    UIImage *image = [UIImage imageWithCGImage:img];
    CGImageRelease(img);
    
    return image;
}

-(void)setVideoUrl:(NSString *)videoUrl {
    _videoUrl = videoUrl;
    // 获取全局并发队列
    CGSize size = CGSizeMake(self.bounds.size.width, self.bounds.size.width); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 异步追加任务
        UIImage *image = [self getFirstFrameWithVideoURL:[NSURL URLWithString:videoUrl] size:size];
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bgImageView.image = image;
        });
    });
}
-(void)dealloc {
    [self removePlayer];
}
#pragma --mark get function

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.controlView.bounds];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
    
}
-(UIView *)controlView
{
    if (_controlView == nil) {
        _controlView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _controlView;
}

@end
