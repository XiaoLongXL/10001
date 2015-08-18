//
//  ScenicSpotIntroductionView.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ScenicSpotIntroductionView.h"
#import "UIImageView+WebCache.h"
#import "SceniceRouteModel.h"
#import "XLTool.h"
@implementation ScenicSpotIntroductionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self.width = frame.size.width;
    self.height = frame.size.height;
    if (self = [super initWithFrame:frame]) {
        [self initWithScrollView];
        [self initWithTextLabel];
    }
    return self;
}


// 初始化scrollView
-(void)initWithScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    // 设置分页
    self.scrollView.pagingEnabled = YES;
    // 设置滑动的区域
    self.scrollView.contentSize = CGSizeMake(self.width * 3, 0);
    // 隐藏
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    // 设置代理
    self.scrollView.delegate = self;
    // 设置当前显示的位置
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    self.curArray = [NSMutableArray arrayWithCapacity:3];
    // 遍历创建显示的3张图片
    for (int i = 0; i < 3; i++) {
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, self.height)];
        [self.scrollView addSubview:imagev];
    }
    [self addSubview:self.scrollView];
}


-(void)setArray:(NSMutableArray *)array
{
    // 我的数据源等于传过来的数据源
    _array = array;
    [self updateCurViewWithPage:0];

}



// 定时器的方法
-(void)autoPlay
{
    self.scrollView.contentOffset = CGPointMake(_width * 2, 0);
}

// 获取索引
-(NSInteger)upteCurPage:(NSInteger)page
{
    NSInteger count = self.array.count;
    return (count + page) % count;
}



// 替换数据源的方法
-(void)updateCurViewWithPage:(NSInteger)page
{
    // 获取当前显示的上一张图片的索引 // 获取当前显示的上一张图片的索引
    NSInteger pre = [self upteCurPage:page - 1];
    // 当前显示的索引
    self.curPage = [self upteCurPage:page];
    // 获取当前显示的下一张图片的索引
    NSInteger last = [self upteCurPage:page + 1];
    // 删除数组里面的元素
    [self.curArray removeAllObjects];
    [self.curArray addObject:self.array[pre]];
    [self.curArray addObject:self.array[self.curPage]];
    [self.curArray addObject:self.array[last]];
    // 获取scrollView的所有子视图
    NSArray *arrays = self.scrollView.subviews;
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imagev = arrays[i];
        SceniceRouteModel * str =  self.curArray[i];
        NSURL * url =  [NSURL URLWithString:str.picture];
        [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
        if (i == 1) {
            NSString *str = [NSString stringWithFormat:@"%ld/%lu", (long)_curPage + 1, (unsigned long)[_array count]];
            self.textLabel.text = str;
            
        }
    }
    
    // 设置当前显示的位置
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    // 设置pagecontroll当前显示的索引
    self.pageControll.currentPage = self.curPage;
}


// 初始化pageControll
-(void)initWithPageControll
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMakeAdaptationScreen(self.width - 80, self.height - 30, 70, 30)];
    // 非当前页的页面控制视图颜色
    self.pageControll.pageIndicatorTintColor = [UIColor blueColor];
    // 当前页面的控制视图的颜色
    self.pageControll.currentPageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:self.pageControll];
}

// 初始化textLabel
-(void)initWithTextLabel
{
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 60, self.height - 30, 60, 30)];
    self.textLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.textLabel];
}


// 每次滑动都要调用该方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    if (x >= _width * 2) {
        // 向右滑动
        [self updateCurViewWithPage:self.curPage + 1];
    }else if (x == 0) {
        // 向左滑动
        [self updateCurViewWithPage:self.curPage - 1];
    }
}

// 开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 关掉定时器
    [self.timer invalidate];
    self.timer = nil;
}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
