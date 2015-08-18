//
//  LiveTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "LiveTableViewCell.h"
#import "NSDate+XL.h"
#import "iCarousel.h"

#import "XLTool.h"
#import "UIImageView+WebCache.h"

@interface LiveTableViewCell()<iCarouselDataSource,iCarouselDelegate>

@property(nonatomic,strong)iCarousel * carousel;
@end

@implementation LiveTableViewCell

//重新初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLiveTableViewCell];
        [self layoutSubviewsss];
    }

    return self;
}

//初始化需要的控件,并添加到cell中
-(void)createLiveTableViewCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    
    self.userImage = [[UIImageView alloc]init];
    [self.backView addSubview:self.userImage];
    
    self.userNickName = [[UILabel alloc]init];
    [self.backView addSubview:self.userNickName];
    
    self.updateTime = [[UILabel alloc]init];
    [self.backView addSubview:self.updateTime];

    self.postName = [[UILabel alloc]init];
    [self.backView addSubview:self.postName];
//    //集合视图
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(95, 95);
//    //设置最小行间距
//    layout.minimumLineSpacing = 10;
//    //设置最小列间距
//    layout.minimumInteritemSpacing = 5;
//    //设置垂直滚动
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //设置外面上下左右的间距
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.photosView = [[UIView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 80, 355, 180)];
     [self.backView addSubview:self.photosView];
    self.photosView.backgroundColor = [UIColor whiteColor];


    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 355, 180)];
    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    self.carousel.type = iCarouselTypeCoverFlow ;
    [self.photosView addSubview:self.carousel];
    
    
    self.added_post_count = [[UILabel alloc]init];
    [self.backView addSubview:self.added_post_count];
    
    
    self.favAndComment = [[UILabel alloc] init];
    [self.backView addSubview:self.favAndComment];
    
}

-(void)layoutSubviewsss
{
//    [super layoutSubviews];
    self.backView.frame = CGRectMakeAdaptationScreen(10, 10, 375-20, 300);

    self.userImage.frame = CGRectMakeAdaptationScreen(0, 0, 40, 40);
    self.userImage.layer.cornerRadius = widthScaleMakeAdaptationScreen(20);
    self.userImage.layer.masksToBounds = YES;
    
    self.userNickName.frame = CGRectMakeAdaptationScreen(50, 10, 150, 30);
    self.userNickName.textColor = [UIColor colorWithRed:115/255.0 green:167/255.0 blue:205/255.0 alpha:1];
    self.userNickName.font = [UIFont systemFontOfSize:15];
    //时间
    self.updateTime.frame = CGRectMakeAdaptationScreen(355-150, 10, 145, 30);
    self.updateTime.textColor = [UIColor colorWithRed:115/255.0 green:167/255.0 blue:205/255.0 alpha:1];
    self.updateTime.font = [UIFont systemFontOfSize:13];
    self.updateTime.textAlignment = NSTextAlignmentRight;
    
    
    self.postName.frame = CGRectMakeAdaptationScreen(0, 40, 355, 30);
    self.postName.font = [UIFont systemFontOfSize:14];
    self.postName.textAlignment = NSTextAlignmentCenter;
    
    self.added_post_count.frame = CGRectMakeAdaptationScreen(0, 270, 120, 30);
    self.added_post_count.font = [UIFont systemFontOfSize:11];
    self.added_post_count.textColor = [UIColor grayColor];
    
    self.favAndComment.frame = CGRectMakeAdaptationScreen(355 - 200, 270, 195, 30);
    self.favAndComment.textColor = [UIColor grayColor];
    self.favAndComment.textAlignment = NSTextAlignmentRight;
    self.favAndComment.font = [UIFont systemFontOfSize:11];

    
    
    
}

-(void)setModel:(LiveModel *)model
{
    _model = model;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:model.data[@"log"][@"created_by"][@"avatar"]] placeholderImage:nil];
    NSMutableDictionary *dic = model.data[@"log"][@"created_by"];
    self.userNickName.text = dic[@"nickname"];
    self.postName.text = model.data[@"log"][@"name"];
    self.added_post_count.text = [NSString stringWithFormat:@"更新了%@张图片",model.data[@"log"][@"added_post_count"]];
    NSString *fav = model.data[@"log"][@"fav_count"];
    NSString *comment = model.data[@"log"][@"comment_count"];
    self.favAndComment.text = [NSString stringWithFormat:@"点赞:%@次  评论:%@次",fav,comment];
    //时间
     [self setTimeWith:model.data[@"log"][@"created_date"]];
    //图片网址
    NSMutableArray *arr = _model.data[@"log"][@"posts"];
    self.pictersUrl = [NSMutableArray array];
     for (int i = 0; i < arr.count; i++) {
        NSString *pictureUrl = [[arr objectAtIndex:i][@"pictures"]objectAtIndex:0][@"picture"];
        [self.pictersUrl addObject:pictureUrl];
    }
            [self.carousel reloadData];


}
-(void)setTimeWith:(NSString*)str
{
    
    //1.获取微博的发送时间
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
         NSDate * createdDate = [NSDate dateWithTimeIntervalSince1970:[str integerValue] ];

    //2.判断微博发送时间 和 现在时间的差距
    
    if([createdDate isToday]){
        if(createdDate.deltaWithNow.hour >=1){
        self.updateTime.text = [NSString stringWithFormat:@"%ld小时以前",createdDate.deltaWithNow.hour];
        }else if (createdDate.deltaWithNow.minute>=1){
          self.updateTime.text =  [NSString stringWithFormat:@"%ld分钟以前",createdDate.deltaWithNow.minute];
        }else {//if (createdDate.deltaWithNow.second>0){
         self.updateTime.text = @"刚刚";
        }
        
    }else if (createdDate.isYestoday){
        //昨天
        fmt.dateFormat = @"dd HH:mm";
       self.updateTime.text = [fmt stringFromDate:createdDate];
    }else if (createdDate.isThisYear){
        fmt.dateFormat = @"MM-dd HH:mm";
       self.updateTime.text =  [fmt stringFromDate:createdDate];
    }else { //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
       self.updateTime.text = [fmt stringFromDate:createdDate];
    }


}
#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.pictersUrl.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 210, 180) ];
    view1.userInteractionEnabled =YES;
    [view1 sd_setImageWithURL:[NSURL URLWithString:self.pictersUrl[index] ]placeholderImage:[UIImage imageNamed:@"2.jpg" ]];
    return view1;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return self.pictersUrl.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return widthScaleMakeAdaptationScreen(250);
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

//-(void)closePhoto
//{
//    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        button.frame = CGRectMakeAdaptationScreen(0, 0, 0, 0);
//        fullImageView.frame = CGRectMakeAdaptationScreen(0, 0, 0, 0);
//        photoView.frame = CGRectMakeAdaptationScreen(0, 0, 0, 0);
//    } completion:^(BOOL finished) {
//        [photoView removeFromSuperview];
//    }];
//}

@end
