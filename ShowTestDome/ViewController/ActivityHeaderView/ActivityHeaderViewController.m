//
//  ActivityHeaderViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/23.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "ActivityHeaderViewController.h"
#import "ActivityHeaderView.h"

@interface ActivityHeaderViewController ()

@end

@implementation ActivityHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    
}

-(void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
    ActivityHeaderView *view = [[ActivityHeaderView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.right.inset(16);
        make.height.mas_equalTo(30);
    }];
}

@end
