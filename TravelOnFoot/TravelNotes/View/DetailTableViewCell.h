//
//  DetailTableViewCell.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "UIImageView+WebCache.h"
@interface DetailTableViewCell : UITableViewCell

{
    CGFloat h;
    CGFloat pictureProportion;
}
//@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *picture;
@property(nonatomic,strong)UILabel *descriptions;
@property(nonatomic,strong)UILabel *favAndComment;//点赞和评论人数
@property(nonatomic,strong)DetailModel *model;

@property(nonatomic,assign)CGFloat  cellhight ;


@end
