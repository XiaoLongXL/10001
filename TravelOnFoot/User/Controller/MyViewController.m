//
//  MyViewController.m
//  LoveShopping
//
//  Created by 陈亚豪 on 15/4/23.
//  Copyright (c) 2015年 loveshopping.com. All rights reserved.
//

#import "MyViewController.h"
#import "MyView.h"
#import "XLTool.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    MyView * view = [[MyView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 70, 375, 667)];

    [self.view addSubview: view];
UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)dismiss:(UIBarButtonItem *)left
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:YES ];
}
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
