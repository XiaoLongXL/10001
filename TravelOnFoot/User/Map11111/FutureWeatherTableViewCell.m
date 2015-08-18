//
//  FutureWeatherTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/8/3.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "FutureWeatherTableViewCell.h"
#import "XLTool.h"

@implementation FutureWeatherTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatMyCell];
    }
    return self;
}

-(void)creatMyCell
{
//    self.contentView.backgroundColor = [UIColor colorWithRed:234/255.0 green:249/255.0 blue:210/255.0 alpha:1];
    self.week = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(10, 10, 120, 25)];
    self.week.textAlignment = NSTextAlignmentLeft;
    self.week.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(15)];
    [self.contentView addSubview:self.week];
    
    self.date = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(10, 35, 120, 25)];
    self.date.textAlignment = NSTextAlignmentLeft;
    self.date.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(15)];
    [self.contentView addSubview:self.date];
    
    self.temperature = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(160, 5, 200, 30)];
    self.temperature.textAlignment = NSTextAlignmentRight;
    self.temperature.font = [UIFont boldSystemFontOfSize:heightScaleMakeAdaptationScreen(17)];
    [self.contentView addSubview:self.temperature];
    
    self.weather = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(160, 35, 200, 30)];
    self.weather.textAlignment = NSTextAlignmentRight;
    self.weather.font = [UIFont boldSystemFontOfSize:heightScaleMakeAdaptationScreen(17)];
    [self.contentView addSubview:self.weather];
    
    
}
-(void)setModel:(FutrreWeatherModel *)model
{
    _model = model;
    self.week.text = model.week;
    self.date.text = model.date;
    self.temperature.text = model.temperature;
    self.weather.text = model.weather;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
