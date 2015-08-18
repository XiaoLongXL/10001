//
//  subjectViewController.h
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteTableViewCell.h"
#import "SubjectRoute.h"
#import "RouteSubjectListViewController.h"
#import "BaseViewController.h"

@interface subjectViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tab;
    NSMutableArray *subjectArray;
}

@end
