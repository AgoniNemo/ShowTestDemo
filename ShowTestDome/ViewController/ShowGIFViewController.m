//
//  ShowGIFViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/3/28.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ShowGIFViewController.h"
#import <FLAnimatedImage.h>

@interface ShowGIFViewController ()

@end

@implementation ShowGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FLAnimatedImageView *imageV = [[FLAnimatedImageView alloc] init];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"IMG_0069" ofType:@"GIF"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    imageV.animatedImage = image;
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
