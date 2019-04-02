//
//  TMeButton.h
//  ShowTestDome
//
//  Created by Nemo on 2019/4/2.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMeButton : UIView

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^buttonClick)(void);


@end
