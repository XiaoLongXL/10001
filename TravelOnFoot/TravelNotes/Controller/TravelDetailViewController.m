//
//  TravelDetailViewController.m
//  Travel3
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "TravelDetailViewController.h"
#import "JSONKit.h"
#import "Header.h"
#import "AFNetworking.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
#import "DetailTableForHeadView.h"
#import "MJRefresh.h"
#import "CollectionTravel.h"

@interface TravelDetailViewController ()
@property(nonatomic,assign)CGFloat cellheight;
@end

@implementation TravelDetailViewController
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellheight = 0;

    self.hud.yOffset = heightScaleMakeAdaptationScreen(30);
    [self.hud show:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 250, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"游记详情";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    UIImage *image1 = [UIImage imageNamed:@"btn_nav_back@2x"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(turnBack)];
    

    UIImage *image2 = [UIImage imageNamed:@"btn_nav_share@2x"];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(collectionButton)];
    
//    UIButton *top = [UIButton buttonWithType:UIButtonTypeCustom];
//    top.frame = CGRectMakeAdaptationScreen(330, 567, 40, 40);
//    top.backgroundColor = [UIColor colorWithRed:111/255.0 green:196/255.0 blue:60/255.0 alpha:0.5];
//    [top setImage:image2 forState:UIControlStateNormal];
//    [self.view addSubview:top];
//    [self.view bringSubviewToFront:top];
//    self.dataArray = [NSMutableArray array];
//    [self refreshData];
    [self RereshingDetailHeader];
}


-(void)collectionButton
{
    NSString *ip = self.ID;
    // 点击添加到数据库
    // 获取要保存的景点
    CollectionTravel *tool = [[CollectionTravel alloc] init];
    // 插入
    if ([tool existsWithTravelName:headModel.name]) {
//        NSLog(@"已经存在， 不允许重复收藏");
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }else {
        [tool insertToTravelCollectTable:ip title:headModel.name];
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加到收藏夹成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
}


//返回顶部按钮方法
-(void)backToTop
{
    self.tableView.contentOffset = CGPointMake(0, 0);
}

- (void)refreshData
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingDetailHeader)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(RereshingDetailHeader) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:nil];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在帮你刷新中";
    
    self.tableView.footerPullToRefreshText = @"没有了";
    self.tableView.footerReleaseToRefreshText = @"没有了";
    self.tableView.footerRefreshingText = @"没有了";
}
//
-(void)RereshingDetailHeader
{
    NSString *ip = [NSString stringWithFormat:kAPITravelCommendNotesDetail,self.ID];
//    NSLog(@"%@",ip);
    [self requestData:ip];
    [self.tableView headerEndRefreshing];
}




-(void)turnBack
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//tableview 区头滚动的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = heightScaleMakeAdaptationScreen(260);
    if (proportion < 0.8) {
    sectionHeaderHeight = heightScaleMakeAdaptationScreen(360);
    }
    
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {

        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)requestData:(NSString *)urlStr
{
    __weak TravelDetailViewController * travel = self;
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检测网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
            [self.hud show:YES];
        }else{
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer  = [AFJSONResponseSerializer serializer];
            [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSData *data = operation.responseData;
                if (data == nil) {
                    UIAlertView *alt1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据异常,请刷新" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alt1 show];
                    return;
                }
                [travel.hud hide:YES];
                
                NSMutableDictionary *log = [[ data objectFromJSONData]objectForKey:@"log"];
                
                headModel = [DetailHeadModel modelWithDic:log];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headModel.cover]]];
                proportion = image.size.width / image.size.height;
                NSMutableArray *array = log[@"posts"];
                NSMutableArray *arr = [NSMutableArray array];
                for (NSMutableDictionary *dic in array) {
                    DetailModel *model = [DetailModel modelWithDic:dic];
                    
                    [arr addObject:model];
                }
                [travel.dataArray removeAllObjects];
                travel.dataArray = arr;
                [travel.tableView reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [travel.hud hide:YES];
                UIAlertView *alt2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该日志无详情" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alt2 show];
            }];
 
        }
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailTableForHeadView *view = [[DetailTableForHeadView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 230)];
    view.model = headModel;
    return view;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (proportion < 0.8) {
        return heightScaleMakeAdaptationScreen(350);
    }
    
    return heightScaleMakeAdaptationScreen(250);
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    DetailModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellheight = cell.cellhight ;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellheight;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSLog(@"travel---------");
//
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
//    
//    self.dataArray = nil;
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCach`e sharedImageCache] clearDisk];

    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

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
