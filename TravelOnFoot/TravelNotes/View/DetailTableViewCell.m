//
//  DetailTableViewCell.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "XLTool.h"

@implementation DetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createdMyCell];
    }
    return self;
}
-(void)createdMyCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    self.backView = [[UIView alloc]init];
//    [self.contentView addSubview:self.backView];
    
    self.picture = [[UIImageView alloc]init];
    [self.contentView addSubview:self.picture];
    
    self.descriptions = [[UILabel alloc]init];
    [self.contentView addSubview:self.descriptions];
    self.favAndComment = [[UILabel alloc]init];
    [self.picture addSubview:self.favAndComment];
    
}
-(void)layoutSubviews
{
//CGFloat margin =  heightScaleMakeAdaptationScreen(1);
    [super layoutSubviews];
    self.favAndComment.frame = CGRectMakeAdaptationScreen(355 - 300, 355/pictureProportion-30, 295, 30);
    self.favAndComment.font = [UIFont systemFontOfSize:11];
    self.favAndComment.textAlignment = NSTextAlignmentRight;
    self.favAndComment.textColor = [UIColor whiteColor];
    
    self.picture.layer.cornerRadius = 5;
    self.picture.layer.masksToBounds = YES;
    self.picture.backgroundColor = [UIColor whiteColor];
    
    
   
    self.descriptions.numberOfLines = 0;
    self.descriptions.textAlignment = NSTextAlignmentLeft;
    self.descriptions.layer.cornerRadius = 5;
    self.descriptions.layer.masksToBounds = YES;
//    self.descriptions.backgroundColor = [UIColor redColor];

    
}



-(void)setModel:(DetailModel *)model
{
    CGFloat Hmargin =  heightScaleMakeAdaptationScreen(1);
    CGFloat Wmargin =  widthScaleMakeAdaptationScreen(1);

    _model = model;
    NSString *width =  [[model.pictures objectAtIndex:0]objectForKey:@"width"];
    NSString *height = [[model.pictures objectAtIndex:0]objectForKey:@"height"];
    pictureProportion = [width floatValue]/[height floatValue];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:[[model.pictures objectAtIndex:0]objectForKey:@"picture"]] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
 
    NSString *comment = model.comment_count;
    NSString *fav = model.fav_count;
    self.favAndComment.text = [NSString stringWithFormat:@"点赞:%@次  评论:%@次",fav,comment];
    self.picture.frame = CGRectMakeAdaptationScreen(10,20, 355, 355/pictureProportion);

    
//    self.descriptions.text = [model.descriptions stringByReplacingOccurrencesOfString:@"\r\n\r\n" withString:@"\r\n"];
    h = 0 ;
    self.cellhight = 0;

    self.descriptions.text = model.descriptions ;
      if (self.descriptions.text.length != 0) {
        
        h = [XLTool getTextSizeWithText:self.descriptions.text textWidth:355*Wmargin textFont:heightScaleMakeAdaptationScreen(16)].size.height;
          self.descriptions.frame = CGRectMake(10*Wmargin, (355/pictureProportion)*Hmargin +30, 355*Wmargin, h);
          self.descriptions.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(16)];
          
          self.cellhight = CGRectGetMaxY(self.descriptions.frame) +heightScaleMakeAdaptationScreen(20);
      }else{
          self.cellhight = CGRectGetMaxY(self.picture.frame) +heightScaleMakeAdaptationScreen(20);

      }
     
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
