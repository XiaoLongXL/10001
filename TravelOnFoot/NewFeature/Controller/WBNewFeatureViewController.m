//
//  WBNewFeatureViewController.m
//  508WB
//
//  Created by xiaolong on 15/5/9.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "WBNewFeatureViewController.h"
#import "XLViewController.h"
#define WBNewFeatureViewImageCount 3
@interface WBNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIPageControl * pageController ;
@end

@implementation WBNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [self customScrollView];
    
    [self setupPageController];
    
    
}
-(void)setupPageController
{
    UIPageControl * pageController = [[UIPageControl alloc]init];
    pageController.numberOfPages = WBNewFeatureViewImageCount;
    CGFloat centerY  = self.view.frame.size.height -30 ;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    pageController.center = CGPointMake(centerX, centerY);
    pageController.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageController];
    //点颜色
    pageController.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    pageController.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    pageController.userInteractionEnabled = NO;
    self.pageController = pageController;
}
-(void)customScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds ;
    [self.view addSubview:scrollView];
    
    CGFloat imageH = scrollView.frame.size.height;
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageY = 0;
    
    scrollView.pagingEnabled = YES;
    for (int index  = 0; index < WBNewFeatureViewImageCount; index ++) {
        //图片
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]];
        //size
        CGFloat imageX = index* self.view.frame.size.width;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        [scrollView addSubview:imageView];
        //最后一页
        if (index == WBNewFeatureViewImageCount-1) {
            
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(WBNewFeatureViewImageCount* imageW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;

}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)setupLastImageView:(UIImageView*)imageView
{
    //默认交互关闭
    imageView.userInteractionEnabled = YES;
    
    UIButton * startButton = [[UIButton alloc]init];

    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    CGFloat centerY  = imageView.frame.size.height *0.8 ;
    CGFloat centerX = imageView.frame.size.width * 0.5;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero,startButton.currentBackgroundImage.size};
    [startButton setTitle:@"开始旅行" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
}
-(void)start
{
//    [UIApplication sharedApplication].statusBarHidden = NO;
    //切换根控制器
    self.view.window.rootViewController = [[XLViewController alloc]init];
}
-(void)checkboxClick:(UIButton*)checkbox
{
    checkbox.selected = !checkbox.isSelected ;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    double page = offsetX/scrollView.frame.size.width +0.5;
    self.pageController.currentPage = page;
//    DLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    
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
