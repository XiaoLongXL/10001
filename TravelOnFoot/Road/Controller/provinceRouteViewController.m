//
//  provinceRouteViewController.m
//  Travel3
//
//  Created by lanou on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "provinceRouteViewController.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "UIViewController+HUD.h"
#import "RequestBaseClass.h"
#import "ViewController.h"
#import "JSONKit.h"


#import "provinceRouteTableViewCell.h"
#import "ScenicSpotIntroductionViewController.h"
#import "provinceRouteModel.h"
#import "AFNetworking.h"

@interface provinceRouteViewController ()
{
    UITableView *tab;
    NSInteger totalPage;
}
@property(nonatomic,assign)NSInteger currentPage;

@end

@implementation provinceRouteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    tab = [[UITableView alloc] initWithFrame: CGRectMakeAdaptationScreen(0, 0, 375, 667-64)];
    tab.dataSource = self;
    tab.delegate = self;
    [self.view addSubview:tab];
    
//    tab.separatorColor = [UIColor clearColor];
//    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 250, 30)];
    titleLabel.text = self.headTitle;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:widthScaleMakeAdaptationScreen(20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMakeAdaptationScreen(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"btn_nav_back@2x"] forState:UIControlStateNormal];
    leftButton.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
//   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(touchMe)];
    
    [self RefreshData];
 
 }


//// 刷新
- (void)RefreshData
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [tab addHeaderWithTarget:self action:@selector(RereshingRecommentHeader)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [tab addHeaderWithTarget:self action:@selector(RereshingRecommentHeader) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [tab headerBeginRefreshing];
    
    //     2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tab addFooterWithTarget:self action:@selector(RereshingRecommentFooter)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tab.headerPullToRefreshText = @"下拉刷新";
    tab.headerReleaseToRefreshText = @"松开刷新";
    tab.headerRefreshingText = @"正在帮你刷新中";
    
    tab.footerPullToRefreshText = @"上拉加载更多数据";
    tab.footerReleaseToRefreshText = @"松开加载更多";
    tab.footerRefreshingText = @"正在帮你加载中";
}


#pragma mark 开始进入刷新状态
- (void)RereshingRecommentHeader
{
//    [self showHudInView:self.view hint:@"加载中..."];

    self.currentPage = 1;
    NSString *str = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v2/trails?app_version=2.3.1&city=0&crowd=0&device_type=1&page=1&page_size=0&search=%@&search_in=1&trait=0",self.provinceStr];
    __weak provinceRouteViewController *route = self;
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    RequestBaseClass *request = [[RequestBaseClass alloc] init];
    [request getFromURL:str ViewController:self requestDate:^(NSData *data) {
        if (data == nil) {
            UIAlertView *alt1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据异常,请刷新" delegate:route cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt1 show];
 
            return ;
        }
        // json解析
        NSMutableDictionary *dic = [data objectFromJSONData];
        route.provinceArray = [NSMutableArray array];
        NSMutableArray *arr = [dic objectForKey:@"trails"];
        NSString *string = [[dic objectForKey:@"total_pages"] stringValue];
                totalPage = [string integerValue];
        
        for (int i = 0; i < [arr count]; i++) {
            
            provinceRouteModel *pm = [[provinceRouteModel alloc] init];
            pm.picture = [[arr objectAtIndex:i] valueForKey:@"cover"];
            pm.name = [[arr objectAtIndex:i] valueForKey:@"name"];
            pm.address = [[arr objectAtIndex:i] valueForKey:@"destination"];
            pm.provinceId = [[arr objectAtIndex:i] valueForKey:@"id"];
            [route.provinceArray addObject:pm];
        }
        // 刷新表格
        [tab reloadData];
 
    }];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [tab headerEndRefreshing];
//    [route showhide];

}



- (void)RereshingRecommentFooter
{
    
    self.currentPage += 1;
    if (self.currentPage > totalPage) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已经是最后一页" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
    
    if (self.currentPage <= totalPage) {
    [self showHudInView:self.view hint:@"加载中..."];
    NSString *urlString = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v2/trails?app_version=2.3.1&city=0&crowd=0&device_type=1&page=%ld&page_size=0&search=%@&search_in=1&trait=0",(long)self.currentPage, self.provinceStr];
        
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
        __weak provinceRouteViewController *route = self;

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
     // 异步block请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常,数据有误" delegate:route cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
            [route showhide];
             return ;
        }
        // json解析
        NSMutableDictionary *dic = [data objectFromJSONData];
        route.provinceArray = [NSMutableArray array];
      NSMutableArray * array =  [NSMutableArray array];

        NSMutableArray *arr = [dic objectForKey:@"trails"];
        for (int i = 0; i < [arr count]; i++) {
            provinceRouteModel *pm = [[provinceRouteModel alloc] init];
            pm.picture = [[arr objectAtIndex:i] valueForKey:@"cover"];
            pm.name = [[arr objectAtIndex:i] valueForKey:@"name"];
            pm.address = [[arr objectAtIndex:i] valueForKey:@"destination"];
            pm.provinceId = [[arr objectAtIndex:i] valueForKey:@"id"];
            [array addObject:pm];
        }
        
        route.provinceArray = array;
        [tab reloadData];
        [route showhide];
    }];
}
    // 刷新表格
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    tab.contentOffset = CGPointMake(0, 0);
    [tab footerEndRefreshing];

}





-(void)goBack
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.provinceArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
  {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    provinceRouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[provinceRouteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    // 从数组里面取活动
    provinceRouteModel *prm = [self.provinceArray objectAtIndex:indexPath.row];
    [cell.imagev sd_setImageWithURL:[NSURL URLWithString:prm.picture] placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
    cell.nameLabel.text = prm.name;
    NSString *str = [NSString stringWithFormat:@"地点：%@", prm.address];
    cell.addressLabel.text = str;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(240);
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak provinceRouteViewController * province = self;
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
[maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    if (status == AFNetworkReachabilityStatusNotReachable) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常,请检测网络" delegate:province cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    } else {
        ScenicSpotIntroductionViewController *second = [[ScenicSpotIntroductionViewController alloc] init];
        provinceRouteModel *pm = [province.provinceArray objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v2/trail/%@?app_version=2.3.1&device_type=1", pm.provinceId];
        NSString *str2 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/trail/%@/score?app_version=2.3.1&device_type=1&page=1&page_size=2", pm.provinceId];
        NSString *str3 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/travelog/trail/%@?app_version=2.3.1&device_type=1&page=1&page_size=20", pm.provinceId];
        NSString *str4 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/trail/related/%@?app_version=2.3.1&device_type=1", pm.provinceId];
        second.idString = str;
        second.idString2 = str2;
        second.idString3 = str3;
        second.idString4 = str4;
        second.HeadTitle = pm.name;
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect";
        [province.view.window.layer addAnimation:animation forKey:nil];

        [province.navigationController pushViewController:second animated:YES];
    }
}];
    
}


//-(void)touchMe
//{
//    ViewController *forth = [[ViewController alloc] init];
//    [self.navigationController pushViewController:forth animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }



@end
