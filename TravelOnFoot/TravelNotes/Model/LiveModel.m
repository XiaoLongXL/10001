//
//  LiveModel.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
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
    LiveModel *model = [[LiveModel alloc] initWithDic:dic];
    return model;
}

@end
