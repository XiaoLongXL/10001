//
//  regionsModel.h
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface regionsModel : NSObject

@property(nonatomic,strong)NSMutableArray *province;
@property(nonatomic,strong)NSString *region;
@property(nonatomic,strong)NSMutableArray *ProvinceModelArray;


+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
