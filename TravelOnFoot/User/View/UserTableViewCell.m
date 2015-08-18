//
//  UserTableViewCell.m
//  Travel3
//
//  Created by xiaolong on 15/8/4.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "UserTableViewCell.h"
#import "XLTool.h"
@implementation UserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString * cellID = @"ctivityTableViewCell1";
    UserTableViewCell * cell = [tabelView  dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubview];
//        [self setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    }
    return self;
}
-(void)setupSubview
{
 
    
 
    self.Myimagview = [[UIImageView alloc ]init];
//                      WithFrame:CGRectMakeAdaptationScreen(15, 15, 80, 80) ];
//    _Myimagview.contentMode = UIViewContentModeCenter ;

   [self.contentView addSubview:_Myimagview];

    self.Mytitle = [[UILabel alloc]init];
//                    WithFrame:CGRectMakeAdaptationScreen(100, 15, 80, 80) ];
    _Mytitle.numberOfLines = 0;
//    _Mytitle.contentMode = UIViewContentModeCenter ;
//    _Mytitle.lineBreakMode = NSLineBreakByWordWrapping;
    _Mytitle.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(20)];
    [self.contentView addSubview:_Mytitle];

  }

@end
