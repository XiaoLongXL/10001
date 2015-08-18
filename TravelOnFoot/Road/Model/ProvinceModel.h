//
//  ProvinceModel.h
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject

@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *keyword;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *province;
@property(nonatomic,strong)NSString *trail_count;
@property(nonatomic,strong)NSString *region;


+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
