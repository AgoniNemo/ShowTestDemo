//
//  UIView+Animation.m
//  CQ_App
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)shakeAnimationTranslationX {
    [self shakeAnimationPath:@"transform.translation.x" fromValue:-3 toValue:3 duration:0.07 count:2];
}

- (void)shakeAnimationTranslationY {
    [self shakeAnimationPath:@"transform.translation.y" fromValue:-5 toValue:5 duration:0.25 count:3];
}

- (void)shakeAnimationPath:(NSString *)path fromValue:(CGFloat)fValue toValue:(CGFloat)toValue duration:(CGFloat)duration count:(CGFloat)count{
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:path];
    shakeAnimation.fromValue = [NSNumber numberWithFloat:fValue];
    shakeAnimation.toValue = [NSNumber numberWithFloat:toValue];
    shakeAnimation.autoreverses = YES;
    // 设置时间
    [shakeAnimation setDuration:duration];
    // 设置次数
    [shakeAnimation setRepeatCount:count];
    [self.layer addAnimation:shakeAnimation forKey:nil];
}
@end
