//
//  JSObject.h
//  XingLiIM
//
//  Created by Mjwon on 2017/1/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSExportDelegate.h"

typedef void(^JSObjectBlack)(id);
@interface JSObject : NSObject<JSExportDelegate>

@property (nonatomic ,copy) JSObjectBlack block;

@end
