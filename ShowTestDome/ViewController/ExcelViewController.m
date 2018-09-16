//
//  ExcelViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2018/9/16.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import "ExcelViewController.h"
#import "YHExcel.h"

@interface ExcelViewController ()<YHExcelTitleViewDataSource,YHExcelViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic)  YHExcelTitleView *titleView;//表头
@property (strong, nonatomic)  YHExcelView *excelView;//表内容
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation ExcelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审批进度";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSource = [NSMutableArray new];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    for (int i = 0 ; i < 10; i ++) {
        NSString *opinion = @"没意见";
        NSString *updateTime = [formatter stringFromDate:[NSDate date]];
        NSString *userId = [NSString stringWithFormat:@"用户%d",i];
        NSArray *arr = @[[NSString stringWithFormat:@"%d步骤",i+1],userId,opinion,@"批准通过",updateTime];
        [self.dataSource addObject:arr];
    }
    [self createExcel];
}

-(void)createExcel{
    CGFloat titleY = 64;
    self.titleView = [[YHExcelTitleView alloc] initWithFrame:CGRectMake(0, titleY, SCREENWIDTH, 30)];
    self.titleView.contentSize = CGSizeMake(SCREENWIDTH, 0);
    self.titleView.backgroundColor = HOMECOLOR;
    self.titleView.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.titleView];
    
    CGFloat y = CGRectGetMaxY(self.titleView.frame);
    NSLog(@"%f",y);
    self.excelView = [[YHExcelView alloc] initWithFrame:CGRectMake(0, y, SCREENWIDTH, SCREENHEIGHT-y-5)];
    self.excelView.showBorder = YES;
    self.excelView.borderWidth = 1;
    self.excelView.borderColor = [UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1];
    [self.view addSubview:self.excelView];
    CGFloat width = SCREENWIDTH-20;
    //品质审批任务-IQCMRB评审-20161104-681
    self.titleArray = @[@"审批环节",@"用户",@"审批意见",@"审批状态",@"审批时间"];
    
    self.excelView.tableViewFrame = CGRectMake(10, 10, width, CGRectGetMaxY(self.excelView.frame)-64-y-7);//设置可横向滚动
    NSLog(@"%f",CGRectGetMaxY(self.excelView.frame)-64-y-7);
    self.titleView.contentSize = CGSizeMake(SCREENWIDTH, 0);
    
    
    self.titleView.dataSource = self;
    self.excelView.dataSource = self;
    self.excelView.backgroundColor = [UIColor whiteColor];
    
    //表头 与 表内容 同时滚动
    [self.titleView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld  context:nil];
    [self.excelView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
}

#pragma mark - YHExcelTitleViewDataSource
- (NSInteger)excelTitleViewItemCount:(YHExcelTitleView *)titleView {
    return 5;
}

- (NSString *)excelTitleView:(YHExcelTitleView *)titleView titleNameAtIndex:(NSInteger)index {
    return self.title;
}
-(UIColor *)excelTitleView:(YHExcelTitleView *)titleView titleColorAtIndex:(NSInteger)index
{
    return [UIColor whiteColor];
}
- (CGFloat)excelTitleView:(YHExcelTitleView *)titleView widthForItemAtIndex:(NSInteger)index
{
    return SCREENWIDTH;
}

#pragma mark - YHExcelViewDataSource
- (NSInteger)excelView:(YHExcelView *)excelView columnCountAtIndexPath:(NSIndexPath *)indexPath {
    return self.titleArray.count;
}

- (CGFloat)excelView:(YHExcelView *)excelView widthForColumnAtIndex:(YHExcelViewIndexPath *)indexPath {
    return (SCREENWIDTH-20)/5;
    
}

- (YHExcelViewColumn *)excelView:(YHExcelView *)excelView columnForRowAtIndexPath:(YHExcelViewIndexPath *)indexPath {
    YHExcelViewColumn *col = [excelView dequeueReusableColumnWithIdentifier:@"colCell"];
    if (col == nil) {
        col = [[YHExcelViewColumn alloc] initWithReuseIdentifier:@"colCell"];
        col.textLabel.font = [UIFont systemFontOfSize:10];
    }
    NSString *text = nil;
    
    if (indexPath.row == 0) {
        text = self.titleArray[indexPath.col];
    }else{
        NSArray *arr = self.dataSource[indexPath.row-1];
        text = [NSString stringWithFormat:@"%@",arr[indexPath.col]];
    }
    
    if (indexPath.row % 2 != 0) {
        col.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    }
    
    col.textLabel.text = text;
    return col;
}
-(CGFloat)tableView:(YHExcelView *)excelView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (NSInteger)numberOfSectionsInExcelView:(YHExcelView *)excelView {
    return 1;
}

- (NSInteger)excelView:(YHExcelView *)excelView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count+1;
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint old = [change[@"old"] CGPointValue];
    CGPoint new = [change[@"new"] CGPointValue];
    if (old.x == new.x) {
        return;
    }
    if (object == self.titleView) {
        self.excelView.scrollView.contentOffset = CGPointMake(new.x, 0);
    }else if(object == self.excelView.scrollView){
        self.titleView.contentOffset = CGPointMake(new.x, 0);
    }
}

- (void)dealloc {
    [self.titleView removeObserver:self forKeyPath:@"contentOffset"];
    [self.excelView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
