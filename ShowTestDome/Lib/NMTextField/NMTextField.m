//
//  NMTextField.m
//  TestDemo
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NMTextField.h"
#import <ReactiveObjC.h>
#import "TextField.h"

typedef enum : NSUInteger {
    FieldTypeNormal,
    FieldTypeInput,
    FieldTypeErr,
} FieldType;

#define INPUTCOLOR  [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]
#define NORMALCOLOR [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
#define ERRCOLOR [UIColor colorWithRed:250/255.0 green:100/255.0 blue:0/255.0 alpha:1.0]
@interface NMTextField()<UITextFieldDelegate>
@property (nonatomic, weak) TextField *textField;
@property (nonatomic, weak) UILabel *tipLb;
@property (nonatomic, weak) UILabel *errInfoLb;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, assign) FieldType fieldType;
@end

@implementation NMTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrame];
    NSLog(@"--%@--",[self class]);
    
}

#pragma --mark textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"开始");
    [self setColor:INPUTCOLOR];
    if (self.errInfoLb.hidden == NO) {
        self.errInfoLb.hidden = YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"结束");
    if (textField.text.length == 0) {
        [self setColor:NORMALCOLOR];
    }
}


- (void)changeProcAction:(UIButton *)btn {
    self.textField.secureTextEntry = btn.selected;
    btn.selected = !btn.selected;
    NSString *name = btn.selected ? @"m_eye_open":@"m_eye_close";
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateHighlighted];
}

-(void)setFieldType:(FieldType)fieldType {
    _fieldType = fieldType;
    switch (fieldType) {
        case FieldTypeNormal: {
            [self setColor:NORMALCOLOR];
        }
            break;
        case FieldTypeInput: {
            [self setColor:INPUTCOLOR];
        }
            break;
        case FieldTypeErr: {
            [self setColor:ERRCOLOR];
        }
            break;
        default:
            break;
    }
}

- (void)setColor:(UIColor *)color {
    self.textField.textColor = color;
    self.line.backgroundColor = color;
    self.errInfoLb.textColor = color;
}

- (void)updateFrame {
    
    CGFloat textFW = self.bounds.size.width;
    CGFloat textFX = 0;
    if (self.type == TextTypeUser) {
        textFX = 30;
        textFW -= 30;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLb.frame)-1, 30, 40)];
        lb.text = @"+61";
        lb.textColor = INPUTCOLOR;
        [self addSubview:lb];
    }else if (self.type == TextTypePassword) {
        UIButton *proclaimedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proclaimedBtn.frame = CGRectMake(self.mj_size.width-24, CGRectGetMaxY(self.tipLb.frame), 24, 24);
        [proclaimedBtn setImage:[UIImage imageNamed:@"m_eye_close"] forState:UIControlStateNormal];
        [proclaimedBtn setImage:[UIImage imageNamed:@"m_eye_close"] forState:UIControlStateHighlighted];
        [proclaimedBtn addTarget:self action:@selector(changeProcAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:proclaimedBtn];
        textFW -= 24;
    }
    self.textField.frame = CGRectMake(textFX, CGRectGetMaxY(self.tipLb.frame), textFW, 40);
    if (@available(iOS 12.0, *)) {
        //Xcode 10 适配
        self.textField.textContentType = UITextContentTypePostalCode;
        //非Xcode 10 适配
        self.textField.textContentType = @"one-time-code";
    }
}

#pragma --mark set data

-(void)setErrInfo:(NSString *)errInfo {
    _errInfo = errInfo;
    self.errInfoLb.text = errInfo;
    self.errInfoLb.hidden = NO;
    [self setColor:ERRCOLOR];
}
-(void)setTextName:(NSString *)textName {
    _textName = textName;
    self.tipLb.text = textName;
}
-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}
-(void)setType:(TextFieldType)type {
    _type = type;
    _textField.secureTextEntry = (_type == TextTypePassword);
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}
#pragma --mark SET UI

- (void)setup {
    TextField *textField = [[TextField alloc] init];
    textField.delegate = self;
    textField.tintColor = INPUTCOLOR;
    [self addSubview:textField];
    self.textField = textField;
    WeakSelf
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (weakSelf.textFieldBlock) {
            weakSelf.textFieldBlock(x);
        }
    }];
    
    [self addSubview:self.line];
    
    
    UILabel *errInfoLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-18, self.bounds.size.width, 18)];
    errInfoLb.font = [UIFont systemFontOfSize:12];
    errInfoLb.hidden = YES;
    errInfoLb.textColor = ERRCOLOR;
    [self addSubview:errInfoLb];
    self.errInfoLb = errInfoLb;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-23, self.bounds.size.width, 2)];
    line.backgroundColor = NORMALCOLOR;
    [self addSubview:line];
    self.line = line;
}
-(UILabel *)tipLb {
    if (_tipLb == nil) {
        UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 14)];
        tipLb.font = [UIFont systemFontOfSize:12];
        [self addSubview:tipLb];
        _tipLb = tipLb;
    }
    return _tipLb;
}
-(void)dealloc {
    NSLog(@"%@ 释放!",[self class]);
}


@end
