//
//  WeatherTableHeaderView.m
//  Travel3
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "WeatherTableHeaderView.h"
#import "XLTool.h"

@implementation WeatherTableHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createdMyView];
    }
    return self;
}


-(void)createdMyView
{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 270)];
    backView.image = [UIImage imageNamed:@"Weatherbeijing.jpg"];
    [self addSubview:backView];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 270)];
    self.imageView.alpha = 0.2;
    self.imageView.image = [UIImage imageNamed:@"0"];
    [backView addSubview:self.imageView];
   
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 22; i++) {
        NSString *name = [NSString stringWithFormat: @"%d",i];
        UIImage *image = [UIImage imageNamed:name];
        [array addObject:image];
    }
    self.imageView.animationImages = array;
    self.imageView.animationDuration = 2;
    self.imageView.animationRepeatCount = LONG_MAX;
    [self.imageView startAnimating];

    
    
    
    
    //当前温度
    self.temp = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 10, 100, 20)];
    self.temp.font = [UIFont boldSystemFontOfSize:heightScaleMakeAdaptationScreen(23)];
    [self addSubview:self.temp];
    
    //当天温度区间
    self.temperature = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 40, 200, 20)];
    self.temperature.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.temperature];
    //天气情况
    self.weather = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 70, 200, 20)];
    self.weather.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.weather];
    
    //风向和风力
    self.wind = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 100, 200, 20)];
    self.wind.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.wind];
    
    //发布日期 /星期几
    self.date_y = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 130, 200, 20)];
    self.date_y.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.date_y];
    
    //穿着建议
    self.dressing_advice = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 160, 300, 40)];
    self.dressing_advice.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    self.dressing_advice.numberOfLines = 0;
    [self addSubview:self.dressing_advice];
    
    //发布时间
    self.time = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 210, 200, 20)];
    self.time.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.time];
    
    self.Logo = [[UIImageView alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 240, 20, 20)];
    self.Logo.image = [UIImage imageNamed:@"weizhi"];
    [self addSubview:self.Logo];
    
    
    self.city = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(50, 240, 200, 20)];
    self.city.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    [self addSubview:self.city];
    
    self.weatherResource = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(375 - 120, 240, 100, 20)];
    self.weatherResource.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    self.weatherResource.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.weatherResource];
}

-(void)setHeaderModel:(WeatherTableHeaderModel *)headerModel
{
    _headerModel = headerModel;
    self.temp.text = headerModel.temp;
    self.temperature.text = headerModel.temperature;
    self.weather.text = headerModel.weather;
    self.wind.text = headerModel.wind;
    self.date_y.text = headerModel.date_y;
    self.time.text = headerModel.time;
    self.city.text = headerModel.city;
    self.dressing_advice.text = [NSString stringWithFormat:@"穿着建议:%@",headerModel.dressing_advice];
    if (headerModel != nil) {
        self.weatherResource.text = @"全国天气预报";
        
    }
//    if ([self.weather.text containsString:@"阴"]) {
//      self.weatherLogo.image = [UIImage imageNamed:@"qingtian"];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
