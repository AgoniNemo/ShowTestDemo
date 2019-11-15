//
//  ViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
//    UIViewController *vc = [[NSClassFromString(@"ActivityHeaderViewController") alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
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
  return @[
           @{@"title":@"导航显示与隐藏",@"vc":@"HiddenViewController"},
           @{@"title":@"发微信朋友圈图片移动",@"vc":@"WeChatCircleViewController"},
           @{@"title":@"SlideView",@"vc":@"SlideViewViewController"},
           @{@"title":@"WKWebView演示iOS传值到Web",@"vc":@"WebViewController"},
           @{@"title":@"聊天气泡",@"vc":@"TestViewController"},
           @{@"title":@"加载打包web",@"vc":@"UIWebViewController"},
           @{@"title":@"显示GIF",@"vc":@"ShowGIFViewController"},
           @{@"title":@"类似拼多多详情商品界面闪现评论",@"vc":@"CaptionViewController"},
           @{@"title":@"倒计时按钮",@"vc":@"ASViewController"},
           @{@"title":@"类似Excel显示",@"vc":@"ExcelViewController"},
           @{@"title":@"类似QQ好友列表",@"vc":@"FoldingViewController"},
           @{@"title":@"视频和图片的混合轮播",@"vc":@"ImageVideoViewViewController"},
           @{@"title":@"视频列表",@"vc":@"VideoListViewController"},
           @{@"title":@"UITextField泄漏问题",@"vc":@"LeaksViewController"},
           @{@"title":@"BRPicker选择器",@"vc":@"BRPickerViewViewController"},
           @{@"title":@"原生分享",@"vc":@"ActivityViewController"},
           @{@"title":@"星星",@"vc":@"StarViewController"}];
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
