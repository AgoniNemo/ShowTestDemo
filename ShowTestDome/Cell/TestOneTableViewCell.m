//
//  TestOneTableViewCell.m
//  ShowTestDome
//
//  Created by Mjwon on 2017/3/2.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "TestOneTableViewCell.h"
#import "PrefixHeader.pch"

@implementation TestOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat width = 60;
        CGFloat height = 20;
        CGFloat y = (75-height)/2;
        CGFloat x = (nScreenWidth()-width)/2;
        self.test = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        
        self.test.backgroundColor = [UIColor colorWithRed:(115)/255.0f green:(202)/255.0f blue:(130)/255.0f alpha:1];
        [self.contentView addSubview:self.test];
    }
    return self;
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.test.backgroundColor = [UIColor colorWithRed:(115)/255.0f green:(202)/255.0f blue:(130)/255.0f alpha:1];
}
//这个方法在用户按住Cell时被调用
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    self.test.backgroundColor = [UIColor colorWithRed:(115)/255.0f green:(202)/255.0f blue:(130)/255.0f alpha:1];
}


@end
