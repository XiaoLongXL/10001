//
//  TravelNotesViewController.m
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "TravelNotesViewController.h"
#import "LiveTableViewController.h"
#import "RecommentTableViewController.h"
@interface TravelNotesViewController ()
@property(nonatomic,strong)LiveTableViewController * segementView1;
@property(nonatomic,strong)RecommentTableViewController * segementView2;
@property (nonatomic,strong)UISegmentedControl * segmentControl;

@end

@implementation TravelNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutSegmentView];
    
    
}
-(void)layoutSegmentView
{
    self.segementView1 = [[LiveTableViewController alloc]init];
    self.segementView2 = [[RecommentTableViewController alloc]init];
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:@[@"实况游记",@"值得一看"]];
    self.segmentControl = segment;
    //    segment.tintColor = [UIColor redColor];
    
    
    segment.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 30);
    segment.center = CGPointMake(self.view.frame.size.width/2, 32);
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.navigationItem setTitleView:segment];
    segment.selectedSegmentIndex = 0 ;
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        [self addChildViewController:self.segementView1];
        [self addChildViewController:self.segementView2];
    self.segementView1.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.segementView2.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.segementView2.tableView.contentInset = UIEdgeInsetsMake(0, 0, heightScaleMakeAdaptationScreen(120), 0);
    [self.view addSubview:self.segementView1.tableView];
    
}
-(void)segmentAction:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex ==0) {
        [self.view addSubview:self.segementView1.tableView];
        [self.segementView2.tableView removeFromSuperview];
    }else {
        
        [self.view addSubview:self.segementView2.tableView];
        [self.segementView1.tableView removeFromSuperview];
    }
    
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
