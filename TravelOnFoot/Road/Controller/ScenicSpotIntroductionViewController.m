//
//  ScenicSpotIntroductionViewController.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "ScenicSpotIntroductionViewController.h"
#import "XLTool.h"
#import "UIImageView+WebCache.h"
#import "CollectionTool.h"
#import "RequestBaseClass.h"
#import "NSDate+XL.h"
#import "JSONKit.h"

#import "RouteDownLoadPictureTool.h"
#import "ScenicSpotIntroductionView.h"
#import "specialChoicenessView.h"
#import "FMDatabase.h"
//#import "CollectionTool.h"



@interface ScenicSpotIntroductionViewController ()<UITableViewDataSource,UITableViewDelegate,sendDataDelegate,sendDataDelegate2,sendDataDelegate3>

{
    CGFloat height;
    CGFloat height2;
    CGFloat height3;
    NSString *string2;

    
        UIImageView *imagevAddress;
        UIScrollView *scrollView;
        UILabel *fitPeopleLabel;
        
        UILabel *label1;
        UILabel *label2;
        UILabel *label3;
        UILabel *label4;
        UILabel *label5;
        UILabel *label6;
        UILabel *label7;
        UILabel *label8;
        UILabel *label9;
        
        UIView *EvaluateHeadView;
        
        UILabel *allEvaluateLabel;
        UILabel *scoreLabel;
        
        UIImageView *imageViewAvatar;
        UILabel *nicknameLabel;
        UILabel *commentLabel;
        
        UIImageView *imageViewAvatar2;
        UILabel *nicknameLabel2;
        UILabel *commentLabel2;
        
        UIImageView *imagevSpecial;
        
        UILabel *correlationLabel;
        UIImageView *correlationImagev1;
        UIImageView *correlationImagev2;
        UIImageView *correlationImagev3;
        UILabel *correlationLabel1;
        UILabel *correlationLabel2;
        UILabel *correlationLabel3;
        
        FMDatabase *db;
        CollectionModel *coll;
        
        UILabel *timeLabel1;
        UILabel *timeLabel2;
    }
    
    
    @property(nonatomic,strong)UILabel *titleLabel;
    @property(nonatomic,strong)UILabel *headTitleLabel;
    @property(nonatomic, strong)UILabel *addressLabel;
    @property(nonatomic, strong)UILabel *mainDetail;
    
    @property(nonatomic,strong)NSMutableArray *SecenisArray;
    @property(nonatomic,strong)NSMutableArray *SecenisArray2;
    @property(nonatomic,strong)NSMutableArray *SecenisArray3;
    @property(nonatomic,strong) UITableView *tab;
    
    
    
    
    @property(nonatomic,strong)NSMutableArray *tagArray;
    @property(nonatomic,strong)SceniceRouteModel *prm;
    @property(nonatomic,strong)NSMutableArray *cellArray;
    
@end
    
