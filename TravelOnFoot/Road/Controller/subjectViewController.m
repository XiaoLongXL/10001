//
//  subjectViewController.m
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "subjectViewController.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HUD.h"
#import "RequestBaseClass.h"
#import "MJRefresh.h"
#import "JSONKit.h"
@interface subjectViewController ()

@end

@implementation subjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, widthScaleMakeAdaptationScreen(375), heightScaleMakeAdaptationScreen(667) - 113)];
    tab.dataSource = self;
    tab.delegate = self;
    [self.view addSubview:tab];
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
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //    [self.tableView addFooterWithTarget:self action:@selector(RereshingRecommentFooter)];
    
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
    __weak subjectViewController * VC = self;

//     [self showHudInView:self.view hint:@"玩命加载中..."];
      NSString *str = @"http://tubu.ibuzhai.com/rest/v1/trail/types?app_version=2.3.1&device_type=1";
    RequestBaseClass *request = [[RequestBaseClass alloc] init];
    [request getFromURL:str ViewController:self requestDate:^(NSData *data) {
        if (data == nil) {
            [VC showHint:@"数据有误"];
//            [VC showhide];
            return ;
        }
        
        NSMutableDictionary *dic = [data objectFromJSONData];
        [VC dataParse:dic];
        [VC saveDate:dic withKey:@"sub"];
//               [VC showhide];
        // 刷新表格
        [tab reloadData];
    } error:^(BOOL isNetError) {
        [VC dataParse:[self getDataWithKey:@"sub"]];
//        [VC showhide];
        [tab reloadData];

    }];
     // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [tab headerEndRefreshing];
}

-(void)dataParse:(NSMutableDictionary*)dic
{
    
    NSMutableArray *arr = [dic objectForKey:@"types"];
    subjectArray  = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        SubjectRoute *sr = [[SubjectRoute alloc] init];
        sr.picture = [[arr objectAtIndex:i] valueForKey:@"url"];
        sr.title = [[arr objectAtIndex:i] valueForKey:@"name"];
        sr.SubjectRouteId = [[arr objectAtIndex:i] valueForKey:@"id"];
        [subjectArray addObject:sr];
    }
}
-(NSString*)getFilePath
{
    //获得文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"sub.archiver"];
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
//        DLog(@"archiver success--sub-");
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




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subjectArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    RouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[RouteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    // 从数组里面取活动
    SubjectRoute *subR = [subjectArray objectAtIndex:indexPath.row];
   [cell.imagev sd_setImageWithURL:[NSURL URLWithString: subR.picture] placeholderImage:[UIImage imageNamed: @"19-281.jpg"]];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightScaleMakeAdaptationScreen(220);
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouteSubjectListViewController *second =[[RouteSubjectListViewController alloc] init];
    SubjectRoute *subR = [subjectArray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v1/trail/type/%@?app_version=2.3.1&device_type=1&page=1&page_size=20", subR.SubjectRouteId];
    second.urlStr = str;
    second.HeadTilte = subR.title;
    second.hidesBottomBarWhenPushed = YES;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    //    animation.type = kCATransitionFade;
    //    animation.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
