//
//  tablecellTool.m
//  Travel3
//
//  Created by lanou on 15/7/27.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "tablecellTool.h"

@implementation tablecellTool

// 实现计算label高度的方法
+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content
{
    // 1、写一个cgsize  高度给一个尽量大的值
    CGSize size = CGSizeMake(labelWidth, 1000000);
    // 2、定义一个字典
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:wordSize] forKey:NSFontAttributeName];
    // 3、计算高度
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    // 返回高度
    return rect.size.height;
}


@end
