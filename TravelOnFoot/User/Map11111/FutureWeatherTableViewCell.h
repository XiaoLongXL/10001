//
//  FutureWeatherTableViewCell.h
//  Travel3
//
//  Created by lanou on 15/8/3.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FutrreWeatherModel.h"
@interface FutureWeatherTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)UILabel *week;
@property(nonatomic,strong)UILabel *temperature;
@property(nonatomic,strong)UILabel *weather;
@property(nonatomic,strong)UILabel *weatherResource;
@property(nonatomic,strong)FutrreWeatherModel *model;
@end
