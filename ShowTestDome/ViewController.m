//
//  ViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *string = self.dataSource[indexPath.row][@"title"];
    
    cell.textLabel.text = string;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataSource[indexPath.row][@"vc"];
    
    UIViewController *vc = [[NSClassFromString(string) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSArray *)dataSource
{
    return @[@{@"title":@"WebViewController",@"vc":@"WebViewController"},@{@"title":@"TestViewController",@"vc":@"TestViewController"},@{@"title":@"UIWebViewController",@"vc":@"UIWebViewController"},@{@"title":@"TestOneViewController",@"vc":@"TestOneViewController"},@{@"title":@"ShowGIFViewController",@"vc":@"ShowGIFViewController"},@{@"title":@"CaptionViewController",@"vc":@"CaptionViewController"},@{@"title":@"ASViewController",@"vc":@"ASViewController"}];
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
