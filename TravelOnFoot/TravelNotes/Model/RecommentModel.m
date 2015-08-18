//
//  RecommentModel.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RecommentModel.h"

@implementation RecommentModel

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
        //KVC
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 实现类方法
+(instancetype)modelWithDic:(NSDictionary *)dic
{
    RecommentModel *model = [[RecommentModel alloc] initWithDic:dic];
    return model;
}


@end
