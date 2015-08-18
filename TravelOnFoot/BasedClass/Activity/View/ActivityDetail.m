
//
//  ActivityDetail.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "ActivityDetail.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
//#import "CarouselView.h"
#import "iCarousel.h"
@interface ActivityDetail()<iCarouselDataSource,iCarouselDelegate>
//@property(nonatomic,weak) CarouselView * carouseView;
@property(nonatomic,strong) UIScrollView * scrollview;
@property(nonatomic,strong) NSMutableArray * pictureStrArray;
@property (nonatomic, strong)  iCarousel *carousel;


@end
@implementation ActivityDetail
-(NSMutableArray *)pictureStrArray
{
    if (_pictureStrArray==nil) {
        _pictureStrArray = [NSMutableArray array];
    }
    return _pictureStrArray;
}
- (instancetype)initWithFrame:(CGRect)frame activityDetailModel:(ActivityDetailModel*)activityDetailModel activitiesModel:(ActivitiesModel*)activitiesModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.scrollview = [[UIScrollView alloc]initWithFrame:frame];
        self.activityDetailModel =activityDetailModel;
        self.activitiesModel = activitiesModel;
        [self setupViews];
        [self addSubview:_scrollview];
        
     }
    return self;
}
-(void)setupViews
{
    CGFloat margin = widthScaleMakeAdaptationScreen(10);
    CGFloat Width = [UIScreen mainScreen].bounds.size.width - 6*margin;
    ;
    CGFloat iconWH = 3*margin;
    CGFloat lableH = 3*margin;
    
    CGFloat lableX = 3*margin;
    
    
    //标题
    CGRect titleRect = [XLTool getTextSizeWithText:self.activitiesModel.title textWidth:Width textFont:30];
    UILabel * title = [self labelWithX:lableX Y:2*margin W:Width H:titleRect.size.height];
    title.text = self.activitiesModel.title;
    title.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:3.0*margin];
    title.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    //图标
    CGFloat photoY = CGRectGetMaxY(title.frame)+margin*0.5;
    UIImageView * photoView = [self imageViewWithX:lableX Y:photoY W:iconWH*2 H:iconWH*2 ];
    
    [photoView sd_setImageWithURL:[NSURL URLWithString:self.activityDetailModel.club[@"logo"]] placeholderImage:[UIImage imageNamed:@"a22"]];
    
    
    CGFloat clubNameX = CGRectGetMaxX(photoView.frame)+margin;
    
    UILabel * clubName = [self labelWithX:margin + clubNameX Y:photoY W:Width -clubNameX H:iconWH*2];
    clubName.contentMode = UIViewContentModeCenter ;
    clubName.text = self.activityDetailModel.club[@"title"];
    [clubName setFont:[UIFont systemFontOfSize:1.9*margin]];
    //轮播图
    CGFloat repeatPhotoViewY = CGRectGetMaxY(photoView.frame)+ margin*1.5;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(lableX, repeatPhotoViewY, Width, 25*margin)];
    //    view.backgroundColor = [UIColor cyanColor];
    [_scrollview addSubview:view];
    if (_activityDetailModel.pictures.count==0) {
//        [XLTool showAlertViewWithTitle:@"提示" message:@"数据有错误,暂无图片" cancelButtonTitle:@"确定" otherButtonTitle:nil];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        label.text = @"暂无相关图片!";
        label.textColor = [UIColor blackColor];
        label.contentMode = UIViewContentModeCenter;
        
        label.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:2.2 *margin];
        view.frame = CGRectMake(lableX, repeatPhotoViewY, Width, 8*margin);
        [view addSubview:label];

    }else{
//        CarouselView * carouseView = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, Width, 18*margin)];
        
        //        if (pictureStr) {
        //            carouseView.array = pictureStr;
        //            [view addSubview:carouseView];
        //
        //        }
        NSMutableArray *array =  _activityDetailModel.pictures;
        for (NSDictionary * dic in array) {
            NSString * str = dic[@"picture"];
            [self.pictureStrArray addObject:str];
            
        }
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, Width, 25*margin)];
        self.carousel.dataSource = self;
        self.carousel.delegate = self;
//        [UIView beginAnimations:nil context:nil];
        self.carousel.type = iCarouselTypeCoverFlow2;
