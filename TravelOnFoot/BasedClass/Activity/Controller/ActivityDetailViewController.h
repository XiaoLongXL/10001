//
//  ActivityDetailViewController.h
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailModel.h"
#import "ActivitiesModel.h"
#import "BaseViewController.h"
@interface ActivityDetailViewController : BaseViewController
@property (nonatomic,strong) ActivityDetailModel * activityDetailModel;
@property (nonatomic,strong) ActivitiesModel * activitiesModel;
 @end
