//
//  ScenicSpotIntroductionView.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScenicSpotIntroductionView : UIView<UIScrollViewDelegate>

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControll;
@property(nonatomic,assign)NSInteger curPage;
@property(nonatomic,strong)UILabel *textLabel;

@property(nonatomic,strong)NSMutableArray *curArray;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

// 数据
@property(nonatomic,strong)NSMutableArray *array;
// 设置定时器
@property(nonatomic,retain)NSTimer *timer;

@end
