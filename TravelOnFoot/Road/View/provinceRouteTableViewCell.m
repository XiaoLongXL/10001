//
//  provinceRouteTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "provinceRouteTableViewCell.h"
#import "XLTool.h"

@implementation provinceRouteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createMycell];
    }
    return self;
}


// 初始化需要的控件， 并且添加到cell中
-(void)createMycell
{
    // 只进行初始化操作
    self.mainView = [[UIView alloc] init];
    [self.contentView addSubview:self.mainView];
    
    self.imagev = [[UIImageView alloc] init];
    [self.mainView addSubview:self.imagev];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.mainView addSubview:self.nameLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    [self.mainView addSubview:self.addressLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 这里指定坐标
    self.mainView.frame = CGRectMakeAdaptationScreen(10, 10, 355, 220);
    self.mainView.backgroundColor = [UIColor colorWithRed:191 / 255.0 green:200 / 255.0 blue:226 / 255.0 alpha:1];
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.masksToBounds = YES;
    
    self.nameLabel.frame = CGRectMakeAdaptationScreen(5, 0, 170, 30);
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:widthScaleMakeAdaptationScreen(20)];
    self.nameLabel.textColor = [UIColor purpleColor];
    
    self.addressLabel.frame = CGRectMakeAdaptationScreen(170, 0, 190, 30);
    self.addressLabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.font = [UIFont boldSystemFontOfSize:widthScaleMakeAdaptationScreen(14)];
    
    self.imagev.frame = CGRectMakeAdaptationScreen(0, 30, 355, 190);
    self.imagev.backgroundColor = [UIColor redColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
