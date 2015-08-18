//
//  RouteSubjectListViewController.h
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RouteSubjectListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tab;
    NSInteger totalpages;
}


@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,strong)NSMutableArray *arrayWeb;
@property(nonatomic,strong)NSString *HeadTilte;

@end
