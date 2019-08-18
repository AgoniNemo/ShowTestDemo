//
//  NMDragListView.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "NMDragListView.h"

@interface NMDragListView()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) CGSize itemSize;
/**
 *  需要移动的矩阵
 */
@property (nonatomic, assign) CGRect moveFinalRect;
@property (nonatomic, assign) CGPoint oriCenter;

@property (nonatomic, strong) UIView *deleteView;
@property (nonatomic, strong) NMDragListViewConfiguration *conf;
@end

@implementation NMDragListView


- (NSMutableArray *)itemArray{
    return [self.items mutableCopy];
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (CGFloat)itemListH
{
    if (self.items.count <= 0) return 0;
    return CGRectGetMaxY([self.items.lastObject frame]) + self.conf.itemMargin;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(NMDragListViewConfiguration *)configuration
{
    if (self = [super initWithFrame:frame]) {
        self.conf = configuration;
        [self setup];
    }
    
    return self;
}


#pragma mark - 初始化
- (void)setup
{
    CGFloat width = (self.frame.size.width - ((self.conf.itemListCols + 1) * self.conf.itemMargin)) / self.conf.itemListCols;
    _itemSize = CGSizeMake(width, width);
    self.clipsToBounds = YES;
}

#pragma mark - 操作标签方法
// 添加多个标签
- (void)addItems:(NSArray<ActivitySceneItem *> *)items
{
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"Error" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    
    for (ActivitySceneItem *item in items) {
        [self addItem:item];
    }
}

// 添加标签
- (void)addItem:(ActivitySceneItem *)item
{
    
    //移除“添加”item
    if (self.items.count && self.items.count == self.conf.maxItem) {
        ActivitySceneItem *last = [self.items lastObject];
        [self.items removeObject:last];
        [last removeFromSuperview];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickItem:)];
    [item addGestureRecognizer:tap];
    
    if (self.conf.isSort && !item.isAdd) {
        // 添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [item addGestureRecognizer:pan];
    }
    [self addSubview:item];
    
    NSInteger tag = self.items.count;
    ActivitySceneItem *addItem = nil;
    if (self.items.count) {
        ActivitySceneItem *lastItem = [self.items lastObject];
        if (lastItem.isAdd) {
            addItem = lastItem;
            tag = lastItem.tag;
            lastItem.tag = tag +1;
        }
    }
    
    item.tag = tag;
    
    // 保存到数组
    if (addItem) {
        [self.items insertObject:item atIndex:self.items.count - 1];
    }
    else {
        [self.items addObject:item];
    }
    
    // 设置按钮的位置
    [self updateItemFrame:item.tag extreMargin:YES];
    if (addItem) {
        [self updateItemFrame:addItem.tag extreMargin:YES];
    }
    
    // 更新自己的高度
    if (self.conf.isFitItemListH) {
        CGRect frame = self.frame;
        frame.size.height = self.itemListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

// 点击标签
- (void)clickItem:(UITapGestureRecognizer *)tap
{
    [self dismissKeyBord];
    if (_clickItemBlock) {
        _clickItemBlock((ActivitySceneItem *)tap.view);
    }
}

// 拖动标签
- (void)pan:(UIPanGestureRecognizer *)pan
{
    [self dismissKeyBord];
    
    //坐标转换
    CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    
    // 获取偏移量
    CGPoint transP = [pan translationInView:self];
    
    ActivitySceneItem *tagButton = (ActivitySceneItem *)pan.view;
    
    // 开始
    if (pan.state == UIGestureRecognizerStateBegan) {
        _oriCenter = tagButton.center;
        [UIView animateWithDuration:-.25 animations:^{
            tagButton.transform = CGAffineTransformMakeScale(self.conf.scaleItemInSort, self.conf.scaleItemInSort);
        }];
        
        if (self.conf.showDeleteView) {
            [self showDeleteViewAnimation];
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:tagButton];
        
        tagButton.top = rect.origin.y + tagButton.top;
        tagButton.left = rect.origin.x + tagButton.left;
    }
    
    CGPoint center = tagButton.center;
    center.x += transP.x;
    center.y += transP.y;
    tagButton.center = center;
    
    // 改变
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        // 获取当前按钮中心点在哪个按钮上
        ActivitySceneItem *otherButton = [self buttonCenterInButtons:tagButton];
        
        if (otherButton && !otherButton.isAdd) { // 插入到当前按钮的位置
            // 获取插入的角标
            NSInteger i = otherButton.tag;
            
            // 获取当前角标
            NSInteger curI = tagButton.tag;
            
            _moveFinalRect = otherButton.frame;
            
            // 排序
            // 移除之前的按钮
            [self.items removeObject:tagButton];
            [self.items insertObject:tagButton atIndex:i];
            
            // 更新tag
            [self updateItem];
            
            if (curI > i) { // 往前插
                
                // 更新之后标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateLaterItemButtonFrame:i + 1];
                }];
                
            } else { // 往后插
                
                // 更新之前标签frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateBeforeTagButtonFrame:i];
                }];
            }
        }
        
        if (self.conf.showDeleteView) {
            if (tagButton.frame.origin.y + tagButton.frame.size.height > SCREENHEIGHT - self.conf.deleteViewHeight) {
                [self setDeleteViewDeleteState];
            }
            else {
                [self setDeleteViewNormalState];
            }
        }
        
    }
    
    // 结束
    if (pan.state == UIGestureRecognizerStateEnded) {
        BOOL deleted = NO;
        if (self.conf.showDeleteView) {
            [self hiddenDeleteViewAnimation];
            if (tagButton.frame.origin.y + tagButton.frame.size.height > SCREENHEIGHT - self.conf.deleteViewHeight) {
                deleted = YES;
                [self deleteItem:tagButton];
            }
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            tagButton.transform = CGAffineTransformIdentity;
            if (self->_moveFinalRect.size.width <= 0) {
                tagButton.center = self->_oriCenter;
            } else {
                tagButton.frame = self->_moveFinalRect;
            }
            tagButton.left = tagButton.left + rect.origin.x;
            tagButton.top = tagButton.top + rect.origin.y;
        } completion:^(BOOL finished) {
            self->_moveFinalRect = CGRectZero;
            if (!deleted) {
                [self addSubview:tagButton];
                tagButton.left = tagButton.left - rect.origin.x;
                tagButton.top = tagButton.top - rect.origin.y;
            }
        }];
        
    }
    
    [pan setTranslation:CGPointZero inView:self];
}

