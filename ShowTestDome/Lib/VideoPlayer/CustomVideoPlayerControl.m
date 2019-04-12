//
//  CustomVideoPlayerControl.m
//  TestDemo
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CustomVideoPlayerControl.h"

@interface CustomVideoPlayerControl()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;  //菊花
@property (nonatomic, strong) UIView *fullScreenView;                 //全屏的一个视图
@property (nonatomic, weak) UIImageView *bgImageView;
@end

@implementation CustomVideoPlayerControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    //全屏的东西
    self.fullScreenView.frame = self.bounds;
    self.activityView.frame = self.bounds;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:bgImageView];
    bgImageView.hidden = YES;
    self.bgImageView = bgImageView;
    
}

- (void)playerControlPlay{
    _bgImageView.hidden = YES;
}
- (void)playerControlPause{
    
}

- (void)videoPlayerDidLoading{
    [self.activityView startAnimating];
}
- (void)videoPlayerDidBeginPlay{
    
    [self.activityView stopAnimating];
}
- (void)videoPlayerDidEndPlay{
    _bgImageView.hidden = YES;
    NSLog(@"播放结束");
}
- (void)videoPlayerDidFailedPlay{
    NSLog(@"播放失败");
    _bgImageView.hidden = YES;
    [self.activityView stopAnimating];
}

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage {
    _bgImageView.hidden = NO;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImage]];
}

- (UIActivityIndicatorView *)activityView{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.hidesWhenStopped = YES;
        [self.fullScreenView addSubview:_activityView];
        [_activityView startAnimating];
    }
    return _activityView;
}

//全屏
- (UIView *)fullScreenView{
    if (_fullScreenView == nil) {
        _fullScreenView = [[UIView alloc] init];
        [self addSubview:_fullScreenView];
    }
    return _fullScreenView;
}

@end
