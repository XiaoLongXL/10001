//
//  CollectTravelTableViewController.m
//  TravelOnFoot
//
//  Created by lanou on 15/8/5.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "CollectTravelTableViewController.h"
#import "XLTool.h"
@interface CollectTravelTableViewController ()

@end

@implementation CollectTravelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionTravel *tool = [[CollectionTravel alloc] init];
    self.collectArray = [NSMutableArray array];
    [self.collectArray addObjectsFromArray:[tool getTravelCollection]];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.editButtonItem setTitle:@"编辑"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.collectArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(60);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.textLabel.text = [self.collectArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    // 开启tableview的编辑模式
    [self.tableView setEditing:editing animated:animated];
}


// 控制编辑的代理方法
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 删除按钮上的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



// 是否允许移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 编辑模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除
    return  UITableViewCellEditingStyleDelete;
    
}


// 控制删除（具体的删除过程在里面）
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 首先判断是否删除模式
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CollectionTravel *tool = [[CollectionTravel alloc]init];
        NSString *s = [self.collectArray objectAtIndex:indexPath.row];
        [tool deleteWithTravelTitle:s];
        //先删除数组中的元素
        [self.collectArray removeObjectAtIndex:indexPath.row];
        // 再删除掉这个cell
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    
}

// 控制移动的方法
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 首先取到要移动的内容
    NSString *str = [self.collectArray objectAtIndex:sourceIndexPath.row];
    // 删掉原来的数据
    [self.collectArray removeObjectAtIndex:sourceIndexPath.row];
    // 移动到新的位置
    [self.collectArray insertObject:str atIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TravelDetailViewController *detailViewController = [[TravelDetailViewController alloc]init];
    CollectionTravel *tool = [[CollectionTravel alloc]init];
//    NSLog(@"%@",[self.collectArray objectAtIndex:indexPath.row]);
    NSString *ID = [tool searchData:[self.collectArray objectAtIndex:indexPath.row]];
    detailViewController.ID = ID;
//    NSLog(@"%@",ID);
    detailViewController.hidesBottomBarWhenPushed = YES;
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
