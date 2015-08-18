//
//  XLNavigationViewController.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/6/27.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "XLNavigationViewController.h"

@interface XLNavigationViewController ()

@end

@implementation XLNavigationViewController

//第一次his用这个类的时候调用一次
+(void)initialize
{
    //1.设置导航栏主题
    [self customNavBarTheme];
    // 2.设置导航栏 按钮 主题
//    [self customNavBarButtonItem];
    
}

// 2.设置导航栏 按钮 主题
+(void)customNavBarButtonItem
{
//    UIBarButtonItem * item = [UIBarButtonItem appearance];
//    
//        [item setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
////        [item setBackgroundImage:[UIImage imageWithName: @"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
////        [item setBackgroundImage:[UIImage imageWithName: @"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
//   
//    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
//    //颜色
//    textAttrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    //字体
//    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize: 28];
//    
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
}
//1.设置导航栏主题
+(void)customNavBarTheme
{
    //取出appearance
    UINavigationBar * navBar = [UINavigationBar appearance];
    //2.设置背景
            [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    navBar.barTintColor = [UIColor colorWithRed:23 / 255.0 green:164 / 255.0 blue:100 / 255.0 alpha:0.8];
    navBar.barTintColor = [UIColor colorWithRed:107 / 255.0 green:194 / 255.0 blue:53 / 255.0 alpha:0.8];

//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarAnimationFade;
    //3.标题属性
    NSMutableDictionary *  textAttrs = [NSMutableDictionary dictionary];
    //颜色
//    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //字体
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:21];
    
    //去阴影
    //    textAttrs[NSShadowAttributeName] = []
    [navBar setTitleTextAttributes:textAttrs];
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers>0) {
        self.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
 
    
}



//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    if (self.viewControllers>0) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//
//   
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
