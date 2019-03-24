//
//  VideoListViewController.m
//  ShowTestDome
//
//  Created by Nemo on 2019/3/23.
//  Copyright © 2019年 Nemo. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoListCell.h"
#import "VideoModel.h"

@interface VideoListViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataSource;
@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoListCell" bundle:nil]
         forCellReuseIdentifier:@"VideoListCellId"];
    
    [self loadNewData];
}
-(void)loadNewData {
    
    for (int i = 0 ; i < 9; i ++) {
        VideoModel *model = [[VideoModel alloc] init];
        model.isPlay = (i == 0);
        model.url = @"http://59.80.44.95/clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoListCellId" forIndexPath:indexPath];
    cell.model = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 根据Cell位置隐藏并暂停播放
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewEndScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ( !decelerate ) {
        [self scrollViewEndScroll:scrollView];
    }
}

- (void)scrollViewEndScroll:(UIScrollView *)scrollView {
    // do something ...
    NSLog(@"滑动结束!");
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 273;
    }
    return _tableView;
}
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
