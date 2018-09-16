//
//  FoldingSectionHeader.h
//  YUFoldingTableViewDemo
//
//  Created by Mjwon on 2016/12/21.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoldingSectionHeader;
typedef void(^SectionHeaderClick)(FoldingSectionHeader *view);

typedef NS_ENUM(NSUInteger, FoldingSectionState) {
    
    FoldingSectionStateFlod, // 折叠
    FoldingSectionStateShow, // 打开
};

@interface FoldingSectionHeader : UIView

@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) UIImage *image;
@property (nonatomic ,strong) UIColor *titleColor;
@property (nonatomic, assign) FoldingSectionState sectionState;

@property (nonatomic ,copy) SectionHeaderClick headerClick;

@end
