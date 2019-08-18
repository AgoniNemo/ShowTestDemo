//
//  ActivitySceneItem.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "ActivitySceneItem.h"

@implementation ActivitySceneItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
    if (isAdd) {
        self.backgroundColor = RGBCOLOR(249, 249, 249);
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.image = [UIImage imageNamed:@"public_media_add"];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
