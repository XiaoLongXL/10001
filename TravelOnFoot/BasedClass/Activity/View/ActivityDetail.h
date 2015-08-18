//
//  ActivityDetail.h
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailModel.h"
#import "ActivitiesModel.h"
@interface ActivityDetail : UIView
/*详情页面的模型*/
@property (nonatomic,strong)ActivityDetailModel *  activityDetailModel;
/*上个页面的模型*/
@property (nonatomic,strong)ActivitiesModel * activitiesModel;

@property(nonatomic,strong) UINavigationBar * navigationBar;
@property(nonatomic,strong) UITabBar * tabBar;
@property(nonatomic,strong) UIBarButtonItem * item;

- (instancetype)initWithFrame:(CGRect)frame activityDetailModel:(ActivityDetailModel*)activityDetailModel activitiesModel:(ActivitiesModel*)activitiesModel;
@end