// 看下当前按钮中心点在哪个按钮上
- (ActivitySceneItem *)buttonCenterInButtons:(ActivitySceneItem *)curItem
{
    for (ActivitySceneItem *button in self.items) {
        if (curItem == button) continue;
        //坐标转换
        CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
        CGRect frame = CGRectMake(button.left + rect.origin.x, button.top + rect.origin.y, button.width, button.height);
        if (CGRectContainsPoint(frame, curItem.center)) {
            return button;
        }
    }
    return nil;
}


// 删除Itme
- (void)deleteItem:(ActivitySceneItem *)item
{
    [item removeFromSuperview];
    
    // 移除数组
    [self.items removeObject:item];
    
    // 更新item
    [self updateItem];
    
    // 更新后面item的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterItemButtonFrame:item.tag];
    }];
    
    // 更新自己的frame
    if (self.conf.isFitItemListH) {
        CGRect frame = self.frame;
        frame.size.height = self.itemListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
    
    if (_deleteItemBlock) {
        _deleteItemBlock(nil);
    }
}

// 更新item
- (void)updateItem
{
    NSInteger count = self.items.count;
    for (int i = 0; i < count; i++) {
        UIButton *tagButton = self.items[i];
        tagButton.tag = i;
    }
}

// 更新之前按钮
- (void)updateBeforeTagButtonFrame:(NSInteger)beforeI
{
    for (int i = 0; i < beforeI; i++) {
        // 更新按钮
        [self updateItemFrame:i extreMargin:NO];
    }
}

// 更新以后按钮
- (void)updateLaterItemButtonFrame:(NSInteger)laterI
{
    NSInteger count = self.items.count;
    
    for (NSInteger i = laterI; i < count; i++) {
        // 更新按钮
        [self updateItemFrame:i extreMargin:NO];
    }
}

- (void)updateItemFrame:(NSInteger)i extreMargin:(BOOL)extreMargin
{
    // 获取上一个按钮
    NSInteger preI = i - 1;
    
    // 定义上一个按钮
    ActivitySceneItem *preItem;
    
    // 过滤上一个角标
    if (preI >= 0) {
        preItem = self.items[preI];
    }
    
    // 获取当前按钮
    ActivitySceneItem *tagItem = self.items[i];
    
    [self setupItemButtonRegularFrame:tagItem];
    
}

// 计算标签按钮frame（按规律排布）
- (void)setupItemButtonRegularFrame:(ActivitySceneItem *)tagItem
{
    // 获取角标
    NSInteger i = tagItem.tag;
    NSInteger col = i % self.conf.itemListCols;
    NSInteger row = i / self.conf.itemListCols;
    CGFloat btnW = _itemSize.width;
    CGFloat btnH = _itemSize.height;
    //    NSInteger margin = (self.bounds.size.width - _itemListCols * btnW - 2 * _itemMargin) / (_itemListCols - 1);
    CGFloat btnX = col * (btnW + self.conf.itemMargin) + self.conf.itemMargin;
    CGFloat btnY = row * (btnH + self.conf.itemMargin);
    tagItem.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

#pragma mark - 底部删除 视图
- (UIView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, self.conf.deleteViewHeight)];
        _deleteView.backgroundColor = [UIColor redColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 201809;
        [button setImage:[UIImage imageNamed:@"wc_drag_delete"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wc_drag_delete_activate"] forState:UIControlStateSelected];
        [button setTitle:@"拖到此处删除" forState:UIControlStateNormal];
        [button setTitle:@"松手即可删除" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        //[button layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleTop imageTitleSpace:30];
        [_deleteView addSubview:button];
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.origin.x = (_deleteView.frame.size.width - frame.size.width) / 2;
        frame.origin.y = (self.conf.deleteViewHeight - frame.size.height) / 2 + 5;
        button.frame = frame;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_deleteView];
    }
    return _deleteView;
}

- (void)showDeleteViewAnimation{
    self.deleteView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.deleteView.transform = CGAffineTransformTranslate( self.deleteView.transform, 0, - self.conf.deleteViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenDeleteViewAnimation{
    [UIView animateWithDuration:0.25 animations:^{
        self.deleteView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setDeleteViewDeleteState{
    UIButton *button = (UIButton *)[_deleteView viewWithTag:201809];
    button.selected = YES;
}

- (void)setDeleteViewNormalState{
    UIButton *button = (UIButton *)[_deleteView viewWithTag:201809];
    button.selected = NO;
}

- (void)dismissKeyBord{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
