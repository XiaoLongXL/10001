//
//  ActivityTableViewCell.h
//  GZSMyDouBan
//
//  Created by xiaolong on 15/6/27.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityCellFrame ;
#import "ActivitiesModel.h"
@interface ActivityTableViewCell : UITableViewCell

    

@property(nonatomic,strong)ActivitiesModel * model;
@property(nonatomic,assign)NSInteger cellheight;

+(instancetype)cellWithTableView:(UITableView *)tabelView ;
 
@end
