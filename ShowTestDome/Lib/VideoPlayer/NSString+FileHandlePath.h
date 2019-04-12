//
//  NSString+FileHandlePath.h
//  ShowTestDome
//
//  Created by Nemo on 2019/4/12.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileHandlePath)
/** 临时文件路径 */
+ (NSString *)tempFilePathWithFileName:(NSString *)name;
/**  临时文件路径 */
+ (NSString *)tempFilePathWithUrlString:(NSString *)urlString;

/** 缓存文件夹路径 */
+ (NSString *)cacheFilePathWithName:(NSString *)name;
/** 缓存文件夹路径 */
+ (NSString *)cacheFilePathWithUrlString:(NSString *)urlString;

/**  获取网址中的文件名 */
+ (NSString *)fileNameWithUrlString:(NSString *)url;
@end
