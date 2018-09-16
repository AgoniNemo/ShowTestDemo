//
//  FoldingTableView.m
//  
//
//  Created by Mjwon on 2016/12/21.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import "FoldingTableView.h"
#import "FoldingSectionHeader.h"
#import "FoldingModel.h"

@interface FoldingTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray <FoldingModel *>*viewModels;
@property (nonatomic ,strong) NSMutableArray <FoldingSectionHeader *>*headerViews;

@end

@implementation FoldingTableView


#pragma mark - 初始化

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}


#pragma mark - 创建数据源和代理

-(void)setupDelegateAndDataSource
{
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    _headerViews = [NSMutableArray array];
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:)  name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(NSMutableArray *)viewModels
{
    if (_viewModels == nil) {
        _viewModels = [NSMutableArray array];
    }
    
    if (_viewModels.count) {
        if (_viewModels.count > self.numberOfSections) {
            [_viewModels removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _viewModels.count - self.numberOfSections)];
        }else if (_viewModels.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _viewModels.count; i < self.numberOfSections; i++) {
                FoldingModel *model = [[FoldingModel alloc] init];
                model.state = FoldingSectionStateFlod;
                model.bgColor = [self backgroundColorForSection:i];
                model.title = [self titleForSection:i];
                model.titleColor = [self titleColorForSection:i];
                [_viewModels addObject:model];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            FoldingModel *model = [[FoldingModel alloc] init];
            model.state = (i == 0)?:FoldingSectionStateFlod;
            model.bgColor = [self backgroundColorForSection:i];
            model.title = [self titleForSection:i];
            model.titleColor = [self titleColorForSection:i];
            [_viewModels addObject:model];
        }
    }
    
    return _viewModels;
}
-(void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration

-(UIColor *)backgroundColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:backgroundColorForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self backgroundColorForHeaderInSection:section];
    }
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
}
-(UIColor *)clickBackgroundColor{

    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(clickBackgroundColor)]) {
        return [_foldingDelegate clickBackgroundColor];
    }
    return [UIColor clearColor];
}
-(UIColor *)clickTitleColor{
    
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(clickHeaderTitleColor)]) {
        return [_foldingDelegate clickHeaderTitleColor];
    }
    return [UIColor blackColor];
}
-(NSString *)titleForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
-(UIFont *)titleFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:fontForTitleInSection:)]) {
        return [_foldingDelegate foldingTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
-(UIColor *)titleColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:textColorForTitleInSection:)]) {
        return [_foldingDelegate foldingTableView:self textColorForTitleInSection:section];
    }
    return [UIColor blackColor];
}
-(NSString *)descriptionForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:descriptionForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
-(UIFont *)descriptionFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:fontForDescriptionInSection:)]) {
        return [_foldingDelegate foldingTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont boldSystemFontOfSize:13];
}

-(UIColor *)descriptionColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:textColorForDescriptionInSection:)]) {
        return [_foldingDelegate foldingTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor whiteColor];
}

-(UIImage *)arrowImageForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:arrowImageForSection:)]) {
        return [_foldingDelegate foldingTableView:self arrowImageForSection:section];
    }
    return [UIImage imageNamed:@"towards_white_open"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate foldingTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForFoldingTableView:self];
    }else{
        return self.numberOfSections;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"section:%ld---color:%@",section,self.viewModels[section].bgColor);
    
    if (self.viewModels[section].state == FoldingSectionStateShow) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate foldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate foldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FoldingModel *model = self.viewModels[section];
    FoldingSectionHeader *sectionHeaderView = [[FoldingSectionHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self tableView:self heightForHeaderInSection:section])];
    
    sectionHeaderView.backgroundColor = model.bgColor;
    sectionHeaderView.title = model.title;
    sectionHeaderView.image = [self arrowImageForSection:section];
    sectionHeaderView.sectionState = model.state;
    sectionHeaderView.titleColor = model.titleColor;
    
//    NSLog(@"第%ld组---Color:%@",section,model.bgColor);
    
    __weak typeof(self) weakSelf = self;
    sectionHeaderView.headerClick =^(FoldingSectionHeader *headerView){
        
        [weakSelf headerActionWithSection:section view:headerView];
    };
    [_headerViews addObject:sectionHeaderView];
    return sectionHeaderView;
}

