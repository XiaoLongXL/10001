//
//  ActivityDetailModel.h
//  Travel3
//
//  Created by xiaolong on 15/7/29.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JKDBModel.h"
//
//@interface ActivityDetailModel : JKDBModel
//#import "JKDBModel.h"

@interface ActivityDetailModel : NSObject
//@property (nonatomic,strong) NSString * comment_count;
@property (nonatomic,strong) NSMutableArray * tag;
@property (nonatomic,strong) NSMutableArray * pictures;

@property (nonatomic,assign) NSInteger activity_status;
@property (nonatomic,strong) NSString * trail_id;
@property (nonatomic,strong) NSString * min_cost; //费用
@property (nonatomic,strong) NSString * max_cost;
@property (nonatomic,assign) BOOL is_favorite;
@property (nonatomic,assign) BOOL is_hot;
@property (nonatomic,assign) BOOL isreg;

@property (nonatomic,strong) NSDictionary * club;
@property (nonatomic,strong) NSString * city;//出发地

@property (nonatomic,strong) NSString  * cover;//图像

@property (nonatomic,strong) NSString * ID;              //活动id

@property (nonatomic,assign) NSInteger  start_time;
@property (nonatomic,assign) NSInteger member_count;


@property (nonatomic,strong) NSString * canreg;
@property (nonatomic,strong) NSString * days; //总共天数


+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
