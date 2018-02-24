//
//  TestOneViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/3/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "TestOneViewController.h"
#import "PrefixHeader.pch"
#import "TestOneTableViewCell.h"

@interface TestOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation TestOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    [self createBarButtonItem];
    
}
-(void)createBarButtonItem{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 60, 23);
    [rightBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)rightBtnAction{
    
//    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:14 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    TestOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TestOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.test.text = [NSString stringWithFormat:@"已读%ld",indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%s",__func__);
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 75;
    }
    return _tableView;
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
