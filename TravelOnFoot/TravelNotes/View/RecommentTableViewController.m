//
//  RecommentTableViewController.m
//  Travel3
//
//  Created by lanou on 15/7/18.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RecommentTableViewController.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"

@interface RecommentTableViewController ()
//@property(nonatomic,strong) NSDictionary *dict;

@end

@implementation RecommentTableViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.hud show:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = [NSMutableArray array];
//    self.dict = [NSDictionary dictionary];

    [self RefreshData];
    
}

//刷新

- (void)RefreshData
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingRecommentHeader)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingRecommentHeader) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(RereshingRecommentFooter)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在帮你刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"正在帮你加载中";
}

#pragma mark 开始进入刷新状态
- (void)RereshingRecommentHeader
{
    self.currentPage = 1;
    [self requestData:kAPITravelCommendNotes];
    // 刷新表格
    //
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}


-(void)requestData:(NSString *)ip
{
    [self.hud show:YES];

    __weak RecommentTableViewController * travel = self;
    
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [travel.hud hide:YES afterDelay:2];

            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检测网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            travel.dict = [travel getDataWithKey:@"recommended"];
            [travel dataParse:[travel getDataWithKey:@"recommended"]];
            [alt show];
        }else{//网络正常,请求数据
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer  = [AFJSONResponseSerializer serializer];
            [manager GET:ip parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSData *data = operation.responseData;
                if (data == nil) {
                    UIAlertView *alt1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据异常,请刷新" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alt1 show];
                    return ;
                }
                NSMutableDictionary *dictionary = [data objectFromJSONData];
                
//                travel.dict = dictionary;
                [travel saveDate:dictionary withKey:@"recommended"];
                [travel dataParse:dictionary];
            
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
                [travel.hud hide:YES];
                
            }];

        }
    }];
}
-(void)dataParse:(NSDictionary*)dictionary
{
    totalPages = [[dictionary objectForKey:@"total_pages"] integerValue];
    array = [dictionary objectForKey:@"logs"];
    [self.hud hide:YES];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        
        RecommentModel * model = [RecommentModel modelWithDic:dict];
        [arr addObject:model];
    }
    self.dataArray = arr;
    [self.tableView reloadData];
    
}
-(NSString*)getFilePath
{
    //获得文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"recomment.archiver"];
    return filePath;
}
-(void)saveDate:(NSDictionary *)dict withKey:(NSString*)key
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
//        DLog(@"archiver success--recomment-");
    }
    
}
-(NSDictionary*)getDataWithKey:(NSString*)key
{
    //解归档
    //1. 从磁盘读取文件，生成NSData实例
    NSData *unarchiverData = [NSData dataWithContentsOfFile:[self getFilePath]];
    //2. 根据Data实例创建和初始化解归档对象
    NSKeyedUnarchiver *unachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    //3. 解归档，根据key值访问
    NSDictionary *dic = [unachiver decodeObjectForKey:key];
    
    return dic;
}


- (void)RereshingRecommentFooter
{
    self.currentPage+=1;
    if (self.currentPage > totalPages) {
       self.tableView.footerRefreshingText = @"没有了";
        [self.tableView footerEndRefreshing];
    }else{
    NSString *newIp = [NSString stringWithFormat:kAPITravelCommendNotesAppend,(long)self.currentPage];
    [self requestData:newIp];
    // 刷新表格
//    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.dataArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *identifer = @"cell";
     RecommentTableViewCell *recommentCell = [tableView dequeueReusableCellWithIdentifier:identifer];
     if (recommentCell == nil) {
         recommentCell = [[RecommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
     }
         RecommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
     recommentCell.model = model ;
 
 return recommentCell;
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(300);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelDetailViewController *travelDetailView = [[TravelDetailViewController alloc]init];
    RecommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    travelDetailView.ID = model.ID;
    travelDetailView.hidesBottomBarWhenPushed = YES;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    //    animation.type = kCATransitionFade;
    //    animation.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:travelDetailView animated:YES];

    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSLog(@"remmmmmmm");
//    [[SDImageCache sharedImageCache] clearMemory];
//    
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
//    
//    self.dataArray = nil;
    
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];}



@end
