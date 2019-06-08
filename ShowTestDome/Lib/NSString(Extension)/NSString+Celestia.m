//
//  NSString+Celestia.m
//  CQ_App
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSString+Celestia.h"

@implementation NSString (Celestia)

- (NSString *)distanceFormat {
    
    NSString *text = @"";
    CGFloat distance = [self doubleValue];
    
    if (distance < 500) {
        text = @"<500M";
    }else if (distance > 500 && distance < 1000){
        text = [NSString stringWithFormat:@"%.fM",distance];
    }else if (distance >= 1000){
        text = [NSString stringWithFormat:@"%.fKM",distance/1000];
    }
    
    return text;
}

@end
