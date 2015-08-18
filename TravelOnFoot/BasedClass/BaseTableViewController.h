//
//  BaseTableViewController.h
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseTableViewController : UITableViewController
@property (nonatomic,strong) MBProgressHUD * hud;  //loading
- (void)showHint:(NSString *)hint ;
@end
