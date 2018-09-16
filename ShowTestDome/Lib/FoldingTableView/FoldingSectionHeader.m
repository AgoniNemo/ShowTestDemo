//
//  FoldingSectionHeader.m
//  
//
//  Created by Mjwon on 2016/12/21.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import "FoldingSectionHeader.h"

#define FoldingSepertorLineWidth       0.3f
#define FoldingMargin                  8.0f
#define FoldingIconSize                24.0f

@interface FoldingSectionHeader ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation FoldingSectionHeader


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame: frame]) {
        self.layer.borderWidth = .4;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self setupSubviewsWithArrowPosition];
    }
    return self;
}
-(void)setupSubviewsWithArrowPosition{
    
    CGFloat labelWidth = (self.frame.size.width - FoldingMargin*2 - FoldingIconSize)/2;
    CGFloat labelHeight = self.frame.size.height;
    CGRect arrowRect = CGRectMake(self.frame.size.width-FoldingIconSize-10, (self.frame.size.height - FoldingIconSize)/2, FoldingIconSize, FoldingIconSize);
    CGRect titleRect = CGRectMake(FoldingMargin, 0, labelWidth, labelHeight);
    CGRect descriptionRect = CGRectMake(FoldingMargin + labelWidth,  0, labelWidth, labelHeight);
    
    /**
    if (arrowPosition == FoldingSectionHeaderArrowPositionRight) {
        arrowRect.origin.x = FoldingMargin*2 + labelWidth*2;
        titleRect.origin.x = FoldingMargin;
        descriptionRect.origin.x = FoldingMargin + labelWidth;
    }*/
    
    [self.titleLabel setFrame:titleRect];
    [self.descriptionLabel setFrame:descriptionRect];
    [self.arrowImageView setFrame:arrowRect];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.arrowImageView];
    
    
}

-(void)setSectionState:(FoldingSectionState)sectionState
{
    _sectionState = sectionState;
    if (sectionState == FoldingSectionStateShow) {
        _arrowImageView.transform = CGAffineTransformMakeRotation(0);
    } else {
        _arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
//    NSLog(@"%@--%ld",sectionState?@"开":@"关",sectionState);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.headerClick) {
        self.headerClick(self);
    }
    _sectionState = !_sectionState;
    [self shouldExpand:_sectionState];
}
-(void)shouldExpand:(BOOL)shouldExpand{

    
    [UIView animateWithDuration:.25 animations:^{
        if (_sectionState == FoldingSectionStateShow) {
            _arrowImageView.transform = CGAffineTransformMakeRotation(0);
        } else {
            _arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    _arrowImageView.image = image;
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descriptionLabel;
}
-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.userInteractionEnabled = YES;
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _arrowImageView;
}


@end
