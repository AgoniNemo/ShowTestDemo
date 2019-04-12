//
//  NSString+FileHandlePath.m
//  ShowTestDome
//
//  Created by Nemo on 2019/4/12.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "NSString+FileHandlePath.h"

@implementation NSString (FileHandlePath)
+ (NSString *)tempFilePathWithFileName:(NSString *)name {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:name];
}

+ (NSString *)tempFilePathWithUrlString:(NSString *)urlString{
    NSString *name = [[urlString componentsSeparatedByString:@"/"] lastObject];
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:name];
}

+ (NSString *)cacheFilePathWithName:(NSString *)name{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cacheFolderPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/Moment_Videos/%@",name]];
    return cacheFolderPath;
}

+ (NSString *)cacheFilePathWithUrlString:(NSString *)urlString{
    NSString *name = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cacheFolderPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/Moment_Videos/%@",name]];
    return cacheFolderPath;
}

+ (NSString *)fileNameWithUrlString:(NSString *)url{
    return [[url componentsSeparatedByString:@"/"] lastObject];
}
@end
