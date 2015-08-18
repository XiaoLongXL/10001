//
//  ActivitiesModel.h
//  Travel3
//
//  Created by xiaolong on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JKDBModel.h"
//@interface ActivitiesModel : JKDBModel

@interface ActivitiesModel : NSObject

@property (nonatomic,strong) NSString * destination;
@property (nonatomic,strong) NSMutableArray * tag;
@property (nonatomic,assign) NSInteger activity_status;
@property (nonatomic,strong) NSString * trail_id;
@property (nonatomic,strong) NSString * min_cost; //费用
@property (nonatomic,strong) NSString * max_cost;
@property (nonatomic,strong) NSString * period_desc;

@property (nonatomic,strong) NSDictionary * club;
@property (nonatomic,strong) NSString * city;//出发地

@property (nonatomic,strong) NSString  * cover;//图像

@property (nonatomic,strong) NSString * ID;              //活动id
@property (nonatomic,strong) NSString * id;              //活动id

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSString * canreg;
@property (nonatomic,strong) NSString * days; //总共天数

//+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
