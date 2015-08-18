
//  ActivityTableViewController.m
//  Travel3
//
//  Created by xiaolong on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Header.h"
#import "ActivityDetailViewController.h"
#import "ActivitiesModel.h"
#import "XLTool.h"
//#import "JSONKit.h"
//#import "XLNetworking.h"
#import "MJExtension.h"
#import "ActivityPhotoViewController.h"
@interface ActivityTableViewController ()

@property(nonatomic,assign)NSInteger cellheight;
@property (nonatomic,assign)NSInteger currentPage;
//@property(nonatomic,strong)NSCache * cellCache;
@property (nonatomic,assign)NSInteger total ;

//@property(nonatomic,strong) NSMutableDictionary *dict;

 @end

@implementation ActivityTableViewController
-(void)dealloc
{
    DLog(@"ActivityTableViewController aaaaaaaaaaaaaaaaa");
}

-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [XLTool barButtonItemWithIcon:@"activity32" highlighted:@"activity32L" target:self action:@selector(didClickChangeControllerButtonItem:)];
    self.currentPage = 1;
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    [self setupRefresh];

}

//显示alertView
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
     [alertView show];
    
    return alertView;
}

-(void)didClickChangeControllerButtonItem:(UIBarButtonItem*)item
{
    ActivityPhotoViewController * photoView = [[ActivityPhotoViewController alloc]init];
    photoView.array1 = self.dataArray ;
    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:photoView];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
     animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController presentViewController:navc animated:YES completion:nil];
}

- (void)setupRefresh
{

    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
#pragma mark 开始进入刷新状态
 - (void)headerRereshing
{
    [self sendRequest:kAPIActivity];
  
     // 刷新表格
//    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
 }
-(void)sendRequest:(NSString*)url
{
    [self.hud show:YES];
      [XLTool XLNetworkingRequestDateModelArrayFromURL:url successResponseObject:^(id responseObject) {
//        self.dataArray = [ActivitiesModel objectArrayWithKeyValuesArray:responseObject[@"activities"]];
//        self.total = [dict[@"total"] integerValue];
        [self saveDate:responseObject withKey:@"activity"];
        [self dataParse:responseObject];
        [self.hud hide:YES afterDelay:2];
    } failed:^(BOOL error) {
        
        [self dataParse:[self getDataWithKey:@"activity"]];
        [self.hud hide:YES afterDelay:2];

    }];

}

-(void)dataParse:(NSMutableDictionary*)responseObject
{
      self.total = [responseObject[@"total"] integerValue];
      NSMutableArray * array = [ActivitiesModel objectArrayWithKeyValuesArray:responseObject[@"activities"]];
    [self.dataArray removeAllObjects];
    self.dataArray = array;
    [self.tableView reloadData];
    
    if (self.dataArray.count) {
        [self.hud hide:YES afterDelay:1];
    }
}
-(NSString*)getFilePath
{
    //获得文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"activity1.archiver"];
    return filePath;
}
-(void)saveDate:(NSMutableDictionary *)dict withKey:(NSString*)key
{
    
    //1. 使用NSData存放归档数据
    NSMutableData *archiverData = [NSMutableData data];
    //2. 创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    //3. 添加归档内容 （设置键值对）
    [archiver encodeObject:dict forKey:key];
    //4. 完成归档
    [archiver finishEncoding];
    //5. 将归档的信息存储到磁盘上
    if ([archiverData writeToFile:[self getFilePath] atomically:YES]) {
//        DLog(@"archiver success---");
    }
    
}
-(NSMutableDictionary*)getDataWithKey:(NSString*)key
{
    //解归档
    //1. 从磁盘读取文件，生成NSData实例
    NSData *unarchiverData = [NSData dataWithContentsOfFile:[self getFilePath]];
    //2. 根据Data实例创建和初始化解归档对象
    NSKeyedUnarchiver *unachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    //3. 解归档，根据key值访问
    NSMutableDictionary *dic = [unachiver decodeObjectForKey:key];
    
    return dic;
}

- (void)footerRereshing
{
    self.currentPage+=1;
    NSInteger totalPage = self.total/20;
    if (self.currentPage <= totalPage) {
        NSString *urlString = [NSString stringWithFormat:KAPIActivityAppend,(long)self.currentPage];
        [self sendRequest:urlString];
        // 刷新表格
        [self.tableView reloadData];
    
    }else{
        self.currentPage = 1;
        NSString *urlString = [NSString stringWithFormat:KAPIActivityAppend,(long)self.currentPage];
        [self sendRequest:urlString];
        // 刷新表格
        [self.tableView reloadData];
        
    }

    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
    self.tableView.contentOffset = CGPointMake(0, 0);
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellheight;
 }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ActivityTableViewCell *cell   = [ActivityTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    cell.model = self.dataArray[indexPath.row];

    self.cellheight = cell.cellheight;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailViewController * detail = [[ActivityDetailViewController alloc]init];
    ActivitiesModel * ac = self.dataArray[indexPath.row];
    detail.activitiesModel = ac;

    UINavigationController * navc = [[UINavigationController alloc]initWithRootViewController:detail];
    UITabBarController * tabBar = [[UITabBarController alloc]init];
    [tabBar addChildViewController:navc];

    CATransition *animation = [CATransition animation];
    animation.duration =1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
//    animation.type = kCATransitionFade;
//    animation.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];

    [self.navigationController presentViewController:tabBar animated:YES completion:nil];
//    [self.navigationController pushViewController:detail animated:YES];
     }
@end
