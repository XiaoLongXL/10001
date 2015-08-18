//
//  provinceSelf-adaptionTableviewcell.m
//  Travel3
//
//  Created by lanou on 15/7/27.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "provinceSelf-adaptionTableviewcell.h"
#import "XLTool.h"

@implementation provinceSelf_adaptionTableviewcell


// 重写初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createMycell];
    }
    return self;
}


// 初始化需要的控件 并且添加到cell中
-(void)createMycell
{
    // 只进行初始化方法操作
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressLabel];
    
    self.imagevAddress = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imagevAddress];
    
    self.mainDetail = [[UILabel alloc] init];
    [self.contentView addSubview:self.mainDetail];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    // 这里定坐标
    self.titleLabel.frame = CGRectMakeAdaptationScreen(3, 0, 200, 40);
    self.titleLabel.backgroundColor = [UIColor redColor];
    
    self.addressLabel.frame = CGRectMakeAdaptationScreen(25, 40, 300, 20);
    self.addressLabel.font = [UIFont boldSystemFontOfSize:12];
    self.addressLabel.backgroundColor = [UIColor redColor];
    
    self.imagevAddress.frame = CGRectMakeAdaptationScreen(3, 40, 20, 20);
    self.imagevAddress.image = [UIImage imageNamed:@"address"];
    
    
    self.mainDetail.frame = CGRectMakeAdaptationScreen(3, 60, 369, 100);
    self.mainDetail.backgroundColor = [UIColor greenColor];
    self.mainDetail.font = [UIFont boldSystemFontOfSize:15];
    // 让label自适应， cell手动增加高度
    self.mainDetail.numberOfLines = 100000;
    CGRectGetMaxY(_mainDetail.frame) ;
    [self.mainDetail sizeToFit];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
