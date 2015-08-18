//
//  ActivityPhotoViewController.m
//  Travel3
//
//  Created by xiaolong on 15/7/23.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ActivityPhotoViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Header.h"
#import "ActivitiesModel.h"
#import "UIImageView+WebCache.h"
#import "XYZPhoto.h"
#import "XLTool.h"
#import "ActivityTableViewController.h"

@interface ActivityPhotoViewController ()
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,weak)XYZPhoto * photoView;
@property(nonatomic, strong) NSMutableArray * photos;
//@property(nonatomic, strong) NSMutableArray * array1;

@end

@implementation ActivityPhotoViewController
-(void)dealloc
{
    DLog(@"ActivityPhotoViewController aaaaaaaaaaaaaaaaa");
}
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)photos
{
    if (_photos ==nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}
- (void)viewDidLoad {
    [self prefersStatusBarHidden];
    [super viewDidLoad];
//    [self.hud show:YES];
    self.dataArray = self.array1;
    self.view.backgroundColor = [UIColor colorWithRed:299/255.0 green:299/255.0 blue:299/255.0 alpha:0.7];
     self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    self.scrollView.userInteractionEnabled = YES;
     self.navigationItem.leftBarButtonItem = [XLTool barButtonItemWithIcon:@"btn_nav_back@2x" highlighted:nil target:self action:@selector(pop:)];
    self.title = @"图库";
    [self setupPhoto];
 
}


-(void)pop:(UIBarButtonItem*)item
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (XYZPhoto * photo in self.photos) {
        [photo startMove];
    }
 }
-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    for (XYZPhoto * photo in self.photos) {
        [photo stopMove];
    }
}

-(void)setupPhoto
{
     if (self.dataArray.count ==0) {
         return;
    }
    for (NSInteger i = self.dataArray.count-1 ; i >=0; i--) {
        float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
        float Y = arc4random()%((int)(self.view.bounds.size.height - IMAGEHEIGHT));
        float W = IMAGEWIDTH;
        float H = IMAGEHEIGHT;
        XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        ActivitiesModel * model = self.dataArray[i];
         [photo.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
        photo.userInteractionEnabled = YES;
            [self.scrollView addSubview:photo];
        
        float alpha = i*1.0/self.dataArray.count + 0.2;
//        float alpha = i*0.08;

        [photo setImageAlphaAndSpeedAndSize:alpha];
 
       
        [self.photos addObject:photo];

    }
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];

    
}
- (void)doubleTap {
    
        for (XYZPhoto *photo in self.photos) {
            if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
                return;
            }
        }
    __weak ActivityPhotoViewController * view = self;
        float W = self.view.bounds.size.width / 3;
        float H = self.view.bounds.size.height / 3;
    CGFloat hang = self.dataArray.count/3;
        [UIView animateWithDuration:1 animations:^{
            for (int i = 0; i < view.photos.count; i++) {
                XYZPhoto *photo = [view.photos objectAtIndex:i];
                
                if (photo.state == XYZPhotoStateNormal) {
                    photo.oldAlpha = photo.alpha;
                    photo.oldFrame = photo.frame;
                    photo.oldSpeed = photo.speed;
                    photo.alpha = 1;
                    photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                    photo.imageView.frame = photo.bounds;
                    photo.speed = 0;
                    photo.state = XYZPhotoStateTogether;
                    view.scrollView.contentSize = CGSizeMake(0, (hang+2)*H);
                    
                } else if (photo.state == XYZPhotoStateTogether) {
                    photo.alpha = photo.oldAlpha;
                    photo.frame = photo.oldFrame;
                    photo.speed = photo.oldSpeed;
                    photo.imageView.frame = photo.bounds;
                     photo.state = XYZPhotoStateNormal;
                     view.scrollView.contentSize = CGSizeMake(0, H);
             }
            }
        }];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
