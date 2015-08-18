//
//  XLViewController.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/6/27.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "XLViewController.h"
#import "XLNavigationViewController.h"
#import "TravelNotesViewController.h"
#import "RoadViewController.h"
#import "WeatherTableTableViewController.h"
#import "ActivityTableViewController.h"
#import "SKSplashIcon.h"
#import "SKSplashView.h"
#import "AFNetworkReachabilityManager.h"
#import "UserControllerTableViewController.h"

@interface XLViewController ()
@property (strong, nonatomic) SKSplashView *splashView;

@end

@implementation XLViewController


- (void)viewDidLoad {
    // [UIApplication sharedApplication].statusBarHidden = YES;
    [super viewDidLoad];
    //[UIApplication sharedApplication].statusBarStyle   = UIStatusBarStyleLightContent;
    // [UIApplication s]
    //    self.navigationController.navigationBar.hidden = YES;
    [self pingSplash];
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self setNeedsStatusBarAppearanceUpdate];
    
    [self customSubviewController];
    
    [self performSelector:@selector(setupReachabilityManager) withObject:nil afterDelay:5.1];
    
}
- (void) pingSplash
{    
    SKSplashIcon *pingSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"yuan.jpg"] animationType:SKIconAnimationTypePing];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:pingSplashIcon backgroundColor:[UIColor whiteColor] animationType:SKSplashAnimationTypeBounce];
    _splashView.animationDuration = 5.0f;
    [self.view addSubview:_splashView];
    [_splashView startAnimation];
    
}
-(void)customSubviewController
{
    ActivityTableViewController * actVC = [[ActivityTableViewController alloc]init];
    [self addChildViewController:actVC title:@"活动" imageName:@"activity32" selectedImageName:@"activity32L"];
    
    TravelNotesViewController * movieVC = [[TravelNotesViewController alloc]init];
//    [self addChildViewController:movieVC title:@"游记" imageName:@"travelNotes32" selectedImageName:@"travelNotes32L.png"];
    [self addChildViewController:movieVC title:@"游记" imageName:@"travelNotes32L.png" selectedImageName:@"travelNotes32L.png"];
    RoadViewController * cinemaVC = [[RoadViewController alloc]init];
    [self addChildViewController:cinemaVC title:@"路线" imageName:@"route32" selectedImageName:@"route32L"];
    
    
    
    UserControllerTableViewController * weatherVC = [[UserControllerTableViewController alloc]init];
    [self addChildViewController:weatherVC title:@"我的" imageName:@"user" selectedImageName:@"userL"];
    
    self.tabBar.barTintColor = [UIColor colorWithRed:230 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.5];
    self.tabBar.tintColor = [UIColor orangeColor];
    
    
}
-(void)addChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{   //标题
    controller.title = title  ;
    //图片
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //导航
    XLNavigationViewController * naVC = [[XLNavigationViewController alloc]initWithRootViewController:controller];
    //    naVC.navigationBar.translucent = NO;
    [self addChildViewController:naVC];
    
    
}
-(void)setupReachabilityManager
{
    AFNetworkReachabilityManager * maneger = [AFNetworkReachabilityManager sharedManager];
    [maneger startMonitoring];
    __weak XLViewController * VC = self;
    [maneger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [VC showAlertViewWithTitle:@"提示" message:@"无网络,请检查网络设置" cancelButtonTitle:@"确定" otherButtonTitle:nil];
                break;
            }
            case AFNetworkReachabilityStatusUnknown:{
                [VC showAlertViewWithTitle:@"提示" message:@"链接未知网络" cancelButtonTitle:@"确定" otherButtonTitle:nil];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
//                [VC showAlertViewWithTitle:@"提示" message:@"正在使用WiFi" cancelButtonTitle:@"确定" otherButtonTitle:nil];
                 break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
//                [VC showAlertViewWithTitle:@"提示" message:@"正在使用手机流量" cancelButtonTitle:@"确定" otherButtonTitle:nil];
                
                break;
            }
            default:
                
                break;
                
        }
    }];
}
//显示alertView
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
    
    return alertView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
