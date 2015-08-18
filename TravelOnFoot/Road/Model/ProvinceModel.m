//
//  ProvinceModel.m
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}



// 初始化方法
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)modelWithDic:(NSDictionary *)dic
{
    ProvinceModel *pro = [[ProvinceModel alloc] initWithDic:dic];
    return pro;
}



@end