@implementation ScenicSpotIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupIntroduce];
    [self setupMessage];
    [self setupOtherRoute];
}
-(void)setupIntroduce
{
    self.tab = [[UITableView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 667)];
    _tab.dataSource = self;
    _tab.delegate = self;
    _tab.showsHorizontalScrollIndicator = NO;
    _tab.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tab];
    
    self.headTitleLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 240, 30)];
    self.headTitleLabel.text = self.HeadTitle;
    self.headTitleLabel.textAlignment = NSTextAlignmentCenter;
    //    NSLog(@"%@", self.HeadTitle);
    self.navigationItem.titleView = self.headTitleLabel;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMakeAdaptationScreen(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"btn_nav_back@2x"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(touchLeft) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMakeAdaptationScreen(0, 0, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"btn_nav_share@2x"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(touchRight) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    
    RouteDownLoadPictureTool *rdTool = [[RouteDownLoadPictureTool alloc] init];
    NSString *str = self.idString;
    [rdTool downLoadData:str];
    rdTool.myDelegate = self;
    
    
    RouteDownLoadPictureTool *rdTool2 = [[RouteDownLoadPictureTool alloc] init];
    [rdTool2 downLoaddataRoute5:self.idString3];
    rdTool2.myDelegate2 = self;
    
    
    RouteDownLoadPictureTool *rdTool3 = [[RouteDownLoadPictureTool alloc] init];
    [rdTool3 downLoaddataRoute6:self.idString4];
    rdTool3.myDelegate3 = self;
    
    fitPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(3, 2, 200, 40)];
    //    fitPeopleLabel.backgroundColor = [UIColor greenColor];
    fitPeopleLabel.text = @"适合人群";
    fitPeopleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fitPeopleLabel.textColor = [UIColor colorWithRed:93 / 255.0 green:173 / 255.0 blue:253 / 255.0 alpha:1];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(30, 45, 100, 20)];
    label2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(140, 45, 100, 20)];
    label3 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(250, 45, 100, 20)];
    label4 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(30, 75, 100, 20)];
    label5 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(140, 75, 100, 20)];
    label6 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(250, 75, 100, 20)];
    label7 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(30, 105, 100, 20)];
    label8 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(140, 105, 100, 20)];
    label9 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(250, 105, 100, 20)];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 10, 375, 50)];
    scrollView.backgroundColor = [UIColor whiteColor];
    // 设置可滚动的范围
    scrollView.contentSize = CGSizeMake(widthScaleMakeAdaptationScreen(375) * 1.2, 0);
    // 分页显示
    scrollView.pagingEnabled = YES;
    // 是否允许首尾页继续滑动
    scrollView.bounces = YES;
    // 取消滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            return;
        }else {
            // json解析
            NSMutableDictionary *dic = [data objectFromJSONData];
            NSMutableArray *arr = [dic objectForKey:@"tag"];
            for (int i = 0; i < [arr count]; i++) {
                SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
                srm.tagIcon = [[arr objectAtIndex:i] valueForKey:@"icon"];
                UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(70 * i + 10, 0, 50, 50)];
                imagev.backgroundColor = [UIColor clearColor];
                NSURL *url = [NSURL URLWithString:srm.tagIcon];
                [imagev sd_setImageWithURL:url placeholderImage:nil];
                [scrollView addSubview:imagev];
            }
            
            
            self.prm = [[SceniceRouteModel alloc] init];
            self.prm.sceniceName = [dic objectForKey:@"name"];
            self.prm.sceniceAddress = [dic objectForKey:@"destination"];
            self.prm.mainDetail = [dic objectForKey:@"detail"];
            self.titleLabel.text = self.prm.sceniceName;
            self.addressLabel.text = self.prm.sceniceAddress;
            self.mainDetail.text = self.prm.mainDetail;
            self.mainDetail.numberOfLines = 0;
            self.mainDetail.font = [UIFont systemFontOfSize:15];
            [self.mainDetail sizeToFit];
            height = CGRectGetMaxY(self.mainDetail.frame) + 5;
            [_tab reloadData];
            
            
            NSMutableArray *arr2 = [dic objectForKey:@"crowds"];
            for (int i = 0; i < [arr2 count]; i++) {
                SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
                srm.crowdsName = [[arr2 objectAtIndex:i] valueForKey:@"name"];
                srm.crowdsCount = [[arr2 objectAtIndex:i] valueForKey:@"count"];
                if (i == 0) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label1.text = str;
                    label1.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label1.font = [UIFont systemFontOfSize:15];
                    label1.textColor = [UIColor blueColor];
                    label1.layer.cornerRadius = 3;
                    label1.layer.masksToBounds = YES;
                    label1.layer.borderColor = [UIColor grayColor].CGColor;
                    label1.layer.borderWidth = 1;
                } else if (i == 1) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label2.text = str;
                    label2.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label2.font = [UIFont systemFontOfSize:15];
                    label2.textColor = [UIColor blueColor];
                    label2.layer.cornerRadius = 3;
                    label2.layer.masksToBounds = YES;
                    label2.layer.borderColor = [UIColor grayColor].CGColor;
                    label2.layer.borderWidth = 1;
                }else if (i == 2) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label3.text = str;
                    label3.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label3.font = [UIFont systemFontOfSize:15];
                    label3.textColor = [UIColor blueColor];
                    label3.layer.cornerRadius = 3;
                    label3.layer.masksToBounds = YES;
                    label3.layer.borderColor = [UIColor grayColor].CGColor;
                    label3.layer.borderWidth = 1;
                }else if (i == 3) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label4.text = str;
                    label4.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label4.font = [UIFont systemFontOfSize:15];
                    label4.textColor = [UIColor blueColor];
                    label4.layer.cornerRadius = 3;
                    label4.layer.masksToBounds = YES;
                    label4.layer.borderColor = [UIColor grayColor].CGColor;
                    label4.layer.borderWidth = 1;
                }else if (i == 4) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label5.text = str;
                    label5.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label5.font = [UIFont systemFontOfSize:15];
                    label5.textColor = [UIColor blueColor];
                    label5.layer.cornerRadius = 3;
                    label5.layer.masksToBounds = YES;
                    label5.layer.borderColor = [UIColor grayColor].CGColor;
                    label5.layer.borderWidth = 1;
                }else if (i == 5) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label6.text = str;
                    label6.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label6.font = [UIFont systemFontOfSize:15];
                    label6.textColor = [UIColor blueColor];
                    label6.layer.cornerRadius = 3;
                    label6.layer.masksToBounds = YES;
                    label6.layer.borderColor = [UIColor grayColor].CGColor;
                    label6.layer.borderWidth = 1;
                }else if (i == 6) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label7.text = str;
                    label7.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label7.font = [UIFont systemFontOfSize:15];
                    label7.textColor = [UIColor blueColor];
                    label7.layer.cornerRadius = 3;
                    label7.layer.masksToBounds = YES;
                    label7.layer.borderColor = [UIColor grayColor].CGColor;
                    label7.layer.borderWidth = 1;
                }else if (i == 7) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label8.text = str;
                    label8.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label8.font = [UIFont systemFontOfSize:15];
                    label8.textColor = [UIColor blueColor];
                    label8.layer.cornerRadius = 3;
                    label8.layer.masksToBounds = YES;
                    label8.layer.borderColor = [UIColor grayColor].CGColor;
                    label8.layer.borderWidth = 1;
                }else if (i == 8) {
                    NSString *str = [NSString stringWithFormat:@"%@ +%@",srm.crowdsName, srm.crowdsCount];
                    label9.text = str;
                    label9.backgroundColor = [UIColor colorWithRed:116 / 255.0 green:194 / 255.0 blue:150 / 255.0 alpha:1];
                    label9.font = [UIFont systemFontOfSize:15];
                    label9.textColor = [UIColor blueColor];
                    label9.layer.cornerRadius = 3;
                    label9.layer.masksToBounds = YES;
                    label9.layer.borderColor = [UIColor grayColor].CGColor;
                    label9.layer.borderWidth = 1;
                }
            }
        }
    }];
    
    
    
 
}
-(void)setupMessage
{
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(3, 0, 200, 40)];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(25, 40, 200, 20)];
    self.addressLabel.font = [UIFont boldSystemFontOfSize:12];
    
    self.mainDetail = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(10, 65, 355, 100)];
    
    imagevAddress = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(3, 40, 20, 20)];
    imagevAddress.image = [UIImage imageNamed:@"address"];
    
    
    
    
    EvaluateHeadView = [[UIView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 40)];
    EvaluateHeadView.backgroundColor = [UIColor colorWithRed:113 / 255.0 green:180 / 255.0 blue:255 / 255.0 alpha:1];
    
    
    UILabel *EvaluateLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(10, 10, 40, 20)];
    EvaluateLabel.text = @"评价";
    [EvaluateHeadView addSubview:EvaluateLabel];
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(60, 10, 50, 20)];
    [EvaluateHeadView addSubview:scoreLabel];
    allEvaluateLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(200, 10, 150, 20)];
    [EvaluateHeadView addSubview:allEvaluateLabel];
    timeLabel1 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(200, 70, 170, 20)];
    timeLabel1.backgroundColor = [UIColor clearColor];
    


    
    
    imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(20, 53, 40, 40)];
    imageViewAvatar.layer.cornerRadius = widthScaleMakeAdaptationScreen(18);
    imageViewAvatar.layer.masksToBounds = YES;
    nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(70, 53, 180, 20)];
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(20, 103, 350, 20)];
    commentLabel.font = [UIFont systemFontOfSize:14];
    timeLabel2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(200, 30, 170, 20)];
    timeLabel2.backgroundColor = [UIColor clearColor];
 
    
    
    
    
    imageViewAvatar2 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(20, 10, 40, 40)];
    imageViewAvatar2.layer.cornerRadius = widthScaleMakeAdaptationScreen(18);
    imageViewAvatar2.layer.masksToBounds = YES;
    nicknameLabel2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(70, 10, 180, 20)];
    commentLabel2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(20, 60, 350, 20)];
    commentLabel2.font = [UIFont systemFontOfSize:14];
    
    
    
    
    NSString *str2 = self.idString2;
    NSURL *url2 = [NSURL URLWithString:str2];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            return;
        }
        NSMutableDictionary *dic = [data objectFromJSONData];
        SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
        srm.total = [dic objectForKey:@"total"];
        
        NSString *str = [NSString stringWithFormat:@"全部评价: %@", srm.total];
        allEvaluateLabel.text = str;
        
        NSMutableArray *arr = [dic objectForKey:@"comments"];
        for (int i = 0; i < [arr count]; i++) {
            SceniceRouteModel *srm1 = [[SceniceRouteModel alloc] init];
            srm1.trail_score = [[[arr objectAtIndex:i] valueForKey:@"trail_score"] stringValue];
            NSString *str = [NSString stringWithFormat:@"%@ 分", srm1.trail_score];
            scoreLabel.text = str;
            srm1.comment = [[arr objectAtIndex:i] valueForKey:@"comment"];
            srm1.avatar = [[[arr objectAtIndex:i] valueForKey:@"created_by"] valueForKey:@"avatar"];
            srm1.nickname = [[[arr objectAtIndex:i] valueForKey:@"created_by"] valueForKey:@"nickname"];
            srm1.createdDate = [[arr objectAtIndex:i] valueForKey:@"created_date"];
            NSString *str22 = srm1.createdDate;
            if (i == 0) {
                commentLabel.text = srm1.comment;
                commentLabel.numberOfLines = 0;
                [commentLabel sizeToFit];
                height2 = CGRectGetMaxY(commentLabel.frame);
                NSURL *url = [NSURL URLWithString:srm1.avatar];
                [imageViewAvatar sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
                nicknameLabel.text = srm1.nickname;
                [self setTimeWith:str22];
                timeLabel1.text = string2;

            }else if (i == 1) {
                commentLabel2.text = srm1.comment;
                commentLabel2.numberOfLines = 0;
                [commentLabel2 sizeToFit];
                height3 = CGRectGetMaxY(commentLabel2.frame);
                NSURL *url = [NSURL URLWithString:srm1.avatar];
                [imageViewAvatar2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
                nicknameLabel2.text = srm1.nickname;
                [self setTimeWith:str22];
                timeLabel2.text = string2;
            }
        }
    }];
}
-(void)setupOtherRoute
{

    correlationLabel = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 200, 40)];
    correlationLabel.text = @"相关路线";
    correlationLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    
    
    correlationLabel1 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(15, 140, 110, 20)];
    correlationLabel1.backgroundColor = [UIColor blackColor];
    correlationLabel1.textAlignment = NSTextAlignmentCenter;
    correlationLabel1.font = [UIFont systemFontOfSize:12];
    correlationLabel1.textColor = [UIColor whiteColor];
    
    correlationLabel2 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(135, 140, 110, 20)];
    correlationLabel2.backgroundColor = [UIColor blackColor];
    correlationLabel2.textAlignment = NSTextAlignmentCenter;
    correlationLabel2.font = [UIFont systemFontOfSize:12];
    correlationLabel2.textColor = [UIColor whiteColor];
    
    correlationLabel3 = [[UILabel alloc] initWithFrame:CGRectMakeAdaptationScreen(255, 140, 110, 20)];
    correlationLabel3.backgroundColor = [UIColor blackColor];
    correlationLabel3.textAlignment = NSTextAlignmentCenter;
    correlationLabel3.font = [UIFont systemFontOfSize:12];
    correlationLabel3.textColor = [UIColor whiteColor];
    
    
    
    
    correlationImagev1 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(15, 40, 110, 100)];
    correlationImagev1.backgroundColor = [UIColor greenColor];
    correlationImagev2 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(135, 40, 110, 100)];
    correlationImagev2.backgroundColor = [UIColor greenColor];
    correlationImagev3 = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(255, 40, 110, 100)];
    correlationImagev3.backgroundColor = [UIColor greenColor];
    
    
    
    // 添加路线景点
    coll = [[CollectionModel alloc] init];
    coll.str = self.idString;
    coll.str2 = self.idString2;
    coll.str3 = self.idString3;
    coll.str4 = self.idString4;
    coll.title = self.HeadTitle;
    
}

