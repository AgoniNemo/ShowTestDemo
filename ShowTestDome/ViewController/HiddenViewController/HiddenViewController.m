//
//  HiddenViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/11/15.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "HiddenViewController.h"
#import "CollectionViewCell.h"
#import "UIViewController+Hidden.h"

@interface HiddenViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView * collectionView;

@end

@implementation HiddenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置代理显示与隐藏
    self.navigationController.delegate = self;
}
-(void)setup {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = self.view.size;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.decelerationRate = 0.8;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [collectionView registerNib:[UINib nibWithNibName:CollectionViewCell.className
                                               bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CollectionViewCellId"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellId" forIndexPath:indexPath];
    cell.titleLb.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

// 松手时还在运动, 先调用scrollViewDidEndDragging,在调用scrollViewDidEndDecelerating
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"========scrollViewDidEndDecelerating");

}


@end
