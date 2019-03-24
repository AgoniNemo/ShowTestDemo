//
//  VideoModel.h
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL isPlay;

@end
