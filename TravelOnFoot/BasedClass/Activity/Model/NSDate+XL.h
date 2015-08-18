//
//  NSDate+XL.h
//  508WB
//
//  Created by xiaolong on 15/5/31.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XL)
/**是否为今天*/
-(BOOL)isToday;
/**是否为昨天*/
-(BOOL)isYestoday;
/**是否为今年*/
-(BOOL)isThisYear;
/**获得与当前时间的差距*/
-(NSDateComponents * )deltaWithNow;


@end
