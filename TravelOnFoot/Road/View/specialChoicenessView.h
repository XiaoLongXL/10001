//
//  specialChoicenessView.h
//  Travel3
//
//  Created by lanou on 15/7/29.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceniceRouteModel.h"

@interface specialChoicenessView : UIView<UIScrollViewDelegate>

@property(nonatomic,retain)SceniceRouteModel *model;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControll;
@property(nonatomic,retain)UILabel *textLabel;
@property(nonatomic,strong)UILabel *textlabel2;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,assign)NSInteger curPage;
@property(nonatomic,strong)NSMutableArray *curArray;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)UIImageView *avataImagev;

//@property(nonatomic,strong)NSMutableArray *curArray2;

// 数据
@property(nonatomic,strong)NSArray *array;
//@property(nonatomic,strong)NSArray *array2;
//@property(nonatomic,strong)NSArray *array3;

// 设置定时器
@property(nonatomic,retain)NSTimer *timer;

-(void)updateCurViewWithPage:(NSInteger)page;
@end
