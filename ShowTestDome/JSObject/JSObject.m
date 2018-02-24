//
//  JSObject.m
//  XingLiIM
//
//  Created by Mjwon on 2017/1/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "JSObject.h"

@implementation JSObject

-(NSString *)getAccessToken
{
    NSString *token = @"0d6ef5aa-f16b-4ba6-9839-8788759d15ff";
//    token = @"";
    NSLog(@"token的值为:%@",token);
    return token;
}


-(void)setTitle:(NSString *)title{

    if (self.block) {
        self.block(title);
    }
}

@end
