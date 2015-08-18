//
//  RouteSubjectListTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteSubjectListTableViewCell.h"

#import "XLTool.h"
#import "RouteSubjectList.h"
@implementation RouteSubjectListTableViewCell

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
    // 只进行初始化
    
    self.imagev = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imagev];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressLabel];
    
    self.addressImagev = [[UIImageView alloc] init];
    [self.contentView addSubview:self.addressImagev];
    
    self.scoreImagev = [[UIImageView alloc] init];
    [self.contentView addSubview:self.scoreImagev];
    
    self.scoreLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.scoreLabel];
    
    self.scoreCountLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.scoreCountLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.descriptionLabel];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 这里定坐标
    
    self.imagev.frame = CGRectMakeAdaptationScreen(10, 30, 180, 120);
    self.imagev.backgroundColor = [UIColor yellowColor];
    
    self.nameLabel.frame = CGRectMakeAdaptationScreen(10, 0, 280, 30);
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:widthScaleMakeAdaptationScreen(20)];
    self.nameLabel.textColor = [UIColor redColor];
    
    self.addressLabel.frame = CGRectMakeAdaptationScreen(225, 40, 150, 20);
    self.addressLabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.font = [UIFont boldSystemFontOfSize:widthScaleMakeAdaptationScreen(14)];
    
    self.addressImagev.frame = CGRectMakeAdaptationScreen(200, 40, 20, 20);
    self.addressImagev.image = [UIImage imageNamed:@"address"];
    
    
    self.scoreImagev.frame = CGRectMakeAdaptationScreen(200, 70, 20, 20);
    self.scoreImagev.image = [UIImage imageNamed:@"score"];
    
    
    self.scoreLabel.frame = CGRectMakeAdaptationScreen(225, 70, 150, 20);
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:widthScaleMakeAdaptationScreen(14)];
    
    self.scoreCountLabel.frame = CGRectMakeAdaptationScreen(225, 100, 150, 20);
    self.scoreCountLabel.font = [UIFont boldSystemFontOfSize:widthScaleMakeAdaptationScreen(14)];
    
    self.descriptionLabel.frame = CGRectMakeAdaptationScreen(10, 160, 355, 100);
    self.descriptionLabel.font =  [UIFont systemFontOfSize:widthScaleMakeAdaptationScreen(15)];
    self.descriptionLabel.numberOfLines = 1000;
    [self.descriptionLabel sizeToFit];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
