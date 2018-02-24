//
//  TestModel.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/3/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation TestModel

-(instancetype)init
{
    if (self = [super init]) {
        [self objc];
    }
    return self;
}
-(void)objc{
    
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if(aSelector == @selector(xxx)) {
        return NSClassFromString(@"TestModel");
    }
    return [super forwardingTargetForSelector:aSelector];
}
-(void)xxx{


}
@end
