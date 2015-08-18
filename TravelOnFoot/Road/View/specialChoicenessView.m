//
//  specialChoicenessView.m
//  Travel3
//
//  Created by lanou on 15/7/29.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "specialChoicenessView.h"
#import "UIImageView+WebCache.h"

@implementation specialChoicenessView


-(instancetype)initWithFrame:(CGRect)frame
{
    self.width = frame.size.width;
    self.height = frame.size.height;
    if (self = [super initWithFrame:frame]) {
        [self initWithScrollView];
        [self initWithTextLabel];
        [self initWithPageControll];
        [self initWithAvataImagev];
        [self initWithTitleLabel];
        [self initWithTextLabel2];
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
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i, 70, self.width, self.height - 70)];
        [self.scrollView addSubview:imagev];
//
//        [imagev addSubview:avataImagev];
    }
    [self addSubview:self.scrollView];
}

-(void)setArray:(NSArray *)array
{
    // 我的数据源等于传递过来的数据源
    _array = array;
    if ([_array count] == 1) {
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    [self updateCurViewWithPage:0];
    self.pageControll.numberOfPages = [self.array count];
    // 设置定时器自动播放
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
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
    // 获取当前显示的上一张图片的索引
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
        _model = self.curArray[i];
        imagev.backgroundColor = [UIColor whiteColor];
        NSURL *url;
        if ([_model.specialCover isEqual:[NSNull null]]) {
        }else {
            url = [NSURL URLWithString:_model.specialCover];
            
        }
        [imagev sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
        
        NSURL *url2 = [NSURL URLWithString:_model.specialAvatar];
        NSString *str1 = _model.specialStart_date;
        NSString *str2 = _model.specialTotal_days;
        NSString *str3 = _model.specialPhoto_number;
        NSString *str4 = _model.specialNickname;
        NSString *str6 = _model.specialEnd_date;
        NSString *str5 = [NSString stringWithFormat:@"行程 %@ 天 拍摄 %@ 张图片 · 由游客·%@·发布", str2, str3, str4];
        NSString *str7 = [NSString stringWithFormat:@"起始时间：%@--%@", str1, str6];
        if (i == 1) {
            [self.avataImagev sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
            self.textLabel.text = str5;
            self.textlabel2.text = str7;
            self.titleLabel.text = @"精选专辑";
        }
    }
    // 设置当前显示的位置
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    // 设置pagecontroll当前显示的索引
    self.pageControll.currentPage = self.curPage;
}


// 初始化pagecontroll
-(void)initWithPageControll
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(self.width / 2 - 100, self.height - 30, 200, 30)];
    // 非当前页的页面控制视图颜色
    self.pageControll.pageIndicatorTintColor = [UIColor whiteColor];
    // 当前页的页面控制视图颜色
    self.pageControll.currentPageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:self.pageControll];
}


// 初始化avataImagev
-(void)initWithAvataImagev
{
    self.avataImagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 30, 30)];
    self.avataImagev.layer.cornerRadius = 15;
    self.avataImagev.layer.masksToBounds = YES;
    self.avataImagev.backgroundColor = [UIColor greenColor];
    self.avataImagev.userInteractionEnabled = YES;
    [self addSubview:self.avataImagev];
}



// 初始化textLabel
-(void)initWithTextLabel
{
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, self.width - 40, 20)];
    self.textLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.textLabel];
}

-(void)initWithTextLabel2
{
    self.textlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, self.width - 40, 20)];
    self.textlabel2.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.textlabel2];
}

-(void)initWithTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:self.titleLabel];
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
