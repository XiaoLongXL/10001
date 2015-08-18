//
//  RouteViewController.m
//  TravelAgain02
//
//  Created by lanou on 15/7/18.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteViewController.h"
#import "XLTool.h"
#import "UIViewController+HUD.h"
#import "RequestBaseClass.h"
#import "JSONKit.h"
#import "RouteCollectionViewCell.h"
#import "SubjectRoute.h"
#import "UIImageView+WebCache.h"
#import "regionsModel.h"
#import "provinceRouteViewController.h"
#import "MJRefresh.h"
#import "Header.h"
@interface RouteViewController ()
//@property(nonatomic,strong) NSMutableDictionary *dict;

@end

@implementation RouteViewController




- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dict = [NSMutableDictionary dictionary];

    self.arrayRoute  = [NSMutableArray array];
    
    
    // UICollectionView
    // 创建一个布局类
    layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置最小行间距
    layout.minimumLineSpacing = heightScaleMakeAdaptationScreen(25);
    // 设置最小列间距
    layout.minimumInteritemSpacing = widthScaleMakeAdaptationScreen(10);
    
    // 设置垂直滚动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置外边上下左右的间距
    layout.sectionInset = UIEdgeInsetsMake(heightScaleMakeAdaptationScreen(5), widthScaleMakeAdaptationScreen(10), heightScaleMakeAdaptationScreen(5), widthScaleMakeAdaptationScreen(10));
    
    // 借助布局类创建一个UICollectionView
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    // 注册一个cell UICollectionView必须注册
    [_cv registerClass:[RouteCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _cv.backgroundColor = [UIColor whiteColor];
    _cv.delegate = self;
    _cv.dataSource = self;
    _cv.showsHorizontalScrollIndicator = NO;
    _cv.showsVerticalScrollIndicator = NO;
//    _cv.bounces = NO;
    self.view = _cv;
  
    
    // 注册页眉（header）
    [_cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [self RefreshData];
//    [self.hud show:YES];
}

//// 刷新
- (void)RefreshData
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.cv addHeaderWithTarget:self action:@selector(RereshingRecommentHeader)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.cv addHeaderWithTarget:self action:@selector(RereshingRecommentHeader) dateKey:@"table"];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.cv headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(RereshingRecommentFooter)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.cv.headerPullToRefreshText = @"下拉刷新";
    self.cv.headerReleaseToRefreshText = @"松开刷新";
    self.cv.headerRefreshingText = @"正在帮你刷新中";
    
    self.cv.footerPullToRefreshText = @"上拉加载更多数据";
    self.cv.footerReleaseToRefreshText = @"松开加载更多";
    self.cv.footerRefreshingText = @"正在帮你加载中";
//    [self showhide];
}


#pragma mark 开始进入刷新状态
- (void)RereshingRecommentHeader
{
//    [self showHudInView:self.view hint:@"玩命加载中..."];
     NSString *str = @"http://tubu.ibuzhai.com/rest/v2/trail/regions?app_version=2.3.1&device_type=1";
    __weak RouteViewController * VC = self;
    RequestBaseClass *request = [[RequestBaseClass alloc] init];
    [request getFromURL:str ViewController:self requestDate:^(NSData *data) {
        if (data == nil) {
            [VC showHint:@"数据有误"];
//            [VC showhide];
            return ;
        }
//        [VC.hud hide:YES];
        NSMutableDictionary *dic = [data objectFromJSONData];
//        VC.dict = dic;
        [VC dataParse:dic];
        [VC saveDate:dic withKey:@"route"];
//        [VC showhide];
        // 刷新表格
        [VC.cv reloadData];
    } error:^(BOOL isNetError) {
     [VC dataParse: [VC getDataWithKey:@"route"]];
        [VC.cv reloadData];

    }];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.cv headerEndRefreshing];
}
-(void)dataParse:(NSMutableDictionary*)dic
{
    
    self.arrayRoute = [NSMutableArray array];
    NSMutableArray *arr = [dic objectForKey:@"regions"];
    for (NSDictionary *dicr in arr) {
        regionsModel *model1 = [regionsModel modelWithDic:dicr];
        // 装省份和区域名
        [self.arrayRoute addObject:model1];}
}
-(NSString*)getFilePath
{
    //获得文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"route.archiver"];
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
//        DLog(@"archiver success--route-");
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

// 分段（页眉）
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    NSLog(@"行数%ld",(unsigned long)[self.arrayRoute count]);
    return [self.arrayRoute count];
    
}



#pragma -mark   UICollectionView    的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    regionsModel *rm = [self.arrayRoute objectAtIndex:section];
    NSMutableArray *province1 = rm.province;
    return [province1 count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RouteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    regionsModel *rm = [self.arrayRoute objectAtIndex:indexPath.section];
    NSMutableArray *province1 = rm.province;
    NSMutableDictionary *dict = [province1 objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"icon"];
    NSString *str2 = [dict objectForKey:@"trail_count"];
    NSString *str3 = [NSString stringWithFormat:@"路线 %@", str2];
    cell.trailLabel.text = str3;
    NSURL *url = [NSURL URLWithString:str];
    [cell.imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
    return cell;
}


// 控制每个小方块的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat margin = widthScaleMakeAdaptationScreen(110);
    CGFloat margin1 = heightScaleMakeAdaptationScreen(170);
    return CGSizeMake(margin, margin1);
}




// 分区的高度 页眉的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, heightScaleMakeAdaptationScreen(40));
}

// 分区   页眉的样子
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 15, 20, 20)];
        label.backgroundColor = [UIColor orangeColor];
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(20, 10, 100, 30)];
        label2.backgroundColor = [UIColor whiteColor];
        regionsModel *rm = [self.arrayRoute objectAtIndex:indexPath.section];
        label2.text = rm.region;
        label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [headerView addSubview:label];
        [headerView addSubview:label2];
        return headerView;
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    provinceRouteViewController *second = [[provinceRouteViewController alloc] init];
    regionsModel *rm = [self.arrayRoute objectAtIndex:indexPath.section];
    NSMutableArray *province1 = rm.province;
    NSMutableDictionary *dic = [province1 objectAtIndex:indexPath.row];
    NSString *str = [dic objectForKey:@"keyword"];
    second.provinceStr = str;
    second.headTitle = [dic objectForKey:@"name"];
    second.hidesBottomBarWhenPushed = YES;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
      [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
