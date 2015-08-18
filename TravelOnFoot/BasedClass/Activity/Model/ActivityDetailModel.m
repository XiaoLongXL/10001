//
//  ActivityDetailModel.m
//  Travel3
//
//  Created by xiaolong on 15/7/29.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ActivityDetailModel.h"

@implementation ActivityDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


//
//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    [super setValue:value forKey:key];
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
//    
//}



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
    ActivityDetailModel *pro = [[ActivityDetailModel alloc] initWithDic:dic];
    return pro;
}

@end
