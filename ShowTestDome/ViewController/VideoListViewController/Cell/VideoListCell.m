//
//  VideoListCell.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "VideoListCell.h"
#import "VideoPlayView.h"
#import "VideoModel.h"

@interface VideoListCell()

@property (strong, nonatomic) VideoPlayView *playView;

@property (nonatomic, strong) UIButton *muteBtn;

@end

@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView addSubview:self.playView];
    [self.playView addSubview:self.muteBtn];
}

-(void)setModel:(VideoModel *)model
{
    _model = model;
    self.playView.videoUrl = model.url;
    if (model.isPlay) {
        [self.playView playWithViedeoUrl:model.url];
    }
    [self setMute:model.isPlay];
}

- (void)setMute:(BOOL)b {
    NSString *name = b ? @"m_mute" :@"m_music";
    [_muteBtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [_muteBtn setImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
}

- (UIButton *)muteBtn
{
    if (_muteBtn == nil) {
        _muteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _muteBtn.frame = CGRectMake(CGRectGetWidth(self.playView.bounds)-34, CGRectGetHeight(self.playView.bounds)-40, 24, 24);
    }
    return _muteBtn;
}

-(VideoPlayView *)playView
{
    if (_playView == nil) {
        _playView = [[VideoPlayView alloc] initWithFrame:CGRectMake(16, 8, SCREENWIDTH-32, 273-16)];
    }
    return _playView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
