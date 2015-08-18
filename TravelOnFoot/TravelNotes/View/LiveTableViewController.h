//
//  LiveTableViewController.h
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "LiveTableViewCell.h"
#import "Header.h"
#import "AFNetworking.h"
#import "LiveModel.h"
#import "TravelDetailViewController.h"
#import "MJRefresh.h"
@interface LiveTableViewController : BaseTableViewController
{
    NSString *aa;
    NSInteger totalPages;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *pictersArray;
@property(nonatomic,assign)NSInteger currentPage;

@end
