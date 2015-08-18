//
//  LiveModel.h
//  Travel3
//
//  Created by lanou on 15/7/24.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject
@property(nonatomic,strong)NSDictionary *data;
//@property(nonatomic,strong)NSDictionary *created_by;
//@property(nonatomic,strong)NSDictionary *posts;
//@property(nonatomic,strong)NSArray *pictures;
//@property(nonatomic,strong)NSString *name;//帖子标题
////@property(nonatomic,strong)NSString *avatar;//用户头像
//@property(nonatomic,strong)NSString *nickname;//用户名
//@property(nonatomic,strong)NSString *added_post_count;//更新了多少张图片
//@property(nonatomic,strong)NSString *updateTime;//更新时间
//@property(nonatomic,strong)NSString *fav_count;//帖子点赞按钮
//@property(nonatomic,strong)NSString *comment_count;//帖子评论按钮
@property(nonatomic,strong)NSString *ID;

+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
