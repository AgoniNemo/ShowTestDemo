//
//  FoldingTableView.h
//  
//
//  Created by Mjwon on 2016/12/21.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoldingTableView;
@protocol FoldingTableViewDelegate <NSObject>

- (NSInteger )numberOfSectionForFoldingTableView:(FoldingTableView *)tableView;

- (CGFloat )foldingTableView:(FoldingTableView *)tableView heightForHeaderInSection:(NSInteger )section;

- (CGFloat )foldingTableView:(FoldingTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger )foldingTableView:(FoldingTableView *)tableView numberOfRowsInSection:(NSInteger )section;

- (UITableViewCell *)foldingTableView:(FoldingTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

-(void)foldingSectionHeaderClickAtIndex:(NSInteger)index;

- (UIImage *)foldingTableView:(FoldingTableView *)tableView arrowImageForSection:(NSInteger )section;

- (NSString *)foldingTableView:(FoldingTableView *)tableView titleForHeaderInSection:(NSInteger )section;

- (NSString *)foldingTableView:(FoldingTableView *)tableView descriptionForHeaderInSection:(NSInteger )section;

- (UIColor *)foldingTableView:(FoldingTableView *)tableView backgroundColorForHeaderInSection:(NSInteger )section;

- (UIColor *)clickBackgroundColor;
- (UIColor *)clickHeaderTitleColor;

- (UIFont *)foldingTableView:(FoldingTableView *)tableView fontForTitleInSection:(NSInteger )section;


- (UIFont *)foldingTableView:(FoldingTableView *)tableView fontForDescriptionInSection:(NSInteger )section;


- (UIColor *)foldingTableView:(FoldingTableView *)tableView textColorForTitleInSection:(NSInteger )section;

- (UIColor *)foldingTableView:(FoldingTableView *)tableView textColorForDescriptionInSection:(NSInteger )section;


@end

@interface FoldingTableView : UITableView

@property (nonatomic, weak) id<FoldingTableViewDelegate> foldingDelegate;

@end
