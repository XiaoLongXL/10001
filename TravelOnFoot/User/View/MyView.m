//
//  MyView.m
//  Travel3
//
//  Created by xiaolong on 15/8/4.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "MyView.h"
#import "XLTool.h"

@implementation MyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.Myimagview = [[UIImageView alloc ]initWithFrame:CGRectMakeAdaptationScreen(15, 15, 100, 100) ];
        self.Myimagview.center = CGPointMake(frame.size.width/2, 80);
        //    _Myimagview.contentMode = UIViewContentModeCenter ;
        self.Myimagview.image = [UIImage imageNamed:@"women.jpg"];
        [self addSubview:_Myimagview];
        
        self.Mytitle = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(100, 150, 80, 60) ];
        self.Mytitle.center = CGPointMake(frame.size.width/2, 150);
   self.Mytitle.text = @"版本 : 1.0";
        _Mytitle.numberOfLines = 0;
        //    _Mytitle.contentMode = UIViewContentModeCenter ;
        //    _Mytitle.lineBreakMode = NSLineBreakByWordWrapping;
        _Mytitle.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(19)];
        [self addSubview:_Mytitle];
        self.Myintroduce = [[UILabel alloc]initWithFrame:CGRectMakeAdaptationScreen(20, 180, 335, 350) ];
//        self.Myintroduce.center = CGPointMake(frame.size.width/2, 80);
        self.Myintroduce.text = @"1.本APP用于学习交流,非营利性产品;\n\n2.本APP数据来源于--徒步去旅行;\n\n3.联系方式:747726013@qq.com 790412767@qq.com;\n\n4.谢谢您的使用,期待您的宝贵意见!";
        _Myintroduce.numberOfLines = 0;
        //    _Mytitle.contentMode = UIViewContentModeCenter ;
            _Myintroduce.lineBreakMode = NSLineBreakByWordWrapping;
        _Myintroduce.font = [UIFont systemFontOfSize:heightScaleMakeAdaptationScreen(20)];
        [self addSubview:_Myintroduce];
    }
    return self;
}

@end
