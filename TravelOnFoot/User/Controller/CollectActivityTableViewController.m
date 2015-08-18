//
//  CollectActivityTableViewController.m
//  TravelOnFoot
//
//  Created by lanou on 15/8/5.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "CollectActivityTableViewController.h"
#import "ActivitiesModel.h"
#import "XLTool.h"
@interface CollectActivityTableViewController ()

@end

@implementation CollectActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionTravel *tool = [[CollectionTravel alloc] init];
    self.collectArray = [NSMutableArray array];
    [self.collectArray addObjectsFromArray:[tool getActivityCollection]];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.editButtonItem setTitle:@"编辑"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [tool deleteWithActivityTitle:s];
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
    CollectionTravel *tool = [[CollectionTravel alloc]init];
    NSString *title = [self.collectArray objectAtIndex:indexPath.row];
    NSString *ID = [tool searchActivityData:[self.collectArray objectAtIndex:indexPath.row]];
    NSString *des = [tool searchActivityDestinationData:[self.collectArray objectAtIndex:indexPath.row]];
    ActivitiesModel * model = [[ActivitiesModel alloc]init];
    model.ID = ID;
    model.destination = des;
    model.title = title;
    ActivityDetailViewController * detail = [[ActivityDetailViewController alloc]init];
    detail.activitiesModel = model;
    
    
    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:detail];
    UITabBarController * tabBar = [[UITabBarController alloc]init];
    [tabBar addChildViewController:navc];
    
//    detail.hidesBottomBarWhenPushed = YES;

    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController presentViewController:tabBar animated:YES completion:nil];
    
    
    }

@end
