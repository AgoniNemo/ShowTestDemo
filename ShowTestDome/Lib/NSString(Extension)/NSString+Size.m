//
//  NSString+Size.m
//  CQ_App
//
//  Created by Nemo on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGFloat)heightForMaxWidth:(CGFloat)maxWidth fontSize:(CGFloat)fontSize{
    
    return [self sizeForMaxWidth:maxWidth maxHeight:CGFLOAT_MAX font:[UIFont systemFontOfSize:fontSize]].height;
}

-(CGFloat)heightForMaxWidth:(CGFloat)maxWidth font:(UIFont *)font{
    return [self sizeForMaxWidth:maxWidth maxHeight:CGFLOAT_MAX font:font].height;
}
-(CGFloat)widthForMaxHeight:(CGFloat)maxHeight fontSize:(CGFloat)fontSize{
    
    return [self sizeForMaxWidth:CGFLOAT_MAX maxHeight:maxHeight font:[UIFont systemFontOfSize:fontSize]].width;
}

-(CGFloat)widthForMaxHeight:(CGFloat)maxHeight font:(UIFont *)font {
    return [self sizeForMaxWidth:CGFLOAT_MAX maxHeight:maxHeight font:font].width;
}

-(CGSize)sizeForMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight font:(UIFont *)font
{
    CGSize textBlockMinSize = {maxWidth, maxHeight};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    
    if (systemVersion >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];//调整行间距，默认为0
        size = [self boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle
                                               }
                                     context:nil].size;
    }else{
        size = [self sizeWithFont:font
                   constrainedToSize:textBlockMinSize
                       lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}

@end
