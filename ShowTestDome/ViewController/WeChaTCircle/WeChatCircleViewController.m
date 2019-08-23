//
//  WeChatCircleViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/18.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "WeChatCircleViewController.h"
#import "NMDragListView.h"

@interface WeChatCircleViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) NMDragListView *dragItemList;
@end

@implementation WeChatCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
}
-(void)setup {
    ActivitySceneItem *item = [[ActivitySceneItem alloc] init];
    item.isAdd = YES;
    
    // 创建标签列表
    NMDragListView *dragItemList = [[NMDragListView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 0) configuration:[NMDragListViewConfiguration defaultConfiguration]];
    self.dragItemList = dragItemList;
    dragItemList.backgroundColor = [UIColor clearColor];
    // 高度可以设置为0，会自动跟随标题计算
    [dragItemList addItem:item];
    
    __weak typeof(self) weakSelf = self;
    
    [dragItemList setClickItemBlock:^(ActivitySceneItem *item) {
        if (item.isAdd) {
            NSLog(@"添加");
            [weakSelf showUIImagePickerController];
        }
    }];
    
    /**
     * 移除tag 高度变化，得重设
     */
    dragItemList.deleteItemBlock = ^(ActivitySceneItem *item) {
        ActivitySceneItem *lastItem = [weakSelf.dragItemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                ActivitySceneItem *item = [[ActivitySceneItem alloc] init];
                item.backgroundColor = [UIColor clearColor];
                item.image = [UIImage imageNamed:@"add_image"];
                item.isAdd = YES;
                [weakSelf.dragItemList addItem:item];
            }
        });
    };
    
    [self.view addSubview:dragItemList];
}
#pragma mark - UIImagePickerController
- (void)showUIImagePickerController{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        ActivitySceneItem *item = [[ActivitySceneItem alloc] init];
        item.image = image;
        item.backgroundColor = [UIColor purpleColor];
        [self.dragItemList addItem:item];
    }];
}

@end
