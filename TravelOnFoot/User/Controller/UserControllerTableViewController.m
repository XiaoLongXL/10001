//
//  UserControllerTableViewController.m
//  Travel3
//
//  Created by xiaolong on 15/8/4.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "UserControllerTableViewController.h"
#import "UserTableViewCell.h"
#import "WeatherTableTableViewController.h"
#import "MyCollectTableViewController.h"
#import "MyViewController.h"
#import "WebViewController.h"
@interface UserControllerTableViewController ()
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)NSMutableArray * arrayName;

@end

@implementation UserControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray arrayWithObjects:@"我的收藏",@"我的天气",@"我的地图",@"关于我们",nil];
    self.arrayName = [NSMutableArray arrayWithObjects:@"shoucang.jpg",@"tianqi.jpg",@"ditu.jpg",@"women.jpg",nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = self.view.frame.size.height/5;
    
    
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
    
     return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    UserTableViewCell * cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qwq"];
//    [UserTableViewCell cellWithTableView:tableView];
    CGFloat aa = self.view.frame.size.height/5;
     NSString *str = self.arrayName[indexPath.row];
    cell.Myimagview.image = [UIImage imageNamed:str];
    cell.Myimagview.frame = CGRectMake(10, 10, 100, aa-20);
    cell.Mytitle.text = self.array[indexPath.row];
    cell.Mytitle.frame = CGRectMake(140, 10, 100, aa-20);
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            MyCollectTableViewController * my = [[MyCollectTableViewController alloc]init];
            [self animation];
            [self.navigationController  pushViewController:my animated:YES];
            
        }
             
            break;
        case 1:{
            WeatherTableTableViewController * weather = [[WeatherTableTableViewController alloc]init];
            [self animation];
            [self.navigationController  pushViewController:weather animated:YES];
        }
            
            break;
        case 2:{
            WebViewController * weather = [[WebViewController alloc]init];
            [self animation];
            [self.navigationController  pushViewController:weather animated:YES];
            
            }
            
            break;
        case 3:{
            MyViewController * weather = [[MyViewController alloc]init];
            [self animation];
            [self.navigationController  pushViewController:weather animated:YES];
            
            }
            
            break;
        default:
            break;
    }
}
-(void)animation
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    //            animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
