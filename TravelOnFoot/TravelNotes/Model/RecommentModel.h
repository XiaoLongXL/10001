//
//  RecommentModel.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentModel : NSObject

@property(nonatomic,strong)NSDictionary *created_by;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * cover;
@property(nonatomic,assign)NSInteger trail_id;
@property(nonatomic,assign)NSInteger view_count;
@property(nonatomic,strong)NSString *photo_number;
@property(nonatomic,strong)NSString *start_date;
@property(nonatomic,strong)NSString *destination;
@property(nonatomic,strong)NSString *comment_count;
@property(nonatomic,strong)NSString *total_days;
@property(nonatomic,assign)NSInteger fav_count;
@property(nonatomic,strong)NSString *ID;

+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
