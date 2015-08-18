//
//  WeatherTableTableViewController.m
//  Travel3
//
//  Created by lanou on 15/8/1.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "WeatherTableTableViewController.h"
#import "JSONKit.h"

#import "XLTool.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "WeatherTableHeaderView.h"


#import "ViewController.h"
#import "FutrreWeatherModel.h"
#import "FutureWeatherTableViewCell.h"


@interface WeatherTableTableViewController ()

@end

@implementation WeatherTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.hud show:YES];
    time = 1;
    UIView *titelView = [[UIView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 285, 30)];
    
    //输入框
    tf = [[UITextField alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 260, 30)];
    tf.font = [UIFont systemFontOfSize:13];
    tf.placeholder = @"请输入要查询的城市,例如:北京";
    tf.backgroundColor = [UIColor whiteColor];
    tf.layer.borderColor = [UIColor whiteColor].CGColor;
    tf.layer.cornerRadius = 3;
    tf.layer.masksToBounds = YES;
    tf.layer.borderWidth = 1;
    tf.clearButtonMode = YES;
    tf.delegate = self;
    [titelView addSubview:tf];
    
    //查询按钮
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queryButton.frame = CGRectMakeAdaptationScreen(255, 0, 30, 30);
    queryButton.backgroundColor = [UIColor colorWithRed:109/255.0 green:192/255.0 blue:59/255.0 alpha:1];
    [queryButton setImage:[UIImage imageNamed:@"chaxun"] forState:UIControlStateNormal];
    queryButton.showsTouchWhenHighlighted = YES;
    queryButton.layer.borderColor = [UIColor whiteColor].CGColor;
    queryButton.layer.borderWidth = 1;
    queryButton.layer.cornerRadius = 3;
    queryButton.layer.masksToBounds = YES;
    [queryButton addTarget:self action:@selector(touchQueryButton) forControlEvents:UIControlEventTouchUpInside];
    [titelView addSubview:queryButton];
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(touchMe)];
    
    self.navigationItem.titleView = titelView;
//    新接口 http://v.juhe.cn/weather/index?format=2&cityname=%@&key=080dd56d92b300620b83443a26555667
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor greenColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self RefreshData];
    self.tableView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)dismiss:(UIBarButtonItem *)left
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:YES ];
}
//
//-(void)touchMe
//{
//    ViewController *second = [[ViewController alloc] init];
//    [self.navigationController pushViewController:second animated:YES];
//    
//}

//点return键回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self touchQueryButton];
    [tf resignFirstResponder];
    return YES;
}
  //触摸空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tf resignFirstResponder];
}


//查询按钮方法
-(void)touchQueryButton
{
    [tf resignFirstResponder];
    NSString *str = [NSString stringWithFormat:@"http://v.juhe.cn/weather/index?format=2&cityname=%@&key=080dd56d92b300620b83443a26555667",tf.text];
     [self requestData:str];
}