-(void)sendDataFromTool:(NSData *)data
{
    if (data == nil) {
        return ;
    }
    // json解析
    NSMutableDictionary *dic = [data objectFromJSONData];
    NSMutableArray *arr = [dic objectForKey:@"pictures"];
    self.SecenisArray = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
        srm.picture = [[arr objectAtIndex:i] valueForKey:@"picture"];
        [self.SecenisArray addObject:srm];
    }
    
    // 加表头
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 250)];
    imagev.backgroundColor = [UIColor whiteColor];
    imagev.userInteractionEnabled = YES;
    _tab.tableHeaderView = imagev;
    
    ScenicSpotIntroductionView *scenicView = [[ScenicSpotIntroductionView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 250)];
    // 给数据源赋值
    scenicView.array = self.SecenisArray;
      [imagev addSubview:scenicView];
    [_tab reloadData];
}


-(void)sendDataFromTool2:(NSMutableArray *)array2
{
    self.SecenisArray2 = array2;
    if (self.SecenisArray2.count == 0) {
        return;
    }
    NSMutableArray  *array3 = [NSMutableArray array];
    for (int i = 0; i < [self.SecenisArray2 count]; i++) {
        SceniceRouteModel *srm = [self.SecenisArray2 objectAtIndex:i];
        [array3 addObject:srm];
    }
    
    imagevSpecial = [[UIImageView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 300)];
    imagevSpecial.backgroundColor = [UIColor whiteColor];
    imagevSpecial.userInteractionEnabled = YES;
    
    
    // 给数据源赋值
    specialChoicenessView *specialView = [[specialChoicenessView alloc] initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 300)];
     specialView.array = array3;
    [imagevSpecial addSubview:specialView];
    [_tab reloadData];
}





