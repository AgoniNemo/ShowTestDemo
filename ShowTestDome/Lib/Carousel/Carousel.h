//
//  Carousel.h
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Carousel : UIView

@property (nonatomic, strong) NSArray *contentArray;

+ (instancetype)scrollViewFrame:(CGRect)frame imageStringGroup:(NSArray *)imgArray;

@end
