//
//  CollectionTool.m
//  Travel3
//
//  Created by lanou on 15/8/3.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "CollectionTool.h"

@implementation CollectionTool


-(instancetype)init
{
    self = [super init];
    if (self) {
        // 打印沙盒路径
//        NSLog(@"%@", NSHomeDirectory());
        
        
        // 在document中创建数据库
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [array lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"collectionRoute.sqlite"];
        db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

// 实现创建表的方法
-(void)createRouteTable
{
    if ([db open]) {
        NSString *sqlCreateTable = @"create table if not exists route (id integer primary key autoincrement, str text, str2 text, str3 text, str4 text, title text)";
        // 执行
//        BOOL result =
        [db executeUpdate:sqlCreateTable];
//        if (result) {
//            DLog(@"建表成功");
//        }else {
//            DLog(@"建表失败");
//        }
    }
    [db close];
}

// 添加电影到收藏夹
-(void)insertToRouteCollectTable:(CollectionModel *)coll
{
    if ([db open]) {
        NSString *sqlInsert = [NSString stringWithFormat:@"insert into route (str, str2, str3, str4, title) values ('%@', '%@', '%@', '%@', '%@')",coll.str, coll.str2, coll.str3, coll.str4, coll.title];
        BOOL result = [db executeUpdate:sqlInsert];
        if (result) {
            DLog(@"成功");

        }else {
        }
        [db close];
    }
}


// 判断是否存在的方法
-(BOOL)existsWithRouteName:(NSString *)title
{
    if ([db open]) {
        NSString *sqlSelect = @"select * from route";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *titleName = [set stringForColumn:@"title"];
            if ([titleName isEqualToString:title]) {
//                DLog(@"已经存在，返回YES");
                [db close];
                return YES;
            }
        }
    }
    [db close];
    return NO;
}


// 获取当前用户的活动收藏数据
-(NSMutableArray *)getRouteCollection
{
    NSMutableArray *array = [NSMutableArray array];
    if ([db open]) {
        NSString *sqlSelect = @"select *from route";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
                CollectionModel *co = [[CollectionModel alloc] init];
            co.title = [set stringForColumn:@"title"];
                co.str = [set stringForColumn:@"str"];
                co.str2 = [set stringForColumn:@"str2"];
                co.str3 = [set stringForColumn:@"str3"];
                co.str4 = [set stringForColumn:@"str4"];
                [array addObject:co];
        }
    }
    [db close];
    return array;
    
}

// 声明删除的方法
-(void)deleteWithRouteTitle:(NSString *)title
{
    if ([db open]) {
        NSString *sqlDeleat = [NSString stringWithFormat:@"delete from route where title = '%@'",title];
 //        BOOL result =
        [db executeUpdate:sqlDeleat];
//        if (result) {
//            DLog(@"删除数据成功");
//        }else {
//            DLog(@"删除失败");
//        }
        [db close];
    }
}


@end
