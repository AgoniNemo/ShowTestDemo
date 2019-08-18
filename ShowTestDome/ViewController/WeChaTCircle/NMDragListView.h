//
//  NMDragListView.h
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivitySceneItem.h"
#import "NMDragListViewConfiguration.h"

NS_ASSUME_NONNULL_BEGIN


@interface NMDragListView : UIView


- (instancetype)initWithFrame:(CGRect)frame configuration:(NMDragListViewConfiguration *)configuration;

/**
 *  获取所有item
 */
@property (nonatomic, strong, readonly) NSMutableArray *itemArray;


/**
 *  添加item
 * */
- (void)addItem:(ActivitySceneItem *)item;

/**
 *  添加多个item
 */
- (void)addItems:(NSArray<ActivitySceneItem *> * )items;

/**
 *  删除item
 */
- (void)deleteItem:(ActivitySceneItem *)item;

/**
 *  点击标签，执行Block
 */
@property (nonatomic, strong) void(^clickItemBlock)(ActivitySceneItem * __nullable item);

/**
 *  移除回调
 */
@property (nonatomic, strong) void(^deleteItemBlock)(ActivitySceneItem * __nullable item);

@end

NS_ASSUME_NONNULL_END
