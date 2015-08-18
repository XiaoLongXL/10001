//
//  WBTool.m
//  508WB
//
//  Created by xiaolong on 15/5/15.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "WBTool.h"
#import "XLViewController.h"
#import "WBNewFeatureViewController.h"
#import "CollectionTool.h"
#import "CollectionTravel.h"
@implementation WBTool
+(void)chooseRootViewController
{
    NSString * key = @"CFBundleVersion";
    //取出沙盒中存储的上次使用的软件版本号
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * lastVersion = [defaults stringForKey:key];
    //获取当前版本号
    //    DLog(@"%@",[NSBundle mainBundle].infoDictionary);
    
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ( [currentVersion isEqualToString:lastVersion]) {
        
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XLViewController alloc]init];
        
    }else{
    
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WBNewFeatureViewController alloc]init];
        //存新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }

}
+(void)setupSqlite
{
// 一般在程序第一次启动时创建需要的数据库表
NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
// 先来获取firstStart对应的值  如果取到了说明程序已经运行过一次了
NSString *str = [de objectForKey:@"firstStart"];
if ([str isEqualToString:@"第一次启动"]) {
    // 不是第一次启动
//            DLog(@"不是第一次启动");
}else {
    // 是第一次启动
//            DLog(@"是第一次启动");
    [de setObject:@"第一次启动" forKey:@"firstStart"];
    // 完成数据库创建以及表格的创建
    CollectionTool *tool = [[CollectionTool alloc] init];
    [tool createRouteTable];
    CollectionTravel *travelTool = [[CollectionTravel alloc] init];
    [travelTool createTravelTable];
    [travelTool createActivityTable];
    
    
}
}

@end
