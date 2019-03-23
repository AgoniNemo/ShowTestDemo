//
//  ImageVideoViewViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "ImageVideoViewViewController.h"
#import "Carousel.h"

@interface ImageVideoViewViewController ()

@end

@implementation ImageVideoViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片和视频的轮播";
    self.view.backgroundColor = [UIColor whiteColor];
    /**
    *http://www.w3school.com.cn/example/html5/mov_bbb.mp4
    *http://59.80.44.95/clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
    *https://gcs-vimeo.akamaized.net/exp=1553341421~acl=%2A%2F623685558.mp4%2A~hmac=e166701a05d0129b30c58f13cb6843067558cce9ae0d67edf8ff13c69c2951d3/vimeo-prod-skyfire-std-us/01/2670/7/188350983/623685558.mp4
     */
    /**
     测试  数组首位为视频播放的地址，其余为本地图片，可根据实际需要进行更改
     **/
    Carousel *carousel = [Carousel scrollViewFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44, self.view.frame.size.width, 300) imageStringGroup:@[@"http://59.80.44.95/clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", @"1", @"2", @"3"]];
    [self.view addSubview:carousel];
    
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
