//
//  NestingViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/12/1.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "NestingViewController.h"
#import "NemoScrollerView.h"

@interface NestingViewController ()

@end

@implementation NestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

-(void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScroll];
}
- (void)createScroll {
    
    NSArray <NSString *>*titles = @[@"亲折",@"发现",@"大大"];
    NemoScrollerView *scroll = [[NemoScrollerView alloc] initWithFrame:CGRectMake(0, 0, nScreenWidth(), nScreenHeight())];
    scroll.titles = titles;
    scroll.lineColor = RGBACOLOR(230, 47, 92, 1);
    scroll.textColor = RGBACOLOR(230, 47, 92, 1);
    scroll.topViewColor = RGBACOLOR(249, 249, 249, 1);
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor brownColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor purpleColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor orangeColor];
    
    scroll.srollerAction = ^(NSInteger tag) {
        //        NSLog(@"%ld",tag);
    };
    scroll.viewController = self;
    scroll.viewControllers = @[vc1,vc2,vc3];
    [self.view addSubview:scroll];
    
    
}


@end