-(void)sendDataFromTool3:(NSMutableArray *)array3
{
    self.SecenisArray3 = array3;
    if (self.SecenisArray3.count == 0) {
        return;
    }
    for (int i = 0; i < 3; i++) {
        if (!self.SecenisArray3.count == 0) {
        SceniceRouteModel *srm = self.SecenisArray3[i];
        if (i == 0) {
            NSURL *url;
            if ([srm.correlationCover isEqual:[NSNull null]]) {
            }else {
            url = [NSURL URLWithString:srm.correlationCover];
            }
            [correlationImagev1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
            correlationLabel1.text = srm.correlationName;
        }else if (i == 1) {
            NSURL *url;
            if ([srm.correlationCover isEqual:[NSNull null]]) {
                
            }else {
                url = [NSURL URLWithString:srm.correlationCover];
            }
            [correlationImagev2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
            correlationLabel2.text = srm.correlationName;
                                                                         
        }else {
            NSURL *url;
            if ([srm.correlationCover isEqual:[NSNull null]]) {
                
            }else {
            url = [NSURL URLWithString:srm.correlationCover];
            }
            [correlationImagev3 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"19-281.jpg"]];
            correlationLabel3.text = srm.correlationName;
        }
    }
}
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    //if (cell == nil) {
      UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    //}
    if (indexPath.row == 0) {
        [cell addSubview:scrollView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 1) {
        cell.userInteractionEnabled = NO;
        [cell addSubview:self.titleLabel];
        [cell addSubview:self.addressLabel];
        [cell addSubview:self.mainDetail];
        [cell addSubview:imagevAddress];
    }else if (indexPath.row == 2) {
        [cell addSubview:fitPeopleLabel];
        [cell addSubview:label9];
        [cell addSubview:label8];
        [cell addSubview:label7];
        [cell addSubview:label6];
        [cell addSubview:label5];
        [cell addSubview:label4];
        [cell addSubview:label3];
        [cell addSubview:label2];
        [cell addSubview:label1];
        cell.userInteractionEnabled = NO;
    }else if (indexPath.row == 3) {
        [cell addSubview:EvaluateHeadView];
        [cell addSubview:imageViewAvatar];
        [cell addSubview:commentLabel];
        [cell addSubview:nicknameLabel];
        [cell addSubview:timeLabel1];
        cell.userInteractionEnabled = NO;
    }else if (indexPath.row == 4) {
        [cell addSubview:commentLabel2];
        [cell addSubview:imageViewAvatar2];
        [cell addSubview:nicknameLabel2];
        [cell addSubview:timeLabel2];
        cell.userInteractionEnabled = NO;
    }else if (indexPath.row == 5) {
        [cell addSubview:imagevSpecial];
    }else if (indexPath.row == 6) {
        if (self.SecenisArray3.count != 0) {
        [cell addSubview:correlationLabel];
        [cell addSubview:correlationImagev1];
        [cell addSubview:correlationImagev2];
        [cell addSubview:correlationImagev3];
        [cell addSubview:correlationLabel1];
        [cell addSubview:correlationLabel2];
        [cell addSubview:correlationLabel3];
        cell.userInteractionEnabled = NO;
    }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return heightScaleMakeAdaptationScreen(70);
    }else if (indexPath.row == 1) {
        return height;
    }else if (indexPath.row == 2) {
        return heightScaleMakeAdaptationScreen(150);
    }else if (indexPath.row == 3) {
        return height2 + heightScaleMakeAdaptationScreen(5);
    }else if (indexPath.row == 4) {
        return height3 + heightScaleMakeAdaptationScreen(30);
    }else if (indexPath.row == 5) {
        return heightScaleMakeAdaptationScreen(310);
    }else if (indexPath.row == 6) {
        if (self.SecenisArray3.count != 0) {
        return heightScaleMakeAdaptationScreen(200);
        }
    }
    return NO;
}




-(void)touchLeft
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchRight
{
 // 点击添加到数据库
    // 获取要保存的景点
    CollectionTool *tool = [[CollectionTool alloc] init];
    // 插入
    if ([tool existsWithRouteName:coll.title]) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }else {
         [tool insertToRouteCollectTable:coll];
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加到收藏夹成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
  
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
            string2 = [NSString stringWithFormat:@"%ld小时以前",createdDate.deltaWithNow.hour];
        }else if (createdDate.deltaWithNow.minute>=1){
            string2 =  [NSString stringWithFormat:@"%ld分钟以前",createdDate.deltaWithNow.minute];
        }else {//if (createdDate.deltaWithNow.second>0){
            string2 = @"刚刚";
        }
        
    }else if (createdDate.isYestoday){
        //昨天
        fmt.dateFormat = @"dd HH:mm";
        string2 = [fmt stringFromDate:createdDate];
    }else if (createdDate.isThisYear){
        fmt.dateFormat = @"MM-dd HH:mm";
        string2 =  [fmt stringFromDate:createdDate];
    }else { //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        string2 = [fmt stringFromDate:createdDate];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 


}



@end
