//
//  LeaksViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/29.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "LeaksViewController.h"
#import "NMTextField.h"
#import "ThemeButton.h"

@interface LeaksViewController ()
@end

@implementation LeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ThemeButton *btn = [ThemeButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = RGBACOLOR(230, 47, 92, 1);
    [btn setTitle:@"Collect" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 28));
        make.center.equalTo(self.view);
    }];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)btnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *title = btn.selected ? @"" : @"Collect";
    NSString *image = btn.selected ? @"m_btn_success" : @"";
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image]
         forState:UIControlStateNormal];
    btn.imageView.hidden = btn.selected;
    btn.backgroundColor = btn.selected ? [UIColor whiteColor]:RGBACOLOR(230, 47, 92, 1);
    //设置边框颜色
    btn.layer.borderColor = btn.selected ? RGBACOLOR(245, 245, 245, 1).CGColor:[UIColor clearColor].CGColor;
    //设置边框宽度
    btn.layer.borderWidth = btn.selected ? 2.0f : 0.0f;
    [btn mas_updateConstraints:^(MASConstraintMaker *make) {
        NSInteger w = btn.selected ? 52 : 80;
        make.width.mas_equalTo(w);
    }];
}

- (void)createTF{
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
