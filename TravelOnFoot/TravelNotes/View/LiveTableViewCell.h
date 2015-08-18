//
//  LiveTableViewCell.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LiveCollectionViewCell.h"
#import "LiveModel.h"

@interface LiveTableViewCell : UITableViewCell

{
    UIView *photoView;
    UIButton *button;
     UIImageView *fullImageView;
}
@property(nonatomic,strong)NSMutableArray *pictersUrl;
@property(nonatomic,strong)NSMutableArray *pictersArray;
@property(nonatomic,strong)UIView *backView;//背视图
@property(nonatomic,strong)UIImageView *userImage;//用户头像
@property(nonatomic,strong)UILabel *userNickName;//用户名
@property(nonatomic,strong)UILabel *postName;//帖子标题
@property(nonatomic,strong)UIView *photosView;//照片视图
@property(nonatomic,strong)UILabel *added_post_count;//更新了多少张图片
@property(nonatomic,strong)UILabel *updateTime;//更新时间
@property(nonatomic,strong)UILabel *favAndComment;//帖子点赞和评论次数
//@property(nonatomic,strong)UIImageView *favImage;//帖子点赞图标
//@property(nonatomic,strong)UILabel *favCount;//帖子点赞次数
//@property(nonatomic,strong)UIImageView *commentImage;//帖子评论图标
//@property(nonatomic,strong)UILabel *comment_count;//帖子评论次数
@property(nonatomic,strong)LiveModel *model;



@end
