//
//  NSString+regex.m
//  CQ_App
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NSString+regex.h"

static  NSString *mobileRegex    = @"^(\\+?61|0)4?2?\\d{8}$";
static  NSString *nickRegex      = @"^[a-z_A-Z0-9-.!@#$%\\\\^&*)(+={}\\[\\]/\",'<>~·`?:;|]{2,50}+$";
static  NSString *passwordRegex  = @"^[a-zA-Z0-9]{2,50}$";

@implementation NSString (regex)

- (BOOL)regexMatcheMobile {
    return [self regularJudgmentWithExpression:mobileRegex];
}
- (BOOL)regexMatchePassword {
    return [self regularJudgmentWithExpression:passwordRegex];
}
- (BOOL)regexMatcheNickname {
    return [self regularJudgmentWithExpression:nickRegex];
}
/**
 *  正则判断实现方法
 *
 *  @param expression 正则表达式
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regularJudgmentWithExpression:(NSString *)expression {
    NSPredicate *expressionTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    return [expressionTest evaluateWithObject:self];
}

@end
