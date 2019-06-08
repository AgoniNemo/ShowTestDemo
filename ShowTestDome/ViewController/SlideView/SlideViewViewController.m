//
//  SlideViewViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/6/7.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "SlideViewViewController.h"
#import "NemoScrollerView.h"

@interface SlideViewViewController ()

@end

@implementation SlideViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

-(void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScroll];
}
- (void)createScroll {
    
    NSArray <NSString *>*titles = @[@"技师",@"商家"];
    NemoScrollerView *scroll = [[NemoScrollerView alloc] initWithFrame:CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT)];
    scroll.titles = titles;
    scroll.lineColor = RGBACOLOR(230, 47, 92, 1);
    scroll.textColor = RGBACOLOR(230, 47, 92, 1);
    scroll.topViewColor = RGBACOLOR(249, 249, 249, 1);
    
    UIViewController *modelVc = [[UIViewController alloc] init];
    modelVc.view.backgroundColor = [UIColor brownColor];
    UIViewController *storeVc = [[UIViewController alloc] init];
    storeVc.view.backgroundColor = [UIColor purpleColor];
    
    scroll.srollerAction = ^(NSInteger tag) {
        NSLog(@"%ld",tag);
    };
    scroll.viewController = self;
    scroll.viewControllers = @[modelVc,storeVc];
    [self.view addSubview:scroll];
    

    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.frame = CGRectMake(SCREENWIDTH-20-24, 13, 24, 24);
    [videoBtn setImage:[UIImage imageNamed:@"m_view_video"] forState:UIControlStateNormal];
    [videoBtn setImage:[UIImage imageNamed:@"m_view_video"] forState:UIControlStateHighlighted];
    [scroll.scroller addSubview:videoBtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame = CGRectMake(CGRectGetMinX(videoBtn.frame)-24-20, 13, 24, 24);
    
    [imageBtn setImage:[UIImage imageNamed:@"m_view_pic_s"] forState:UIControlStateNormal];
    [imageBtn setImage:[UIImage imageNamed:@"m_view_pic_s"] forState:UIControlStateHighlighted];
    imageBtn.selected = YES;
    
    [scroll.scroller addSubview:imageBtn];
    
    
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
