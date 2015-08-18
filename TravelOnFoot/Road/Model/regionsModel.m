//
//  regionsModel.m
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "regionsModel.h"
//#import "ProvinceModel.h"

@implementation regionsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
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

// 实现类方法
+(instancetype)modelWithDic:(NSDictionary *)dic
{
    regionsModel *rm = [[regionsModel alloc] initWithDic:dic];
    return rm;
}


@end
