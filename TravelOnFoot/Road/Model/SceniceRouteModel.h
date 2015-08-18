//
//  SceniceRouteModel.h
//  Travel3
//
//  Created by lanou on 15/7/26.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SceniceRouteModel : NSObject

@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *tagIcon;


@property(nonatomic,strong)NSString *sceniceName;
@property(nonatomic,strong)NSString *sceniceAddress;
@property(nonatomic,strong)NSString *mainDetail;


@property(nonatomic,strong)NSString *crowdsName;
@property(nonatomic,strong)NSString *crowdsCount;

@property(nonatomic,strong)NSString *trail_score;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *nickname;


@property(nonatomic,strong)NSString *specialCover;
@property(nonatomic,strong)NSString *specialAvatar;
@property(nonatomic,strong)NSString *specialNickname;
@property(nonatomic,strong)NSString *specialStart_date;
@property(nonatomic,strong)NSString *specialPhoto_number;
@property(nonatomic,strong)NSString *specialTotal_days;
@property(nonatomic,strong)NSString *specialEnd_date;

@property(nonatomic,strong)NSString *correlationName;
@property(nonatomic,strong)NSString *correlationCover;

@property(nonatomic,strong)NSString *createdDate;



@end
