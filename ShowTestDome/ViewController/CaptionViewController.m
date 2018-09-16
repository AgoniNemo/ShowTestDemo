//
//  CaptionViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2018/9/13.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import "CaptionViewController.h"
#import <Masonry.h>
#import "CaptionView.h"

@interface CaptionViewController ()

@end

@implementation CaptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CaptionView *view = [[CaptionView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.captionDatas = @[@"测试文字",@"测试文字测试文字测试文字测试文字测试文字",@"测试文字测试测试",@"测试文字测试"];
//    view.textEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
//    view.numberOfLines = 2;
    //    view.showIntervalTime = 3;
    view.cycleAuto = NO;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.with.right.mas_offset(0);
        make.height.mas_equalTo(100);
    }];
    
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
