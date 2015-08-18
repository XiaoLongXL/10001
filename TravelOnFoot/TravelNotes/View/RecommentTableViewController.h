//
//  RecommentTableViewController.h
//  Travel3
//
//  Created by lanou on 15/7/18.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "RecommentTableViewCell.h"
#import "RecommentModel.h"
#import "Header.h"
#import "AFNetworking.h"
#import "TravelDetailViewController.h"
#import "XLTool.h"
#import "MJRefresh.h"
@interface RecommentTableViewController : BaseTableViewController
{
    NSMutableArray *array;
    NSInteger totalPages;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger currentPage;
@end
