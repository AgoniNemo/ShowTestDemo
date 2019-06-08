//
//  XZCScrollerButton.m
//
//  Created by Nemo on 16/1/9.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "XZCScrollerButton.h"
#import "UIView+Size.h"
#import "NSString+Size.h"

#define DEFAULT_TITLES_FONT 16.0f
#define DEFAULT_DURATION .7f
#define NUMBER 4


@interface XZCScrollerButton ()<UIScrollViewDelegate>
{
    NSInteger _count;
    NSInteger _tag;
}
@property (nonatomic, assign) CGFloat viewWidth;                    //单个组件的宽度
@property (nonatomic, assign) CGFloat viewHeight;                   //单个组件的高度
@property (nonatomic, strong) NSMutableArray *viewWidths;           //所有的Lable宽度

@property (nonatomic, strong) UIView *heightLightView;
@property (nonatomic, strong) UIView *heightTopView;
@property (nonatomic, strong) UIView *heightColoreView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSMutableArray * labelMutableArray;
@property (nonatomic, copy) ButtonOnClickBlock buttonBlock;
@property (nonatomic, copy) ButtonClickBlock buttonClick;
@property (nonatomic, strong) UIScrollView *bottom;
@end

@implementation XZCScrollerButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        _duration = DEFAULT_DURATION;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_bottomLine != nil) { return; }
    [self createBottomLabels];
    [self createTopLables];
    [self createTopButtons];
}

-(void)setButtonPositionWithNumber:(CGFloat)position{
    self.isScroller = YES;
    CGFloat selectPage = position/SCREENWIDTH;
    NSInteger  index = 0;
    if (selectPage > 1) {
        index = selectPage;
    }
    CGFloat offset = (selectPage+1) * 16;
    CGFloat lableW = [_viewWidths[index] doubleValue];
    CGFloat x = (lableW + offset)/SCREENWIDTH*position;
    if (x <= 16) {
        x = 16;
    }
    self.bottomLine.x = x;
    self.heightLightView.frame = CGRectMake(x, 0, lableW+offset, _viewHeight);
    self.heightTopView.x = -x;
}

-(void) setButtonOnClickBlock: (ButtonOnClickBlock) block {
    if (block) {
        _buttonBlock = block;
    }
}

-(void) setButtonClickBlock:(ButtonClickBlock)block{
    if (block) {
        _buttonClick = block;
    }
}

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    _totalWidth = 0;
    _viewWidths = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < titles.count; i ++) {
        NSString *title = titles[i];
        CGFloat width = [title widthForMaxHeight:19 fontSize:16];
        [_viewWidths addObject:@(width)];
        _totalWidth += width;
    }
    _totalWidth += 2*16;
}


/**
 *  计算当前高亮的Frame
 *
 *  @param index 当前点击按钮的Index
 *
 *  @return 返回当前点击按钮的Frame
 */
- (CGRect)countCurrentRectWithIndex:(NSInteger)index {
    CGFloat labelW = [_viewWidths[index] doubleValue];
    CGFloat oldLableW = 0;
    if (index > 0) {
        oldLableW = [_viewWidths[index-1] doubleValue];
    }
    return  CGRectMake(oldLableW + 16*(index +1), 0, labelW, _viewHeight);
}

/**
 *  根据索引创建Label
 *
 *  @param index     创建的第几个Index
 *  @param textColor Label字体颜色
 *
 *  @return 返回创建好的label
 */
- (UILabel *)createLabelWithTitlesIndex:(NSInteger)index
                               textColor:(UIColor *)textColor {
    CGRect currentLabelFrame = [self countCurrentRectWithIndex:index];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:currentLabelFrame];
    tempLabel.textColor = textColor;
    tempLabel.text = _titles[index];
    tempLabel.font = [UIFont systemFontOfSize:16];
    tempLabel.minimumScaleFactor = 0.1f;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    return tempLabel;
}

/**
 *  创建最底层的Label
 */
- (void) createBottomLabels {
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *tempLabel = [self createLabelWithTitlesIndex:i textColor:_titlesCustomeColor];
        [self.bottom addSubview:tempLabel];
        [_labelMutableArray addObject:tempLabel];
    }
}

/**
 *  创建上一层高亮使用的Label
 */
- (void) createTopLables {
    
    CGFloat labelW = [_viewWidths[0] doubleValue];

    //label层上的view
    CGRect heightLightViewFrame = CGRectMake(0, 0, labelW+16, _viewHeight);
    _heightLightView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightLightView.clipsToBounds = YES;
    
    //动画元素
    _heightColoreView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightColoreView.backgroundColor = _backgroundHeightLightColor;
    if (_radiusBtn > 0) {
        _heightColoreView.layer.cornerRadius = _radiusBtn;
    }
    [_heightLightView addSubview:_heightColoreView];
    
    _heightTopView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, _totalWidth, _viewHeight)];
    
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *label = [self createLabelWithTitlesIndex:i textColor:_titlesHeightLightColor];
        [_heightTopView addSubview:label];
    }
    [_heightLightView addSubview:_heightTopView];
    
    [self.bottom addSubview:_heightLightView];
}
/**
 *  创建按钮
 */
- (void) createTopButtons {
    for (int i = 0; i < _titles.count; i ++) {
        CGRect tempFrame = [self countCurrentRectWithIndex:i];
        UIButton *tempButton = [[UIButton alloc] initWithFrame:tempFrame];
        tempButton.tag = i;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottom addSubview:tempButton];
    }
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(16, _viewHeight-15, 21, 2)];
    _bottomLine.backgroundColor = REDCOLOR;
    [self.bottom addSubview:_bottomLine];
    
}

/**
 *  点击按钮事件
 *
 *  @param sender 点击的相应的按钮
 */
- (void)tapButton:(UIButton *) sender {
    
    if (_buttonBlock && sender.tag < _titles.count) {
        _buttonBlock(sender.tag, _titles[sender.tag]);
    }

    if (_buttonClick && sender.tag < _titles.count) {
        _isScroller = YES;
        _buttonClick(sender.tag);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isScroller = NO;
        });
    }
    
    CGFloat selectPage = sender.tag;
    NSInteger  index = 0;
    if (selectPage > 1) {
        index = sender.tag;
    }
    CGFloat offset = (selectPage+1) * 16;
    CGFloat lableW = [_viewWidths[index] doubleValue];
    CGFloat x = (lableW * selectPage) + offset;
    if (x <= 16) {
        x = 16;
    }
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:_duration animations:^{
        weak_self.heightLightView.frame = CGRectMake(x, 0, lableW+offset, _viewHeight);
        weak_self.heightTopView.x = -x;;
        weak_self.bottomLine.x = x;
    } completion:^(BOOL finished) {}];
    
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
}
-(UIScrollView *)bottom
{
    if (_bottom == nil) {
        _bottom = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _totalWidth, self.frame.size.height+2)];
        _bottom.showsHorizontalScrollIndicator = NO;
        _bottom.delegate = self;
        [self addSubview:_bottom];
    }
    return _bottom;
}


@end
