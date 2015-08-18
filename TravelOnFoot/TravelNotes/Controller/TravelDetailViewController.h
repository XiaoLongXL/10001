//
//  TravelDetailViewController.h
//  Travel3
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "DetailHeadModel.h"
#import "BaseTableViewController.h"

@interface TravelDetailViewController : BaseTableViewController
{
    DetailHeadModel *headModel;
    CGFloat  proportion;
}

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
