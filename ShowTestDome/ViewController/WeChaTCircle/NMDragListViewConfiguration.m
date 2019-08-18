//
//  NMDragListViewConfiguration.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "NMDragListViewConfiguration.h"

@implementation NMDragListViewConfiguration

+(instancetype)defaultConfiguration {
    NMDragListViewConfiguration *conf =[[NMDragListViewConfiguration alloc] init];
    conf.itemMargin = 6;
    conf.itemListCols = 4;
    conf.scaleItemInSort = 1;
    conf.isFitItemListH = YES;
    conf.showDeleteView = YES;
    conf.deleteViewHeight = 50.0;
    conf.maxItem = 9;
    conf.isSort = YES;
    return conf;
}

@end
