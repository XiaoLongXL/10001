//
//  NSDate+XL.m
//  508WB
//
//  Created by xiaolong on 15/5/31.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "NSDate+XL.h"

@implementation NSDate (XL)

/**是否为今天*/
-(BOOL)isToday
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    //获取当前的年月日
   NSDateComponents * nowComps = [calendar components:unit fromDate:[NSDate date]];
    //获取微博的年月日
    NSDateComponents * selfComps = [calendar components:unit fromDate:self];
    return (selfComps.year == nowComps.year)&&
    (selfComps.month == nowComps.month)&&
    (selfComps.day == nowComps.day);
    
}
/**是否为昨天*/
-(BOOL)isYestoday
{
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    //获取当前的年月日
    NSDateComponents * nowComps = [calendar components:unit fromDate:[NSDate date]];
    //获取微博的年月日
    NSDateComponents * selfComps = [calendar components:unit fromDate:self];
    return (selfComps.year == nowComps.year)&&
    (selfComps.month == nowComps.month)&&
    (selfComps.day < nowComps.day);
 }
/**是否为今年*/
-(BOOL)isThisYear
{
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    //获取当前的年月日
    NSDateComponents * nowComps = [calendar components:unit fromDate:[NSDate date]];
    //获取微博的年月日
    NSDateComponents * selfComps = [calendar components:unit fromDate:self];
    return selfComps.year == nowComps.year ;
}

/**获得与当前时间的差距*/
-(NSDateComponents * )deltaWithNow
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
//self 和当前时间的 HH mm ss 差距
   return  [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    
}
@end
