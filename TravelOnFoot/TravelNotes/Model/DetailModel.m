//
//  DetailModel.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }else if([key isEqualToString:@"description"]){
        self.descriptions = value;
    }
}
// 初始化方法
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //KVC
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 实现类方法
+(instancetype)modelWithDic:(NSDictionary *)dic
{
    DetailModel *model = [[DetailModel alloc] initWithDic:dic];
    return model;
}

@end
