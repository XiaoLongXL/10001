//
//  RecommentTableViewCell.h
//  Travel3
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentModel.h"

@interface RecommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *userImage;//用户头像
@property(nonatomic,strong)UILabel *userName;//用户名
@property(nonatomic,strong)UIImageView *photo;//推荐图片

//@property(nonatomic,strong)UIImageView *fav_View;//点赞图标
//@property(nonatomic,strong)UILabel *fav_count;//点赞人数
//
//@property(nonatomic,strong)UIImageView *focus;//关注图标
//@property(nonatomic,strong)UILabel *view_count;//点赞人数
@property(nonatomic,strong)UILabel *focusAndFav;
@property(nonatomic,strong)UILabel *postsName;//游记标题
@property(nonatomic,strong)UILabel *destination;//目的地
@property(nonatomic,strong)UILabel *start_date;//开始时间,天数,和图片数

@property(nonatomic,strong)RecommentModel *model;//接收数据的模型


@end
