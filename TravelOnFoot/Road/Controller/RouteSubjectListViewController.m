//
//  RouteSubjectListViewController.m
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteSubjectListViewController.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "UIViewController+HUD.h"
#import "RequestBaseClass.h"
#import "RouteSubjectListTableViewCell.h"
#import "RouteSubjectList.h"
#import "tablecellTool.h"
#import "ScenicSpotIntroductionViewController.h"
#import "AFNetworking.h"



#import "JSONKit.h"
@interface RouteSubjectListViewController ()
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation RouteSubjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tab = [[UITableView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 667)];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    
    self.arrayWeb = [NSMutableArray array];
    self.currentPage = 1;

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 250, 35)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = self.HeadTilte;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:widthScaleMakeAdaptationScreen(20)];
    self.navigationItem.titleView = titleLabel;
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMakeAdaptationScreen(0, 0, 30, 30);
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton setImage:[UIImage imageNamed:@"btn_nav_back@2x"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(touchLeft) forControlEvents:UIControlEventTouchUpInside];
    [self  RefreshData];
    

    // Do any additional setup after loading the view.
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
//        [self showHudInView:tab hint:@"正在加载..."];

    NSString *str = self.urlStr;
    RequestBaseClass *request = [[RequestBaseClass alloc] init];
    __weak RouteSubjectListViewController * listVC = self;
    [request getFromURL:str ViewController:self requestDate:^(NSData *data) {
        
        if (data == nil) {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据异常" delegate:listVC cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
//            [listVC showhide];

            return;
        }
        NSMutableDictionary *dic = [data objectFromJSONData];
        listVC.arrayWeb = [NSMutableArray array];
        [listVC.arrayWeb removeAllObjects];
        NSMutableArray *arr = [dic objectForKey:@"trails"];
        for (int i = 0; i < [arr count]; i++) {
            RouteSubjectList *rsl = [[RouteSubjectList alloc] init];
            rsl.picture = [[arr objectAtIndex:i] valueForKey:@"cover"];
            rsl.name = [[arr objectAtIndex:i] valueForKey:@"name"];
            rsl.address = [[arr objectAtIndex:i] valueForKey:@"destination"];
            rsl.score = [[[arr objectAtIndex:i] valueForKey:@"score"] stringValue];
            rsl.scoreCount = [[[arr objectAtIndex:i] valueForKey:@"score_count"] stringValue];
            rsl.descriptions = [[arr objectAtIndex:i] valueForKey:@"description"];
            rsl.ID = [[arr objectAtIndex:i] valueForKey:@"id"];
            [listVC.arrayWeb addObject:rsl];
        }
//        [listVC showhide];

        // 刷新表格
        [tab reloadData];
    }];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [tab headerEndRefreshing];
}

- (void)RereshingRecommentFooter
{
    self.currentPage += 1;
    if (self.currentPage > totalpages) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"这已经是最后一页" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];

    }else {
        [self showHudInView:self.view hint:@"正在加载..."];

//    if (self.currentPage <= totalpages) {
        __weak RouteSubjectListViewController * listVC = self;

    NSString *urlString = [NSString stringWithFormat:self.urlStr,(long)self.currentPage];
     RequestBaseClass *request = [[RequestBaseClass alloc] init];
    [request getFromURL:urlString ViewController:self requestDate:^(NSData *data) {
        
        if (data == nil) {
            [listVC showhide];
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据异常" delegate:listVC cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
            return ;

        }
        NSMutableDictionary *dic = [data objectFromJSONData];
        listVC.arrayWeb = [NSMutableArray array];
        NSMutableArray *arr = [dic objectForKey:@"trails"];
        for (int i = 0; i < [arr count]; i++) {
            RouteSubjectList *rsl = [[RouteSubjectList alloc] init];
            rsl.picture = [[arr objectAtIndex:i] valueForKey:@"cover"];
            rsl.name = [[arr objectAtIndex:i] valueForKey:@"name"];
            rsl.address = [[arr objectAtIndex:i] valueForKey:@"destination"];
            rsl.score = [[[arr objectAtIndex:i] valueForKey:@"score"] stringValue];
            rsl.scoreCount = [[[arr objectAtIndex:i] valueForKey:@"score_count"] stringValue];
            rsl.descriptions = [[arr objectAtIndex:i] valueForKey:@"description"];
            rsl.ID = [[arr objectAtIndex:i] valueForKey:@"id"];
            [listVC.arrayWeb addObject:rsl];
        }
        [listVC showhide];

        [tab reloadData];
    }];

}
    // 刷新表格
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [tab footerEndRefreshing];
    tab.contentOffset = CGPointMake(0, 0);

}



-(void)touchLeft
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
    return [self.arrayWeb count];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    RouteSubjectListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[RouteSubjectListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    // 从数组里面取活动
    RouteSubjectList *rsl = [self.arrayWeb objectAtIndex:indexPath.row];
    [cell.imagev sd_setImageWithURL:[NSURL URLWithString:rsl.picture] placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
    cell.nameLabel.text = rsl.name;
    NSString *str = [NSString stringWithFormat:@"%@", rsl.address];
    cell.addressLabel.text = str;
    NSString *str2 = [NSString stringWithFormat:@"评分：%@ 分", rsl.score];
    cell.scoreLabel.text = str2;
    NSString *str3 = [NSString stringWithFormat:@"共有 %@ 次评分", rsl.scoreCount];
    cell.scoreCountLabel.text = str3;
    cell.descriptionLabel.text = rsl.descriptions;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouteSubjectList *rsl = [self.arrayWeb objectAtIndex:indexPath.row];
    NSString *str = rsl.descriptions;
    CGFloat h = [tablecellTool getLabelHeight:widthScaleMakeAdaptationScreen(15) labelWidth:widthScaleMakeAdaptationScreen(355) content:str];
    return heightScaleMakeAdaptationScreen(190) + h;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    __weak RouteSubjectListViewController * route = self;
//    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
//    [maneger1 startMonitoring];
//    //网络判断
//    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请检测网络" delegate:route cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alt show];
//        } else {
            ScenicSpotIntroductionViewController *third = [[ScenicSpotIntroductionViewController alloc] init];
            RouteSubjectList *rsl = [self.arrayWeb objectAtIndex:indexPath.row];
            NSString *str = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v2/trail/%@?app_version=2.3.1&device_type=1", rsl.ID];
            NSString *str2 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/trail/%@/score?app_version=2.3.1&device_type=1&page=1&page_size=2", rsl.ID];
            NSString *str3 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/travelog/trail/%@?app_version=2.3.1&device_type=1&page=1&page_size=20", rsl.ID];
            NSString *str4 = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/trail/related/%@?app_version=2.3.1&device_type=1", rsl.ID];
            third.idString = str;
            third.idString2 = str2;
            third.idString3 = str3;
            third.idString4 = str4;
            third.HeadTitle = rsl.name;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 1.0;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            [self.view.window.layer addAnimation:animation forKey:nil];
            [self.navigationController pushViewController:third animated:YES];
//        }
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }


@end
