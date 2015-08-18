//
//  provinceRouteViewController.h
//  Travel3
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface provinceRouteViewController :BaseViewController <UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,strong)NSString *provinceStr;
@property(nonatomic,strong)NSString *headTitle;

@property(nonatomic,strong)NSMutableArray *provinceArray;

@end
