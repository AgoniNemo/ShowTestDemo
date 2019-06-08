//
//  UIView+Corners.m
//  CQ_App
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "UIView+Corners.h"

@implementation UIView (Corners)
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
- (void)makeRoundedCorner:(CGFloat)cornerRadius {
    CALayer *roundedlayer = [self layer];
    [roundedlayer setMasksToBounds:YES];
    [roundedlayer setCornerRadius:cornerRadius];
}

/**
 *  画Top阴影
 */
-(void)makeTopShadowWidth:(CGFloat)width {
    [self makeShadowFrame:CGRectMake(0, 0, width, 2) offset:CGSizeMake(0, -3) shadowOpacity:0.3];
}

/**
 *  画Top阴影
 *  shadowOpacity
 */
-(void)makeTopShadowWidth:(CGFloat)width shadowOpacity:(CGFloat)shadowOpacity {
    [self makeShadowFrame:CGRectMake(0, 0, width, 2) offset:CGSizeMake(0, -3) shadowOpacity:shadowOpacity];
}

/**
 *  画半角
 */
-(void)makeCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *stateLbPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *stateLayer = [[CAShapeLayer alloc] init];
    stateLayer.frame = self.bounds;
    stateLayer.path = stateLbPath.CGPath;
    self.layer.mask = stateLayer;

}


/**
 *  画阴影
 */
-(void)makeShadowFrame:(CGRect)frame offset:(CGSize)offset shadowOpacity:(CGFloat)shadowOpacity {

    CALayer *lineLy = [[CALayer alloc] init];
    lineLy.backgroundColor = [UIColor whiteColor].CGColor;
    lineLy.frame = frame;
    lineLy.shadowOffset = offset;
    lineLy.shadowColor = [UIColor lightGrayColor].CGColor;
    lineLy.shadowOpacity = shadowOpacity;
    [self.layer addSublayer:lineLy];
}

-(void)blurEffect{
    [self blurEffectWithStyle:UIBlurEffectStyleLight Alpha:0.9];
}

-(void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height);
    effectview.alpha = alpha;
    [self addSubview:effectview];
}

@end