-(void)headerActionWithSection:(NSInteger)section view:(FoldingSectionHeader *)sectionHeaderView{
    
     [self beginUpdates];
    __weak typeof(self) weakSelf = self;
    [self.viewModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FoldingModel *objModel = obj;
        if (objModel.state == FoldingSectionStateShow && (section != idx)) {
            objModel.state = FoldingSectionStateFlod;
            objModel.bgColor = [UIColor whiteColor];
            objModel.titleColor = [UIColor blackColor];
            FoldingSectionHeader *sectionHeaderView = weakSelf.headerViews[idx];
            sectionHeaderView.sectionState = FoldingSectionStateFlod;
            sectionHeaderView.backgroundColor = [UIColor whiteColor];
            sectionHeaderView.titleColor = [UIColor blackColor];
            
            [weakSelf deleteRowsAtIndexPaths:[weakSelf deleteRowWithSection:idx] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
//            NSLog(@"bg:%@----title:%@",objModel.state?@"red":@"whiteColor",objModel.title);
        }
        
    }];
    
    FoldingModel *model = self.viewModels[section];

    if (model.state) {
        [self deleteRowsAtIndexPaths:[self deleteRowWithSection:section] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self insertRowsAtIndexPaths:[self insertRowWithSection:section] withRowAnimation:UITableViewRowAnimationFade];
    }
    model.state = !model.state;
    model.bgColor = model.state?[self clickBackgroundColor]:[UIColor whiteColor];
    model.titleColor = model.state?[self clickTitleColor]:[UIColor blackColor];
    sectionHeaderView.backgroundColor = model.bgColor;
    sectionHeaderView.titleColor = model.titleColor;
    [self.viewModels replaceObjectAtIndex:section withObject:model];
    [self.headerViews replaceObjectAtIndex:section withObject:sectionHeaderView];
//    NSLog(@"selectBg:%@----selectTitle:%@",model.state?@"red":@"whiteColor",model.title);
    
    [self endUpdates];
//    NSLog(@"-------------------------");
}
- (NSMutableArray *)insertRowWithSection:(NSInteger)section
{
    NSInteger insert = [_foldingDelegate foldingTableView:self numberOfRowsInSection:section];
    
    if (insert != 0)
    {
//        NSLog(@"即将展开:%ld--关闭数组：%ld",insert,section);
    }
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < insert; i++)
    {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}
- (NSMutableArray *)deleteRowWithSection:(NSInteger)section
{
    NSInteger delete = [_foldingDelegate foldingTableView:self numberOfRowsInSection:section];
    if (delete != 0)
    {
//        NSLog(@"即将关闭:%ld--关闭数组：%ld",delete,section);
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < delete; i++)
    {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
/**
 [self beginUpdates];
 
 __weak typeof(self) weakSelf = self;
 [self.viewModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 FoldingModel *objModel = obj;
 if (objModel.state == FoldingSectionStateShow && (section != idx)) {
 objModel.state = FoldingSectionStateFlod;
 objModel.bgColor = [UIColor whiteColor];
 objModel.titleColor = [UIColor blackColor];
 FoldingSectionHeader *sectionHeaderView = weakSelf.headerViews[idx];
 sectionHeaderView.sectionState = objModel.state;
 sectionHeaderView.backgroundColor = [UIColor whiteColor];
 sectionHeaderView.titleColor = [UIColor blackColor];
 [weakSelf deleteRowsAtIndexPaths:[weakSelf deleteRowWithSection:idx] withRowAnimation:UITableViewRowAnimationFade];
 //            *stop = YES;
 
 }
 NSLog(@"bg:%@----title:%@",objModel.state?@"red":@"whiteColor",objModel.title);
 if ([objModel.bgColor isSameColor:[weakSelf clickBackgroundColor]] && (section != idx)) {
 FoldingSectionHeader *sectionHeaderView = weakSelf.headerViews[idx];
 sectionHeaderView.backgroundColor = [UIColor whiteColor];
 }
 }];
 
 FoldingModel *model = self.viewModels[section];
 
 if (model.state) {
 [self deleteRowsAtIndexPaths:[self deleteRowWithSection:section] withRowAnimation:UITableViewRowAnimationFade];
 }else{
 [self insertRowsAtIndexPaths:[self insertRowWithSection:section] withRowAnimation:UITableViewRowAnimationFade];
 }
 model.state = !model.state;
 model.bgColor = model.state?[self clickBackgroundColor]:[UIColor whiteColor];
 model.titleColor = model.state?[self clickTitleColor]:[UIColor blackColor];
 sectionHeaderView.backgroundColor = model.bgColor;
 sectionHeaderView.titleColor = model.titleColor;
 [self.viewModels replaceObjectAtIndex:section withObject:model];
 NSLog(@"selectBg:%@----selectTitle:%@",model.state?@"red":@"whiteColor",model.title);
 
 
 [self endUpdates];
 NSLog(@"-------------------------");

 */

@end
