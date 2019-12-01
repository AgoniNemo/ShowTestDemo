//
//  FoldingViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2018/9/16.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import "FoldingViewController.h"
#import "FoldingTableView.h"

@interface FoldingViewController ()<FoldingTableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *dataSorce;
@property (nonatomic ,strong) NSArray *titleSorce;
@property (nonatomic ,weak) FoldingTableView *tableView;
@end

@implementation FoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleSorce = @[@"事件描述",@"1D成立团队",@"2D问题描述",@"3D临时控制对策",@"4D原因分析",@"5D永久措施",@"6D改善效果确认",@"7D预防措施",@"8D回顾与培训"];
    
    [self createQuest];
    
}

-(void)createQuest{
    FoldingTableView *tableView = [[FoldingTableView alloc] initWithFrame:CGRectMake(0, 0, nScreenWidth(), nScreenHeight())];
    tableView.foldingDelegate = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
}
#pragma mark - foldingTableViewDelegate / required（必须实现的代理）

- (NSInteger )numberOfSectionForFoldingTableView:(FoldingTableView *)tableView{
    
    return self.titleSorce.count;
}

- (CGFloat )foldingTableView:(FoldingTableView *)tableView heightForHeaderInSection:(NSInteger )section{
    
    return 44;
}

- (CGFloat )foldingTableView:(FoldingTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSString *)foldingTableView:(FoldingTableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleSorce[section];
}
- (NSInteger )foldingTableView:(FoldingTableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    return 1;
}

-(UIColor *)foldingTableView:(FoldingTableView *)tableView backgroundColorForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return WARNINGCOLOR();
    }
    return [UIColor whiteColor];
}
-(UIColor *)foldingTableView:(FoldingTableView *)tableView textColorForTitleInSection:(NSInteger)section
{
    if (section == 0) {
        return [UIColor whiteColor];
    }
    return [UIColor blackColor];
}
-(UIColor *)clickBackgroundColor
{
    return WARNINGCOLOR();
}
-(UIColor *)clickHeaderTitleColor
{
    return [UIColor whiteColor];
}
- (UITableViewCell *)foldingTableView:(FoldingTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}
- (void )foldingTableView:(FoldingTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - foldingTableViewDelegate / optional （可选择实现的）

/**
 - (NSString *)foldingTableView:(FoldingTableView *)tableView descriptionForHeaderInSection:(NSInteger )section
 {
 return @"detailText";
 }*/

-(void)dealloc{
    
    NSLog(@"%s",__func__);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
