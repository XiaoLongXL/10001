//
//  MyCollectTableViewController.m
//  TravelOnFoot
//
//  Created by lanou on 15/8/5.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "MyCollectTableViewController.h"
#import "ViewController.h"
#import "CollectTravelTableViewController.h"
#import "CollectActivityTableViewController.h"
#import "XLTool.h"
@interface MyCollectTableViewController ()

@end

@implementation MyCollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = [NSMutableArray arrayWithObjects:@"活动收藏",@"游记收藏",@"路线收藏", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(60);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            CollectActivityTableViewController *activity = [[CollectActivityTableViewController alloc]init];
            [self.navigationController pushViewController:activity animated:YES];
        }
            break;
        case 1:
        {
            CollectTravelTableViewController *travel = [[CollectTravelTableViewController alloc]init];
            [self.navigationController pushViewController:travel animated:YES];
 
        }
            break;
        case 2:
        {
            ViewController *rout = [[ViewController alloc]init];
            [self.navigationController pushViewController:rout animated:YES];
        }
        default:
            break;
    }
}





@end
