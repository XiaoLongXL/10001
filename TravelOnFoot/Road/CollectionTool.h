//
//  CollectionTool.h
//  Travel3
//
//  Created by lanou on 15/8/3.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "CollectionModel.h"

@interface CollectionTool : NSObject
{
    FMDatabase *db;
}

// 声明一系列对数据操作的方法

-(void)createRouteTable;

-(void)insertToRouteCollectTable:(CollectionModel *)coll;

-(BOOL)existsWithRouteName:(NSString *)title;

-(NSMutableArray *)getRouteCollection;

-(void)deleteWithRouteTitle:(NSString *)title;


@end
