//
//  BaseViewController.h
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#import "BaseTableViewController.h"

@interface BaseViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD * hud;  //loading

//设置loading
//- (void)setupProgressHud;

- (void)showHint:(NSString *)hint;

@end
