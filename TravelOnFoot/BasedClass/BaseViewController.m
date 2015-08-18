//
//  BaseViewController.m
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "BaseViewController.h"
//#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;

    self.view.backgroundColor = [UIColor whiteColor];
//    [self layoutSegmentView];
    [self  setupProgressHud];
}
//设置loading
- (void)setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.detailsLabelText = @"加载中";

    [self.view addSubview:_hud];
    
//    [_hud show:YES];
}
//提示框
- (void)showHint:(NSString *)hint  {
    //显示提示信息
    //UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    //  hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

//-(void)layoutSegmentView
//{
//    self.segementView1 = [[BaseTableViewController alloc]init];
//    self.segementView2 = [[BaseTableViewController alloc]init];
//    self.segementView2.tableView.backgroundColor = [UIColor grayColor];
//    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:@[@"徒",@"线"]];
//    self.segmentControl = segment;
////    segment.tintColor = [UIColor redColor];
////    segment.s
//    
//    segment.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 30);
//    segment.center = CGPointMake(self.view.frame.size.width/2, 32);
//    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    [self.navigationItem setTitleView:segment];
//    segment.selectedSegmentIndex = 0 ;
//    segment.tintColor = [UIColor whiteColor];
//    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//    [self addChildViewController:self.segementView1];
//    [self addChildViewController:self.segementView2];
//    self.segementView1.tableView.frame = self.view.bounds;
//    [self.view addSubview:self.segementView1.tableView];
//    
//}
//-(void)segmentAction:(UISegmentedControl*)segment
//{
//    if (segment.selectedSegmentIndex ==0) {
//        [self.view addSubview:self.segementView1.tableView];
//        [self.segementView2.tableView removeFromSuperview];
//    }else {
//        self.segementView2.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        [self.view addSubview:self.segementView2.tableView];
//        [self.segementView1.tableView removeFromSuperview];
//    }
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
