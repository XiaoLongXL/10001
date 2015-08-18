//
//  RouteTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteTableViewCell.h"
#import "XLTool.h"

@implementation RouteTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createMycell];
    }
    return self;
}


-(void)createMycell
{
    // 这里只进行初始化
    self.routeView = [[UIView alloc] init];
    [self.contentView addSubview:self.routeView];
    
    self.imagev = [[UIImageView alloc] init];
    [self.routeView addSubview:self.imagev];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    // 这里定坐标
    self.routeView.frame = CGRectMakeAdaptationScreen(10, 10, 355, 200);
    self.routeView.backgroundColor = [UIColor clearColor];
    self.routeView.layer.cornerRadius = 6;
    self.routeView.layer.masksToBounds = YES;
    
    self.imagev.frame = CGRectMakeAdaptationScreen(0, 10, 355, 190);
    self.imagev.backgroundColor = [UIColor clearColor];
    self.imagev.layer.cornerRadius = 6;
    self.imagev.layer.masksToBounds = YES;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
