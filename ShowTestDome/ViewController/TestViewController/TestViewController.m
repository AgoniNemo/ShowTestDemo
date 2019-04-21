//
//  TestViewController.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/2/14.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "TestViewController.h"
#import "ShowLable.h"
#import "ChatImageView.h"
#import "TestModel.h"

typedef BOOL(^TimerBlock)(NSDate *date);
@interface TestViewController ()
@property (nonatomic ,strong) TimerBlock timerBlock;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
//    [self creatLeftBubble];
//    
//    [self creatRightBubble];
//
    [self createBubbon];
    
//    [self creatModel];
}
-(void)creatModel{

    TestModel *model = [[TestModel alloc] init];
    model.t_t1 = @"1";
    model.t_t2 = @"2";
    model.t_t3 = @"3";
    model.t_t4 = @"4";
    model.t_t5 = @"5";
    
}
-(void)createBubbon{

    UIImage *image = [UIImage imageNamed:@"6"];
    ChatImageView *imgV = [[ChatImageView alloc] init];
    imgV.maskImage = [UIImage imageNamed:@"im_bubble_bg_f"];
    imgV.contentImage = image;
    [self.view addSubview:imgV];
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_equalTo(330);
        make.center.equalTo(self);
    }];

}

-(void)creatRightBubble{
    
    CGFloat top = 24; // 顶端盖高度
    CGFloat bottom = 10; // 底端盖高度
    CGFloat left = 13; // 左端盖宽度
    CGFloat right = 13; // 右端盖宽度
    UIEdgeInsets capInsets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image = [UIImage imageNamed:@"1"];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 220, image.size.width/10, image.size.height/10)];
    
    imgV.image = [[UIImage imageNamed:@"chat_sender_bg"] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeTile];
    [self.view addSubview:imgV];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/10, image.size.height/10)];
    imageView.image = image;
//    imageView.layer.mask = imgV.layer;
    
//    CALayer *layer = imgV.layer;
//    layer.frame = imageView.bounds;
//    imageView.layer.mask = layer;
//    [imgV addSubview:imageView];
    
    
}

-(void)creatLeftBubble{
    
    CGFloat top = 24; // 顶端盖高度
    CGFloat bottom = 10; // 底端盖高度
    CGFloat left = 13; // 左端盖宽度
    CGFloat right = 13; // 右端盖宽度
    UIEdgeInsets capInsets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 35)];
    
    imgV.image = [[UIImage imageNamed:@"chat_receiver_bg"] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
//    imgV.backgroundColor = [UIColor redColor];
    [self.view addSubview:imgV];
}

-(BOOL)block{

    __block BOOL a = YES;
    self.timerBlock = ^(NSDate *date){
        
        return a;
    };
    
    return a;
}
-(void)lable{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, rect.size.width-20, 140)];
    label.text = @"品质审批任务-客诉管理改善方案审批-20170207-166";
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];

}
-(void)clicklable{

    CGRect rect = [UIScreen mainScreen].bounds;
    ShowLable *nextApproverLable = [[ShowLable alloc] initWithFrame:CGRectMake(0, 100,rect.size.width-20, 35)];
    nextApproverLable.title = @"下级审批人";
    nextApproverLable.subTitleFont = 17;
    nextApproverLable.type = ShowLableTypeClick;
    nextApproverLable.subTitleBgColor = [UIColor redColor];
    nextApproverLable.beginEditingAction = ^{
        NSLog(@"%s",__func__);
    };
    CGFloat diameter = 25;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(nextApproverLable.frame)-diameter-2, 5, diameter, diameter)];
    img.userInteractionEnabled = YES;
    img.backgroundColor = [UIColor redColor];
    [nextApproverLable addSubview:img];
    [self.view addSubview:nextApproverLable];


}
-(void)creatLable{

    CGRect rect = [UIScreen mainScreen].bounds;
    ShowLable *nextUserLable = [[ShowLable alloc] initWithFrame:CGRectMake(0, 100, rect.size.width-20, 35)];
    nextUserLable.title = @"下级审批人";
    nextUserLable.subTitle = @"fjiamnviejwalgnmeiwalfjaesnjgifawl";
    nextUserLable.subTitleFont = 16;
    nextUserLable.title = @"附加文件";
    nextUserLable.titleFont = 10;
    nextUserLable.beginEditingAction = ^{
        
        NSLog(@"%s",__func__);
    };
    [self.view addSubview:nextUserLable];
    
    NSNull *null = [NSNull null];
    NSString *modeUsDes = [NSString stringWithFormat:@"%@",null];
    NSLog(@"%@--%d",modeUsDes,[modeUsDes isEqualToString:@"<null>"]);

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
