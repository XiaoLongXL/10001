//
//  CollectionTravel.h
//  TravelOnFoot
//
//  Created by lanou on 15/8/5.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface CollectionTravel : NSObject

{
    FMDatabase *db;
    
}

// 声明一系列对数据操作的方法

-(void)createTravelTable;

-(void)insertToTravelCollectTable:(NSString *)ip title:(NSString *)title;

-(BOOL)existsWithTravelName:(NSString *)title;

-(NSMutableArray *)getTravelCollection;

-(void)deleteWithTravelTitle:(NSString *)title;
-(NSString *)searchData:(NSString *)title;



-(void)createActivityTable;

-(void)insertToActivityCollectTable:(NSString *)ip destination:(NSString *)destination title:(NSString *)title;

-(BOOL)existsWithActivityTitle:(NSString *)title;

-(NSMutableArray *)getActivityCollection;

-(void)deleteWithActivityTitle:(NSString *)title;
-(NSString *)searchActivityDestinationData:(NSString *)title;
-(NSString *)searchActivityData:(NSString *)title;


@end
