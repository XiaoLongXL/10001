//
//  RecommentTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RecommentTableViewCell.h"

#import "XLTool.h"
#import "UIImageView+WebCache.h"
@implementation RecommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createRecommentViewCell];
    }
    return self;
}

-(void)createRecommentViewCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.self.backView];
    
    self.userImage = [[UIImageView alloc]init];
    [self.backView addSubview:self.userImage];
    
    self.userName = [[UILabel alloc]init];
    [self.backView addSubview:self.userName];
    
    self.photo = [[UIImageView alloc]init];
    [self.backView addSubview:self.photo];
    
    self.postsName = [[UILabel alloc]init];
    [self.photo addSubview:self.postsName];
    
    self.focusAndFav = [[UILabel alloc]init];
    [self.photo addSubview:self.focusAndFav];
    
    self.start_date = [[UILabel alloc]init];
    [self.backView addSubview:self.start_date];
    
    //目的地
    self.destination = [[UILabel alloc]init];
    [self.backView addSubview:self.destination];
    
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat margin = widthScaleMakeAdaptationScreen(1);
    self.backView.frame = CGRectMakeAdaptationScreen(10, 10,375-20, 300-20);
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    
    self.userImage.frame = CGRectMakeAdaptationScreen(0, 0, 40, 40);
    self.userImage.layer.cornerRadius = widthScaleMakeAdaptationScreen(40)/2;
    self.userImage.layer.masksToBounds = YES;
    

    
    
    
    self.userName.frame = CGRectMakeAdaptationScreen(50, 10, 110, 30);
    self.userName.font = [UIFont systemFontOfSize:15];
    self.userName.textColor = [UIColor colorWithRed:115/255.0 green:167/255.0 blue:205/255.0 alpha:1];
    
    self.photo.frame = CGRectMakeAdaptationScreen(0, 45, 375-20, 280 - 45);
    self.photo.layer.cornerRadius = 5;
    self.photo.layer.masksToBounds = YES;
    
    
    //日期
    self.start_date.frame = CGRectMakeAdaptationScreen(355 - 200, 5, 195, 15);
    self.start_date.textAlignment = NSTextAlignmentRight;
    self.start_date.font = [UIFont systemFontOfSize:11];
    //目的地
    self.destination.frame = CGRectMakeAdaptationScreen(355 - 200, 20, 195, 15);
    self.destination.textAlignment = NSTextAlignmentRight;
    self.destination.font = [UIFont systemFontOfSize:11];
    
    
    self.postsName.frame = CGRectMakeAdaptationScreen(10, 0, 355 - 30, 60);
    self.postsName.font = [UIFont systemFontOfSize:14];
    self.postsName.textColor = [UIColor blackColor];
    self.postsName.numberOfLines = 0;
  
    self.focusAndFav.frame = CGRectMakeAdaptationScreen(355 - 300, 210, 295, 30);
    self.focusAndFav.font = [UIFont systemFontOfSize:11];
    self.focusAndFav.textAlignment = NSTextAlignmentRight;
    self.focusAndFav.textColor = [UIColor whiteColor];
    
}

-(void)setModel:(RecommentModel *)model
{
    _model = model;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:model.created_by[@"avatar"]] placeholderImage:nil];

    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    self.userName.text = model.created_by[@"nickname"];
    NSString *fav = [NSString stringWithFormat:@"%ld",(long)model.fav_count];
    NSString *foucs = [NSString stringWithFormat:@"%ld",(long)model.view_count];
    self.focusAndFav.text = [NSString stringWithFormat:@"关注:%@人  点赞:%@次",foucs,fav];
    self.postsName.text = model.name;
    self.start_date.text = [NSString stringWithFormat:@"%@ %@天 %@图",model.start_date,model.total_days,model.photo_number];
    self.destination.text = model.destination;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
