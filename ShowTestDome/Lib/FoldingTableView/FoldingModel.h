//
//  FoldingModel.h
//  
//6
//  Created by Mjwon on 2016/12/20.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoldingModel : NSObject

@property (nonatomic ,strong) UIColor *bgColor;

@property (nonatomic ,strong) UIColor *titleColor;

@property (nonatomic ,strong) NSString *imageName;

@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,assign) BOOL state;

@end
