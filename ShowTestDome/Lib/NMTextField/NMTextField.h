//
//  NMTextField.h
//  TestDemo
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TextTypeUser,
    TextTypePassword,
    TextTypeNormal,
    TextTypeunkown,
} TextFieldType;

@interface NMTextField : UIView

@property (nonatomic, strong) NSString *textName;

@property (nonatomic, strong) NSString *errInfo;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, assign) TextFieldType type;

@property (nonatomic, copy) void(^textFieldBlock)(NSString *text);;

@property(nonatomic) UIKeyboardType keyboardType;

@end


