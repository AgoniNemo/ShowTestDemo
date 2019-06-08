//
//  XZCScrollView.h
//
//  Created by Nemo on 16/2/19.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rect [UIScreen mainScreen].bounds

@interface XZCScrollView : UIScrollView
@property (nonatomic,weak) UIViewController *viewController;
@property (nonatomic,strong) NSArray *viewControllers;
@end
