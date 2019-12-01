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
#import "VideoPresenter.h"

@interface VideoListCell()<VideoPresenterDelegate>
@property (nonatomic, strong) VideoPresenter *videpPresenter;

@property (nonatomic, weak) UIButton *muteBtn;
@property (nonatomic, weak) UILabel *timeLb;
@end

@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *url = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(16, 8, nScreenWidth()-32, 257);
    view.backgroundColor = [UIColor blackColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    [self.contentView addSubview:view];
    _videpPresenter = [[VideoPresenter alloc] init];
    _videpPresenter.delegate = self;
    [_videpPresenter playWithUrl:url addInView:view];
    [_videpPresenter pauseVideo];
    
    [self setup];
}

- (void)setup {
    
    // 静音按钮
    UIButton *muteBtn = [UIButton new];
    [muteBtn setImage:[UIImage imageNamed:@"m_mute"]
             forState:UIControlStateNormal];
    [muteBtn setImage:[UIImage imageNamed:@"m_mute"]
             forState:UIControlStateSelected];
    [muteBtn addTarget:self action:@selector(muteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    muteBtn.selected = YES;
    [_videpPresenter.videoPlayControl addSubview:muteBtn];
    self.muteBtn = muteBtn;
    [muteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(24);
        make.bottom.mas_equalTo(-16);
        make.right.mas_equalTo(-10);
    }];
    
    UIImageView *likeCountIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"m_praise_white"]];
    [_videpPresenter.videoPlayControl addSubview:likeCountIv];
    [likeCountIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.size.mas_equalTo(24);
    }];
    
    UILabel *likeCountLb = [[UILabel alloc] init];
    likeCountLb.font = [UIFont systemFontOfSize:10];
    likeCountLb.textColor = [UIColor whiteColor];
    likeCountLb.text = @"123";
    [_videpPresenter.videoPlayControl addSubview:likeCountLb];
    [likeCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(likeCountIv.mas_bottom).offset(1);
        make.height.mas_equalTo(12);
        make.centerX.equalTo(likeCountIv);
    }];
    
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.font = [UIFont systemFontOfSize:14];
    timeLb.textColor = [UIColor whiteColor];
    timeLb.text = @"0:56";
    [_videpPresenter.videoPlayControl addSubview:timeLb];
    self.timeLb = timeLb;
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *distanceLb = [[UILabel alloc] init];
    distanceLb.font = [UIFont systemFontOfSize:14];
    distanceLb.textColor = [UIColor whiteColor];
    distanceLb.text = @"28m";
    [_videpPresenter.videoPlayControl addSubview:distanceLb];
    [distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
    }];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont fontWithName:@"SFProText-Medium" size: 14];
    [_videpPresenter.videoPlayControl addSubview:nameLab];
    nameLab.text = @"Eugenia Ortiz";
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(distanceLb.mas_top);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(10);
    }];
    
    [_videpPresenter.videoPlayControl setImageWithURL:@"http://img1qn.moko.cc/2019-04-04/d88d4dac-fcd1-4eb2-bbac-3b2d083669b0.jpg?imageView2/2/w/915/h/915/q/85" placeholderImage:@"1"];

}

-(void)setModel:(VideoModel *)model
{
    _model = model;
    if (model.isPlay) {
        [_videpPresenter playVideo];
    }
}

- (void)muteBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    _videpPresenter.mute = btn.selected;
}

- (NSString *)timeFormatted:(NSInteger)totalSeconds {
    int min = floor(totalSeconds/60);
    int sec = round(totalSeconds - min * 60);
    return [NSString stringWithFormat:@"%02d:%02d", min, sec];
}

- (void)videoPlayProgressCurrentTime:(NSInteger)currentSeconds {
    NSString *total = [self timeFormatted:60-currentSeconds];
    NSLog(@"totalSeconds:%f",_videpPresenter.totalSeconds);
    self.timeLb.text = total;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
