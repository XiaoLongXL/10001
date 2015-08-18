//
//  UserTableViewCell.h
//  Travel3
//
//  Created by xiaolong on 15/8/4.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * Myimagview;

@property (nonatomic,strong) UILabel * Mytitle;
+(instancetype)cellWithTableView:(UITableView *)tabelView;

@end