//        [UIView commitAnimations];
//        [_carousel reloadData];
        [view addSubview:self.carousel];

    }
    


    

    //时间
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
//        fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.dateFormat = @"MM 月 dd 日";
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:self.activityDetailModel.start_time];
    NSString * TimeStr = [fmt stringFromDate:date];
    
    CGFloat timeLabelY = CGRectGetMaxY(view.frame)+margin;
    
    UILabel * timeLabel = [self labelWithX:lableX Y:timeLabelY W:Width H:lableH];
        [timeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:1.7*margin]];
    timeLabel.text = [NSString stringWithFormat:@"活动时间:  %@",TimeStr];
    
    //地点
    CGFloat destinationY = CGRectGetMaxY(timeLabel.frame)+margin;
    
    UILabel * destination = [self labelWithX:lableX Y:destinationY W:Width H:lableH];
    
    destination.text = [NSString stringWithFormat:@"活动地点: %@",self.activitiesModel.destination];
    [destination setFont:[UIFont systemFontOfSize:1.7*margin]];

    //类型
    NSString * strTag = [NSMutableString stringWithString:@"活动类型: "];
    NSMutableArray * arrayTag = self.activityDetailModel.tag;
    for (NSString * str in arrayTag) {
        strTag = [strTag stringByAppendingFormat:@"%@ ",str];
    }
    CGFloat tagY = CGRectGetMaxY(destination.frame)+margin;
    
    UILabel * tag = [self labelWithX:lableX Y:tagY W:Width H:lableH];
    [tag setFont:[UIFont systemFontOfSize:1.7*margin]];

    tag.text = strTag;
    //人数
    CGFloat comment_countY = CGRectGetMaxY(tag.frame)+margin;
    
    UILabel * comment_count = [self labelWithX:lableX Y:comment_countY W:Width H:lableH];
    [comment_count setFont:[UIFont systemFontOfSize:1.7*margin]];

    comment_count.text = [NSString stringWithFormat:@"人员上限:   %ld ",(long)self.activityDetailModel.member_count];
    //    [comment_count setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:13]];
    
    //住宿
    CGFloat styleY = CGRectGetMaxY(comment_count.frame)+margin;
    
    UILabel * style = [self labelWithX:lableX Y:styleY W:Width H:lableH];
    [style setFont:[UIFont systemFontOfSize:1.7*margin]];

    style.text = @"住宿方式: 农家/露营";
    
    //人数
    CGFloat costY = CGRectGetMaxY(style.frame)+margin;
    
    UILabel * cost = [self labelWithX:lableX Y:costY W:Width H:lableH];
    cost.text = [NSString stringWithFormat:@"最低费用: ￥ %@",self.activityDetailModel.min_cost];
    [cost setFont:[UIFont fontWithName:@"Zapfino" size:1.7*margin]];
    
    CGFloat signUpY = CGRectGetMaxY(cost.frame)+margin;
    
    UILabel * sign = [self labelWithX:lableX Y:signUpY W:Width H:2*lableH];
    sign.text = [NSString stringWithFormat:@"报名须知"] ;
    [sign setFont:[UIFont systemFontOfSize:2.5*margin]];
    sign.textAlignment = NSTextAlignmentCenter;
    
    
    
    CGFloat contentY = CGRectGetMaxY(sign.frame);
    
    
    
    //    [self labelWithX:margin Y:contentY W:Width H:2*lableH];
    NSString * strContent = @"1.户外活动不同于常规的旅游活动,具有一定的探险性质,有一定的危险性和不可预知性。\n\n2.集体活动以大局为重,要做到互相体谅和帮助;安全第一,切记个人英雄主义,遇见问题,集体协商,尊重并服从领队做出的决定。\n\n3.请秉持'除了留下脚印,什么都不留下;除了照片,什么都不带走的环保理念'参与户外集体活动;\n\n4.活动中可能发生意外,活动组织者和领队将尽一切努力进行救护与援助;因意外带来的伤害和损失,活动组织者和领队不承担责任,强烈要求活动参与者购买保险。\n\n5.活动信息来自网络,有关活动和报名详情请联系活动组织者。";
    //    UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    CGRect rect = [XLTool getTextSizeWithText:strContent textWidth:Width textFont:1.6*margin];
    
    //    [content setFont:[UIFont systemFontOfSize:13]];
    UILabel * content = [self labelWithX:lableX Y:contentY W:Width H:rect.size.height];
    
    content.text = strContent;
    content.minimumScaleFactor = 1;
    [content setFont:[UIFont systemFontOfSize:1.5*margin]];

    
    content.textAlignment = NSTextAlignmentLeft;
    content.numberOfLines = 0;
    content.textColor = [UIColor blackColor];
    [content setFrame:CGRectMake(lableX, contentY, Width,rect.size.height)];
    //    [self addSubview:content];
    _scrollview.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(content.frame)+margin*2);
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
}

#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.pictureStrArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 230, 250) ];

    [view1 sd_setImageWithURL:[NSURL URLWithString:self.pictureStrArray[index]]placeholderImage:[UIImage imageNamed:@"a22" ]];
    return view1;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return self.pictureStrArray.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return widthScaleMakeAdaptationScreen(230);
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
-(UIImageView *)imageViewWithX:(CGFloat)X Y:(CGFloat)Y W:(CGFloat)W H:(CGFloat)H
{
    UIImageView * View = [[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
     [_scrollview addSubview:View];
    return View;
}

-(UILabel *)labelWithX:(CGFloat)X Y:(CGFloat)Y W:(CGFloat)W H:(CGFloat)H
{
    
    UILabel *  nameLabel  = [[UILabel alloc ]initWithFrame:CGRectMake(X, Y, W, H)];
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(14)];
    //    nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    //    nameLabel.textColor = [UIColor greenColor];
    [_scrollview addSubview:nameLabel];
    return nameLabel;
}



@end
