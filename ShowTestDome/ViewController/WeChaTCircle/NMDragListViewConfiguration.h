//
//  NMDragListViewConfiguration.h
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NMDragListViewConfiguration : NSObject

/**
 *  item间距,和距离左，上间距,默认10
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 *  是否需要自定义ItemList高度，默认为Yes
 */
@property (nonatomic, assign) BOOL isFitItemListH;

/**
 *  是否需要排序功能
 */
@property (nonatomic, assign) BOOL isSort;

/**
 *  在排序的时候，放大标签的比例，必须大于1
 */
@property (nonatomic, assign) CGFloat scaleItemInSort;

/******列表总列数 默认3列******/
/**
 *  item间距会自动计算
 */
@property (nonatomic, assign) NSInteger itemListCols;

/**
 *  显示拖拽到底部出现删除 默认yes
 */
@property (nonatomic, assign) BOOL showDeleteView;
/**
 *  DragItemBottomView 的高度 默认50
 */
@property (nonatomic, assign) CGFloat deleteViewHeight;

/**
 *  item列表的高度
 */
@property (nonatomic, assign) CGFloat itemListH;

/**
 *  item 最多个数 默认9个
 */
@property (nonatomic, assign) int maxItem;

+(instancetype)defaultConfiguration;

@end

NS_ASSUME_NONNULL_END
