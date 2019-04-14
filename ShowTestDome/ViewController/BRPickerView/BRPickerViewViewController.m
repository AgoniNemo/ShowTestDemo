//
//  BRPickerViewViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/4/14.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "BRPickerViewViewController.h"
#import <BRPickerView.h>

@interface BRPickerViewViewController ()

@end

@implementation BRPickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *minDate = [format dateFromString:@"2000-1-1"];
    NSDate *maxDate = [NSDate date];
    
    
    [BRDatePickerView showDatePickerWithTitle:@"" dateType:BRDatePickerModeTime defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:RGBACOLOR(230, 47, 92, 1) resultBlock:^(NSString *selectValue) {
        NSLog(@"selectValue：%@",selectValue);
       
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
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
