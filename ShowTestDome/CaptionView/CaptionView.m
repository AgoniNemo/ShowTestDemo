//
//  CaptionView.m
//  TableViewDemo
//
//  Created by Nemo on 2018/9/8.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import "CaptionView.h"

#define LABEL_LINESPACE 0       // 行间距

@interface CaptionView()
@property (nonatomic, strong) UILabel *lb;
/// 记录当前将要显示的文字的下标
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIView *showTextView;
@end


@implementation CaptionView

-(instancetype)init
{
    if (self == [super init]) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


-(void)showText{
    if (self.captionDatas.count == 0) return;
    [self startAnimation];
}

-(void)hiddenText{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:.5f animations:^{
        [self setViewAlpha:0];
    } completion:^(BOOL finished) {
        ws.index += 1;
        if (ws.index > ws.captionDatas.count-1) {
            ws.index = 0;
            if (!ws.cycleAuto) return;
        }
        CGFloat delay = ws.showIntervalTime ?: .8f;
        [ws performSelector:@selector(showText) withObject:nil afterDelay:delay];
    }];
}

-(void)startAnimation{
    [self setViewAlpha:0];
    NSString *text = self.captionDatas[self.index];
    self.lb.text = text;
    [self setShowTextViewFrame:text];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:.5f animations:^{
        [self setViewAlpha:1];
    } completion:^(BOOL finished) {
        CGFloat delay = ws.showTime ?: 5;
        [ws performSelector:@selector(hiddenText) withObject:nil afterDelay:delay];
    }];
}
-(void)setShowTextViewFrame:(NSString *)text{
    
    /// textLaebl 最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - 20*2;
    CGSize minSize = {maxWidth, CGFLOAT_MAX};
    CGSize size =  [self getTextFrame:text textMinSize:minSize];
    CGFloat top = _textEdgeInsets.top ?: 5;
    CGFloat left = _textEdgeInsets.left ?: 5;
    CGFloat bottom = _textEdgeInsets.bottom ?: 5;
    CGFloat right = _textEdgeInsets.right ?: 5;
    CGFloat height = (_numberOfLines > 0) ? 19.6*_numberOfLines:size.height;

    self.showTextView.frame = CGRectMake(20, 20, size.width+left+right, height+top+bottom);
    self.lb.frame = CGRectMake(left, top, size.width, height);
}
-(void)clickAction{
    !_textClickBlock ?: _textClickBlock();
}

#pragma --mark set
-(void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets
{
    _textEdgeInsets = textEdgeInsets;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimation) object:nil];
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:1];
}
-(void)setCaptionDatas:(NSArray *)captionDatas
{
    _captionDatas = captionDatas;
    _index = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimation) object:nil];
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:1];
}
-(void)setTextAlpha:(CGFloat)textAlpha
{
    _textAlpha = textAlpha;
    [self setViewAlpha:textAlpha];
}

-(void)setViewAlpha:(CGFloat)alpha{
    self.showTextView.alpha = alpha;
    self.lb.alpha = alpha;
}

-(void)setNumberOfLines:(NSInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    self.lb.numberOfLines = numberOfLines;
}
#pragma --mark lazy , drawUI

-(void)setup{
    [self addSubview:self.showTextView];
    [self.showTextView addSubview:self.lb];
    _cycleAuto = YES;
}

-(UIFont *)font
{
    if (_font == nil) {
        _font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    }
    return _font;
}

-(UILabel *)lb
{
    if (_lb == nil) {
        _lb = [[UILabel alloc] init];
        _lb.font = self.font;
        _lb.backgroundColor = [UIColor clearColor];
        _lb.textColor = [UIColor whiteColor];
        _lb.numberOfLines = 0;
    }
    return _lb;
}
-(UIView *)showTextView
{
    if (_showTextView == nil) {
        _showTextView = [[UIView alloc] init];
        _showTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4f];
        _showTextView.layer.cornerRadius = 5;
        _showTextView.layer.masksToBounds = YES;
        [_showTextView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)]];
    }
    return _showTextView;
}

#pragma --mark computed

-(CGSize)getTextFrame:(NSString *)text textMinSize:(CGSize)textMinSize{
    
    UIFont *font = self.font;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LABEL_LINESPACE];//调整行间距
    CGSize retSize = [text boundingRectWithSize:textMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    return retSize;
}

-(void)dealloc{
    NSLog(@"--dealloc--");
}

@end
