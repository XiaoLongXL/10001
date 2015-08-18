//
//  ViewController.m
//  Travel3
//
//  Created by lanou on 15/8/3.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ViewController.h"

#import "CollectionTool.h"
#import "ScenicSpotIntroductionViewController.h"
#import "XLTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    tab = [[UITableView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 667)];
//    tab.dataSource = self;
//    tab.delegate =self;
//    [self.view addSubview:tab];
    CollectionTool *tool = [[CollectionTool alloc] init];
    self.arrayRoute = [NSMutableArray array];
    [self.arrayRoute addObjectsFromArray:[tool getRouteCollection]];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.editButtonItem setTitle:@"编辑"];

    
    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(60);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayRoute count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    CollectionModel *coll = [[CollectionModel alloc] init];
    coll = [self.arrayRoute objectAtIndex:indexPath.row];
    cell.textLabel.text = coll.title;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotIntroductionViewController *forth = [[ScenicSpotIntroductionViewController alloc] init];
    CollectionModel *coll = [[CollectionModel alloc] init];
    coll = [self.arrayRoute objectAtIndex:indexPath.row];
    forth.idString = coll.str;
    forth.idString2 = coll.str2;
    forth.idString3 = coll.str3;
    forth.idString4 = coll.str4;
    forth.HeadTitle = coll.title;
    [self.navigationController pushViewController:forth animated:YES];
    
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
//        NSString *string = [self.arrayRoute objectAtIndex:indexPath.row];
         CollectionModel *coll = [self.arrayRoute objectAtIndex:indexPath.row];
        CollectionTool *tool = [[CollectionTool alloc] init];
         [tool deleteWithRouteTitle:coll.title];
        //先删除数组中的元素
        [self.arrayRoute removeObjectAtIndex:indexPath.row];
        // 再删除掉这个cell
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    
}

// 控制移动的方法
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 首先取到要移动的内容
    NSString *str = [self.arrayRoute objectAtIndex:sourceIndexPath.row];
    // 删掉原来的数据
    [self.arrayRoute removeObjectAtIndex:sourceIndexPath.row];
    // 移动到新的位置
    [self.arrayRoute insertObject:str atIndex:destinationIndexPath.row];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }


@end
