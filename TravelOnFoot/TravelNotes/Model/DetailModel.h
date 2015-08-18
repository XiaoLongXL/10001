//
//  DetailModel.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

//@property(nonatomic,strong)NSDictionary *posts;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *day;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *lng;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *fav_count;
@property(nonatomic,strong)NSString *comment_count;
@property(nonatomic,assign)int is_like;
@property(nonatomic,strong)NSArray *pictures;



+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