-(void)requestData:(NSString *)str
{
    __weak WeatherTableTableViewController * weather = self;
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            [weather showHint:@"网络连接失败,请检测网络"];
        }else{
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer  = [AFJSONResponseSerializer serializer];
            [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSData *data = operation.responseData;
                NSMutableDictionary *dictionary =  [data objectFromJSONData];
                
                 if ([dictionary[@"resultcode"] isEqualToString:@"202"]) {
                    [weather showHint:@"请核实城市名字"];

                }

                if ([[dictionary objectForKey:@"reason"] isEqualToString:@"successed!"]) {
                    headerModel = [[WeatherTableHeaderModel alloc]init];
                    NSMutableDictionary *result = [dictionary objectForKey:@"result"];
                    NSString *s = [[result objectForKey:@"sk"] objectForKey:@"temp"];
                    
                    //当前温度
                    headerModel.temp = [NSString stringWithFormat:@"%@ °C",s];
                    //当天温度区间
                    headerModel.temperature = [[result objectForKey:@"today"]objectForKey:@"temperature"];
                    //天气情况
                    headerModel.weather = [[result objectForKey:@"today"]objectForKey:@"weather"];
                    
                    //风向和风力
                    headerModel.wind = [NSString stringWithFormat:@"%@  %@",[[result objectForKey:@"sk"]objectForKey:@"wind_direction"],[[result objectForKey:@"sk"]objectForKey:@"wind_strength"]];
                    //穿着建议
                    headerModel.dressing_advice = [[result objectForKey:@"today"] objectForKey:@"dressing_advice"];
                    //发布日期 /星期几
                    headerModel.date_y = [NSString stringWithFormat:@"%@  %@",[[result objectForKey:@"today"] objectForKey:@"date_y"],[[result objectForKey:@"today"] objectForKey:@"week"]];
                    
                    //城市
                    headerModel.time = [NSString stringWithFormat:@"%@  发布",[[result objectForKey:@"sk"] objectForKey:@"time"]];
                    
                    headerModel.city = [[result objectForKey:@"today"] objectForKey:@"city"];
                    
                    
                    //未来一周天气情况
                    NSMutableArray *futureArray = [result objectForKey:@"future"];
                    self.dataArray = [NSMutableArray array];
                    for (int i = 1; i < [futureArray count]; i++) {
                        FutrreWeatherModel *futureModel = [[FutrreWeatherModel alloc]init];
                        futureModel.week = [[futureArray objectAtIndex:i]objectForKey:@"week"];
                        futureModel.date = [[futureArray objectAtIndex:i]objectForKey:@"date"];
                        futureModel.temperature = [[futureArray objectAtIndex:i]objectForKey:@"temperature"];
                        futureModel.weather = [[futureArray objectAtIndex:i]objectForKey:@"weather"];
                        [self.dataArray addObject:futureModel];
                    }
                    [self.tableView reloadData];
                }else{
                    [weather.hud hide:YES afterDelay:1];
                    [weather showHint:@"请核实城市名字"];
                     return ;
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
    }];
    
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
//    [self.tableView addFooterWithTarget:self action:@selector(RereshingFooter)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在帮你刷新中";
//    
//    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
//    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
//    self.tableView.footerRefreshingText = @"正在帮你加载中";
}
#pragma mark 开始进入刷新状态
- (void)RereshingHeader
{
    NSString *str = @"http://v.juhe.cn/weather/index?format=2&cityname=北京&key=080dd56d92b300620b83443a26555667";
    if (time != 1) {
    str = [NSString stringWithFormat:@"http://v.juhe.cn/weather/index?format=2&cityname=%@&key=080dd56d92b300620b83443a26555667",headerModel.city];
     }
    
    [self requestData:str];
    time += 1;
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

//- (void)RereshingFooter
//{
//    self.tableView.footerPullToRefreshText = @"没有了";
//    self.tableView.footerReleaseToRefreshText = @"没有了";
//    self.tableView.footerRefreshingText = @"没有了";
//}


//提示框
- (void)showHint:(NSString *)hint  {
//         显示提示信息
//         UIView *view = [[UIApplication sharedApplication].delegate window];
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.userInteractionEnabled = NO;
         hud.mode = MBProgressHUDModeText;
         hud.labelText = hint;
         //  hud.margin = 10.f;
         hud.yOffset = 150.f;
         hud.removeFromSuperViewOnHide = YES;
         [hud hide:YES afterDelay:1];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return heightScaleMakeAdaptationScreen(270);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WeatherTableHeaderView *headerView = [[WeatherTableHeaderView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 210)];
    headerView.headerModel = headerModel;
    headerView.userInteractionEnabled = NO;
    return headerView;
}

////tableview 区头滚动的方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat sectionHeaderHeight = heightScaleMakeAdaptationScreen(270);
//    
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    FutureWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[FutureWeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    FutrreWeatherModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(70);
}



- (void)commentTableViewTouchInSide
{
    [tf resignFirstResponder];
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
