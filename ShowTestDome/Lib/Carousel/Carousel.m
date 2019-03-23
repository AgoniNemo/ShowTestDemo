//
//  Carousel.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "Carousel.h"
#import "VideoView.h"

@interface Carousel ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) VideoView *videoView;

@end

@implementation Carousel

+ (instancetype)scrollViewFrame:(CGRect)frame imageStringGroup:(NSArray *)imgArray {
    Carousel *carousel = [[self alloc] initWithFrame:frame];
    carousel.contentArray = imgArray;
    return carousel;
}

- (void)setContentArray:(NSArray *)contentArray {
    _contentArray = contentArray;
    [self loadUI];
}

- (void)loadUI {
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.contentArray.count, self.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    for (NSInteger index = 0; index < self.contentArray.count; index ++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * index, 0, self.frame.size.width, self.frame.size.height)];
        img.image = [UIImage imageNamed:self.contentArray[index]];
        /** 测试 **/
        if (index == 0) {
            self.videoView = [VideoView videoViewFrame:img.frame videoUrl:self.contentArray[index]];
            self.videoView.videoUrl = self.contentArray[index];
            [self.scrollView addSubview:self.videoView];
        }else {
            [self.scrollView addSubview:img];
        }
    }
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    self.pageControl.numberOfPages = self.contentArray.count;
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = round(scrollView.contentOffset.x / self.frame.size.width);
    self.pageControl.currentPage = currentPage;
    
    if (self.videoView.isPlay) {
        if (currentPage == 0) {
            [self.videoView start];
        }else {
            [self.videoView stop];
        }
    }
    
}

@end
