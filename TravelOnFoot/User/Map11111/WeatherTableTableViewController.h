 //
//  WeatherTableTableViewController.h
//  Travel3
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "WeatherTableHeaderModel.h"

 @interface WeatherTableTableViewController : UITableViewController<UITextFieldDelegate>
{
    UITextField *tf;
    WeatherTableHeaderModel *headerModel;
    NSInteger time;
//    NSString *ip;
//    NSString *cityName;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) MBProgressHUD * hud;
@end
