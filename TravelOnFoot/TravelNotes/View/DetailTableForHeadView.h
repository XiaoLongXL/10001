//
//  DetailTableForHeadView.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailHeadModel.h"

@interface DetailTableForHeadView : UIView
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *cover;
@property(nonatomic,strong)UIImageView *avatar;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *start_date;
@property(nonatomic,strong)DetailHeadModel *model;

@end
