//
//  LiveTableViewController.m
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "LiveTableViewController.h"
#import "JSONKit.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
@interface LiveTableViewController ()
//@property(nonatomic,strong) NSMutableDictionary *dict;

@end

@implementation LiveTableViewController
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pictersArray = [NSMutableArray array];
//    self.dataArray = [NSMutableArray array];
 //刷新
//    self.dict = [NSMutableDictionary dictionary];

    [self RefreshData];
    
}

-(void)requestData:(NSString *)ip
{
    [self.hud show:YES];
//    [self showHint:@"正在加载...."];
    __weak LiveTableViewController * travel = self;
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [travel.hud hide:YES afterDelay:2];
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检测网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
//            travel.dict = ;
            [travel dataParse:[travel getDataWithKey:@"live"]];

            [alt show];
        }else{//网络没问题,开始请求数据
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer  = [AFJSONResponseSerializer serializer];
            [manager GET:ip parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSData *data = operation.responseData;
                if (data==nil) {
                    [travel.hud hide:YES afterDelay:2];
                    UIAlertView *alt1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据异常,请刷新" delegate:travel cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alt1 show];

                     return ;
                }
                NSMutableDictionary *dictionary = [data objectFromJSONData];
//                travel.dict = dictionary;
                [travel saveDate:dictionary withKey:@"live"];
                [travel dataParse:dictionary];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {                [travel.hud hide:YES];

            }];

        }
    }];
}
-(void)dataParse:(NSMutableDictionary*)dictionary
{
    NSMutableArray *array = [dictionary objectForKey:@"broadcasts"];
    totalPages = [[dictionary objectForKey:@"total_pages"] integerValue];
    self.pictersArray = array;
    
    NSMutableArray *arr = [NSMutableArray array];
    [self.dataArray removeAllObjects];
    for (NSDictionary *dic in array) {
        LiveModel *model = [LiveModel modelWithDic:dic];
        [arr addObject:model];
        self.dataArray = arr;
    }
    if (self.dataArray.count) {
        [self.hud hide:YES afterDelay:1];
    }
    [self.tableView reloadData];

}
-(NSString*)getFilePath
{
    //获得文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"live.archiver"];
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
//        DLog(@"archiver success--live-");
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell11";

    
       LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[LiveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    LiveModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.pictersArray = self.pictersArray;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return heightScaleMakeAdaptationScreen(320);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TravelDetailViewController *detailViewController = [[TravelDetailViewController alloc]init];
    LiveModel *model = [self.dataArray objectAtIndex:indexPath.row];
    detailViewController.ID = model.data[@"log"][@"id"];
    detailViewController.hidesBottomBarWhenPushed = YES;

    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect";
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
//刷新

- (void)RefreshData
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingHeader)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingHeader) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(RereshingFooter)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在帮你刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"正在帮你加载中";
}
#pragma mark 开始进入刷新状态
- (void)RereshingHeader
{
    self.currentPage = 1;
    [self requestData:kAPITravelLiveNotes];
    // 刷新表格
//        [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

- (void)RereshingFooter
{
    self.currentPage+=1;
    if (self.currentPage > totalPages) {
        self.tableView.footerRefreshingText = @"没有了";
        [self.tableView footerEndRefreshing];
    }else{
    NSString *newIp = [NSString stringWithFormat:kAPITravelLiveNotesAppend,(long)self.currentPage];
    [self requestData:newIp];
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
    self.tableView.contentOffset = CGPointMake(0, 0);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSLog(@"live-----");
//
//    [[SDImageCache sharedImageCache] clearMemory];
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
//    
////    self.dataArray = nil;

    
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}


@end
