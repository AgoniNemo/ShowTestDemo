//
//  ActivityHeaderView.m
//  ShowTestDome
//
//  Created by Nemo on 2019/8/23.
//  Copyright © 2019 Nemo. All rights reserved.
//

#import "ActivityHeaderView.h"

@interface ActivityHeaderView()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UILabel *totalLb;
@property (nonatomic, strong) UIImage *pImage;
@end

@implementation ActivityHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl"]];
        [self addSubview:iv];
        iv.layer.borderWidth = 2.0;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.cornerRadius = 8;
        iv.layer.masksToBounds = YES;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.mas_height);
            make.left.mas_equalTo(24*i);
            make.centerY.equalTo(self);
        }];
        [_dataSource addObject:iv];
        if (i == 6) {
            UILabel *totalLb = [[UILabel alloc] init];
            totalLb.textColor = [UIColor whiteColor];
            totalLb.font = [UIFont systemFontOfSize:10];
            totalLb.textAlignment = NSTextAlignmentCenter;
            totalLb.backgroundColor = RGBACOLOR(34, 34, 34, .8);
            [iv addSubview:totalLb];
            self.totalLb = totalLb;
            [totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(iv);
            }];
        }
    }
    self.pImage = [UIImage imageNamed:@"girl"];
}
-(void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    for (int i = 0 ; i < _dataSource.count; i ++) {
        UIImageView *iv = _dataSource[i];
        if (i > datas.count-1) {
            iv.hidden = YES;
            continue;
        }
        iv.hidden = NO;
        NSString *url = [NSString stringWithFormat:@"%@",datas[i]];
        [iv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.pImage];
        if (datas.count > 7) {
            if (i > 6) {
                self.totalLb.hidden = NO;
                self.totalLb.text = [NSString stringWithFormat:@"+%ld",datas.count-_dataSource.count];
            }
        }else {
            self.totalLb.hidden = YES;
        }
    }
}

@end
