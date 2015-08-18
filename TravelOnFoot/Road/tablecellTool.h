//
//  tablecellTool.h
//  Travel3
//
//  Created by lanou on 15/7/27.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <uikit/UIKit.h>

@interface tablecellTool : NSObject
// 声明一个计算label高度的方法

// 三个参数 字号 label长度  要显示的内容

+(CGFloat)getLabelHeight:(CGFloat)wordSize labelWidth:(CGFloat)labelWidth content:(NSString *)content;

@end
