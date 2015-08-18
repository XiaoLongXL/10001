//
//  WeatherTableHeaderView.h
//  Travel3
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherTableHeaderModel.h"
@interface WeatherTableHeaderView : UIView

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *Logo;
@property(nonatomic,strong)UILabel *temp;
@property(nonatomic,strong)UILabel *temperature;
@property(nonatomic,strong)UILabel *weather;
@property(nonatomic,strong)UILabel *wind;
@property(nonatomic,strong)UILabel *dressing_advice;
@property(nonatomic,strong)UILabel *date_y;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *city;
@property(nonatomic,strong)UILabel *weatherResource;

@property(nonatomic,strong)WeatherTableHeaderModel *headerModel;
@end
