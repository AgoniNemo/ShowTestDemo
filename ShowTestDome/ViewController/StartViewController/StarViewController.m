//
//  StarViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/6/1.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "StarViewController.h"
#import "NMRatingControl.h"

@interface StarViewController ()

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NMRatingControl *coloredRatingControl = [[NMRatingControl alloc] initWithLocation:self.view.center emptyColor:[UIColor grayColor] solidColor:[UIColor redColor] andMaxRating:5];
    [self.view addSubview:coloredRatingControl];
    
    coloredRatingControl.rating = 5;
    
    //    little_stars_pressed
    coloredRatingControl.editingChangedBlock = ^(NSUInteger rating){
        NSLog(@"%ld",rating);
        
    };
    
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
