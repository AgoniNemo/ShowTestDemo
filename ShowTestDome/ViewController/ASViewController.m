//
//  ASViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2018/9/13.
//  Copyright © 2018年 Nemo. All rights reserved.
//

#import "ASViewController.h"
#import "ASCountDownView.h"

@interface ASViewController ()

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAS];
}
-(void)createAS{
        ASCountDownView *cv = [[ASCountDownView alloc] initWithFrame:CGRectMake(100, 100, 110, 32)];
        cv.endTime = @"1536399037";
        cv.activityColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
        [self.view addSubview:cv];
        
        ASCountDownView *cv3 = [[ASCountDownView alloc] initWithFrame:CGRectMake(100, 150, 110, 32)];
        cv3.endTime = @"1536303048";
        cv3.finisedBlock = ^{
            NSLog(@"---cv3----");
        };
        cv3.activityColor = [UIColor colorWithRed:171.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1];
        [self.view addSubview:cv3];
        
        ASCountDownView *cv4 = [[ASCountDownView alloc] initWithFrame:CGRectMake(100, 200, 110, 32)];
        cv4.endTime = @"1536303048";
        cv4.type = TimeTypeCountdownEnd;
        cv4.endColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
        [self.view addSubview:cv4];
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
