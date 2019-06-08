//
//  NSString+regex.h
//  CQ_App
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (regex)

/**
 *  判断字符串是否为合法手机号码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheMobile;

/**
 *  判断字符串是否为合法昵称
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatcheNickname;

/**
 *  判断字符串是否为合法密码
 *
 *  @return 判断结果YES/NO
 */
- (BOOL)regexMatchePassword;

@end

NS_ASSUME_NONNULL_END
