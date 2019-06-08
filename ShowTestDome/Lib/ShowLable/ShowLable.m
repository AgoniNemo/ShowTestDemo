//
//  ShowLable.m
//  JS_OC_Demo
//
//  Created by Mjwon on 2017/2/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ShowLable.h"
#import "UIView+Size.h"

@interface ShowLable ()
{
    BOOL uneditable;
}

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *subTitleLabel;
@property (nonatomic ,strong) UIView *bottom;
@end

@implementation ShowLable

-(instancetype)initWithFrame:(CGRect)frame type:(ShowLableType)type{
    
    if ([self initWithFrame:frame]) {
        _type = type;

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.bottom];
        [self.bottom addSubview:self.subTitleLabel];
        [self addSubview:self.titleLabel];
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    NSAssert((title != nil), @" title 不能为空！");
    
    if (title.length > 0) {
        _titleLabel.text = title;
    }else{
        [_titleLabel removeFromSuperview];
        self.subTitleLabel.frame = self.frame;
    }
    
}
-(void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    NSAssert((subTitle != nil), @" subTitle 不能为空！");
    uneditable = YES;
    _subTitleLabel.text = [NSString stringWithFormat:@" %@",subTitle];

    if (self.isChangeFrame) {
        _titleLabel.frame = CGRectMake(0, (CGRectGetHeight(self.subTitleLabel.frame)-30)/2,100, 30);
    }
}
-(void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.width = titleWidth;
    CGFloat x = CGRectGetMaxX(self.titleLabel.frame)+10;
    CGRect frame = CGRectMake(x, 0, self.bounds.size.width-x, self.bounds.size.height);
    self.subTitleLabel.frame = frame;
    
}
-(void)setType:(ShowLableType)type
{
    _type  = type;
    CGFloat y = CGRectGetMaxY(self.titleLabel.frame);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    if (type == ShowLableTypeTop) {
        self.bottom.frame = CGRectMake(0, y, self.bounds.size.width, self.bounds.size.height-y);
        self.subTitleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bottom.frame), CGRectGetHeight(self.bottom.frame));
    }else if (type == ShowLableTypeClick){
        self.subTitleLabel.width -= 25;
    }
}
-(void)tapClick{
    if (self.beginEditingAction) {
        self.beginEditingAction();
    }
}

-(void)setTitleFont:(CGFloat)titleFont
{
    _titleFont = titleFont;
    _titleLabel.font = [UIFont systemFontOfSize:titleFont];
}
-(void)setSubTitleBgColor:(UIColor *)subTitleBgColor
{
    _subTitleBgColor = subTitleBgColor;
    _subTitleLabel.backgroundColor = subTitleBgColor;
}
-(UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        CGFloat spe = 0;
        if (_type == ShowLableTypeClick) {
            spe = 25;
        }
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bottom.frame), CGRectGetHeight(self.bottom.frame))];
        _subTitleLabel.userInteractionEnabled = YES;
        /**
        _subTitleLabel.backgroundColor = [UIColor colorWithRed:240/255.0f green:239/255.0f blue:244/255.0f alpha:1];
         */
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        [_subTitleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)]];
        
    }
    return _subTitleLabel;
}
-(UIView *)bottom
{
    if (_bottom == nil) {
        CGFloat x = CGRectGetMaxX(self.titleLabel.frame)+10;
        _bottom = [[UIView alloc] initWithFrame:CGRectMake(x, 0, self.bounds.size.width-x, self.bounds.size.height)];
        _bottom.layer.borderColor = [UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1].CGColor;
        _bottom.layer.borderWidth = .8;
        _bottom.layer.cornerRadius = 2.0;
    }
    return _bottom;
}
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,100, 30)];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

@end
