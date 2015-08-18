//
//  DetailTableForHeadView.m
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "DetailTableForHeadView.h"

#import "XLTool.h"
#import "UIImageView+WebCache.h"
@implementation DetailTableForHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMyView];
    }
    return self;
}

-(void)createMyView
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 250)];
    [self addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.cover = [[UIImageView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 0, 375, 200)];
    [self.backView addSubview:self.cover];
    
    self.avatar = [[UIImageView alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 160, 40, 40)];
    self.avatar.layer.cornerRadius = widthScaleMakeAdaptationScreen(20);
    self.avatar.layer.masksToBounds = YES;
    [self.cover addSubview:self.avatar];
    
    self.nickname = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(50, 170, 250, 30)];
    self.nickname.textColor = [UIColor whiteColor];
    self.nickname.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(17)];
    [self.cover addSubview:self.nickname];
    
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 200, 375, 25)];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(16)];
    [self.backView addSubview:self.name];
    
    
    self.start_date = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(0, 225, 375, 20)];
    self.start_date.textAlignment = NSTextAlignmentCenter;
    self.start_date.font = [UIFont systemFontOfSize:12];
    self.start_date.textColor = [UIColor grayColor];
    [self.backView addSubview:self.start_date];
    
}


-(void)setModel:(DetailHeadModel *)model
{
    _model = model;
//    self.cover.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.cover]]];
    CGFloat  proportion = image.size.width / image.size.height;
    if (proportion < 0.8) {
        self.backView.frame = CGRectMakeAdaptationScreen(0, 0, 375, 350);
        self.cover.frame = CGRectMakeAdaptationScreen(0, 0, 375, 300);
        self.avatar.frame = CGRectMakeAdaptationScreen(0, 260, 40, 40);
        self.nickname.frame = CGRectMakeAdaptationScreen(50, 270, 100, 30);
        self.name.frame = CGRectMakeAdaptationScreen(0, 300, 375, 25);
        self.start_date.frame = CGRectMakeAdaptationScreen(0, 325, 375, 20);
    }

//    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"dengdai"]];
    self.cover.image = image;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.created_by[@"avatar"]] placeholderImage:nil];
    self.nickname.text = model.created_by[@"nickname"];
    self.name.text = model.name;
    if (_model == nil) {
    [self.start_date removeFromSuperview];
    }else{
    self.start_date.text = [NSString stringWithFormat:@"----------%@    %@天    %@图----------",model.start_date,model.total_days,model.photo_number];
    }
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
