//
//  ActivityDetailViewController.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "ActivityDetailViewController.h"
 #import "XLTool.h"
#import "Header.h"
#import "ActivityDetail.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "CollectionTravel.h"
@interface ActivityDetailViewController ()<UIAlertViewDelegate>
{
    CollectionTravel *coll;

}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,weak) ActivityDetail * detailView;
@end

@implementation ActivityDetailViewController
-(void)dealloc
{
    DLog(@"ActivityDetailViewController aaaaaaaaaaaaaaaaa");
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
 self.navigationItem.title = @"活动详情";
    [self.hud show:YES];
    self.view.backgroundColor = [UIColor whiteColor];

        NSString * URLStr = [NSString stringWithFormat:@"http://tubu.ibuzhai.com/rest/v3/activity/%@?app_version=2.3.2&device_type=1",self.activitiesModel.id];
    
    [XLTool XLNetworkingRequestDateModelArrayFromURL:URLStr successResponseObject:^(id responseObject) {
        if(responseObject!=nil){
        self.activityDetailModel = [ActivityDetailModel modelWithDic:responseObject];
            ActivityDetail * detail = [[ActivityDetail alloc]initWithFrame:self.view.bounds activityDetailModel:self.activityDetailModel activitiesModel:self.activitiesModel];
            self.detailView = detail;
            [self.view addSubview:detail];
         }
        [self.hud hide:YES afterDelay:2];

    } failed:^(BOOL error) {
        [self.hud hide:YES afterDelay:2];
    }];
    
        self.navigationItem.leftBarButtonItem = [XLTool barButtonItemWithIcon:@"btn_nav_back@2x" highlighted:nil target:self action:@selector(pop:)];
    
    [self setTabBar];


}

-(void)pop:(UIBarButtonItem*)item
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)setTabBar
{
    UIImage * image = [[UIImage imageNamed:@"call_selected@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * button = [[UIButton alloc]init];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0,40, 40);
    button.center = CGPointMake(widthScaleMakeAdaptationScreen(375)/4, 25);
    [self.tabBarController.tabBar addSubview:button];
    
    
    UIImage * image1 = [[UIImage imageNamed:@"btn_nav_share@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * button1 = [[UIButton alloc]init];
    
    
    [button1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(didClickShareSDK:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 0,40, 40);
    button1.center = CGPointMake(widthScaleMakeAdaptationScreen(375)/4*3, 25);
    [self.tabBarController.tabBar addSubview:button1];
 }
-(void)didClick:(UIButton*)but
{
    NSString * message = [NSString stringWithFormat:@"%@\n%@",self.activityDetailModel.club[@"title"],self.activityDetailModel.club[@"phone"]];
   UIAlertView * alertView =  [XLTool showAlertViewWithTitle:@"呼叫" message:message cancelButtonTitle:@"取消"otherButtonTitle:@"确定"];
    alertView.delegate = self;
    [alertView show];
    
 }
-(void)didClickShareSDK:(UIButton*)but
{
    NSString *ip = self.activitiesModel.ID;
    NSLog(@"%@",ip);
    // 点击添加到数据库
    // 获取要保存的景点
    CollectionTravel *tool = [[CollectionTravel alloc] init];
    // 插入
    if ([tool existsWithActivityTitle:self.activitiesModel.title]) {
        NSLog(@"已经存在， 不允许重复收藏");
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }else {
        [tool insertToActivityCollectTable:ip destination:self.activitiesModel.destination title:self.activitiesModel.title];
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加到收藏夹成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSURL * URL=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.activityDetailModel.club[@"phone"]]];
        [[UIApplication sharedApplication] openURL:URL];
    }
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}


@end
