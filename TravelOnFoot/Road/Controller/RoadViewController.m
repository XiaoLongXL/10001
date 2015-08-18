//
//  RoadViewController.m
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RoadViewController.h"
#import "BaseTableViewController.h"
#import "RouteViewController.h"
#import "subjectViewController.h"
#import "XLTool.h"

@interface RoadViewController ()

@property(nonatomic,strong)subjectViewController * segementView;
@property(nonatomic,strong)RouteViewController * collectView;
@property (nonatomic,strong)UISegmentedControl * segmentControl;

@end

@implementation RoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutSegmentView];
    
    
}
-(void)layoutSegmentView
{
    self.segementView = [[subjectViewController alloc]init];
    self.collectView = [[RouteViewController alloc]init];
    //    self.collectView.backgroundColor = [UIColor grayColor];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:@[@"特色",@"路线大全"]];
    self.segmentControl = segment;

    
    segment.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 30);
    segment.center = CGPointMake(self.view.frame.size.width/2, 32);
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.navigationItem setTitleView:segment];
    segment.selectedSegmentIndex = 0 ;
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self addChildViewController:self.segementView];
    [self addChildViewController:self.collectView];
    self.segementView.view.frame = self.view.bounds;
    [self.view addSubview:self.segementView.view];
    
}


-(void)segmentAction:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex ==0) {
        [self.view addSubview:self.segementView.view];
        [self.collectView.view removeFromSuperview];
        
    }else {
        self.collectView.view.frame = CGRectMake(0, 0, widthScaleMakeAdaptationScreen(375), heightScaleMakeAdaptationScreen(667)-113);
        [self.view addSubview:self.collectView.view];
        [self.segementView.view removeFromSuperview];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }


@end
