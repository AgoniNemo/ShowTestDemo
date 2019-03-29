//
//  LeaksViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/29.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "LeaksViewController.h"
#import "NMTextField.h"

@interface LeaksViewController ()
@end

@implementation LeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NMTextField *passwordField = [[NMTextField alloc] initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width-60, 73)];
    passwordField.placeholder = @"password";
    passwordField.textName = @"password";
    passwordField.type = TextTypePassword;
    passwordField.textFieldBlock = ^(NSString *text) {
        NSLog(@"%@",text);
    };
    [self.view addSubview:passwordField];
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
