//
//  ChatImageView.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/22.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ChatImageView.h"

@interface ChatImageView ()

@property (nonatomic, strong) CALayer *contentLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation ChatImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor clearColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale; //非常关键设置自动拉伸的效果且不变形
    
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _maskLayer.frame =self.bounds;
    _contentLayer.frame =self.bounds;
    
    NSLog(@"path:%@",_maskLayer.path);

}

- (void)setMaskImage:(UIImage *)maskImage {
    _maskImage = maskImage;
    _maskLayer.contents = (id)maskImage.CGImage;
    [self setNeedsLayout];
}

- (void)setContentImage:(UIImage *)contentImage {
    _contentImage = contentImage;
    _contentLayer.contents = (id)contentImage.CGImage;
    [self setNeedsLayout];
}


@end
