//
//  TMeButton.m
//  ShowTestDome
//
//  Created by Nemo on 2019/4/2.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "TMeButton.h"

@interface TMeButton()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLb;
@end

@implementation TMeButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isSelect = !self.isSelect;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        NSInteger w = self.isSelect ? 52 : 80;
        make.width.mas_equalTo(w);
    }];
    
    // 更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [self.superview layoutIfNeeded];
    }];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(tapAction) object:nil];
    [self performSelector:@selector(tapAction) withObject:nil afterDelay:0.5f];
}

- (void)tapAction {
    if (self.buttonClick) {
        self.buttonClick();
    }
}

- (void)setup {
    
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    self.layer.cornerRadius = 13;
    self.layer.shadowColor = RGBACOLOR(230, 47, 92, 0.1).CGColor;
    
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLb];
    }
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"m_btn_success"]];
        _imageView.hidden = YES;
        [self addSubview:_imageView];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"====");
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
}

-(void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    _titleLb.hidden = isSelect;
    _imageView.hidden = !isSelect;
    self.backgroundColor = !isSelect ? RGBACOLOR(230, 47, 92, 1):[UIColor whiteColor];
    self.layer.shadowOpacity = !isSelect ? 1:0;
    //设置边框颜色
    self.layer.borderColor = isSelect ? RGBACOLOR(245, 245, 245, 1).CGColor:[UIColor clearColor].CGColor;
    //设置边框宽度
    self.layer.borderWidth = !isSelect ? 2.0f : 1.0f;
}
-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLb.text = title;
}
-(void)setFrame:(CGRect)frame {
 
    
}

@end
