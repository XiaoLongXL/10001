//
//  RouteViewController.h
//  TravelAgain02
//
//  Created by lanou on 15/7/18.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RouteViewController : BaseViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionViewFlowLayout *layout;
}

@property(nonatomic, retain)NSMutableArray *arrayRoute;
@property(nonatomic, retain)UICollectionView *cv;
@property(nonatomic,assign)NSInteger currentPage;

@end
