//
//  ThemeButton.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/31.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "ThemeButton.h"

@interface ThemeButton()
@property (nonatomic, weak) CALayer *sLayer;
@end

@implementation ThemeButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
     NSLog(@"--%@--",NSStringFromCGRect(self.frame));
}
- (void)setFrame:(CGRect)frame {
    NSLog(@"======");
    self.layer.shadowOffset = CGSizeMake(0,4);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    self.layer.cornerRadius = 13;
    self.layer.shadowColor = RGBACOLOR(230, 47, 92, 0.1).CGColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
