//
//  CollectionTravel.m
//  TravelOnFoot
//
//  Created by lanou on 15/8/5.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "CollectionTravel.h"

@implementation CollectionTravel
-(instancetype)init
{
    self = [super init];
    if (self) {
        // 打印沙盒路径
//        NSLog(@"ttttt%@", NSHomeDirectory());
        
        
        // 在document中创建数据库
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [array lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"collectionTravel.sqlite"];
        db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

// 实现创建表的方法
-(void)createTravelTable
{
    if ([db open]) {
        NSString *sqlCreateTable = @"create table if not exists travel (id integer primary key autoincrement, str text,title text)";
        // 执行
        
//        BOOL result =
        [db executeUpdate:sqlCreateTable];
//        if (result) {
//            NSLog(@"建表成功");
//        }else {
//            NSLog(@"建表失败");
//        }
    }
    [db close];
}

// 添加电影到收藏夹
-(void)insertToTravelCollectTable:(NSString *)ip title:(NSString *)title
{
    if ([db open]) {
        NSString *sqlInsert = [NSString stringWithFormat:@"insert into travel (str,title) values ('%@', '%@')",ip,title];
//        BOOL result =
        [db executeUpdate:sqlInsert];
//        if (result) {
//            
//        }else {
//        }
        [db close];
    }
}


// 判断是否存在的方法
-(BOOL)existsWithTravelName:(NSString *)title
{
    if ([db open]) {
        NSString *sqlSelect = @"select * from travel";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *titleName = [set stringForColumn:@"title"];
            if ([titleName isEqualToString:title]) {
//                NSLog(@"已经存在，返回YES");
                [db close];
                return YES;
            }
        }
    }
    [db close];
    return NO;
}


// 获取当前用户的活动收藏数据
-(NSMutableArray *)getTravelCollection
{
    NSMutableArray *array = [NSMutableArray array];
    if ([db open]) {
        NSString *sqlSelect = @"select *from travel";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            [array addObject:title];
        }
    }
    [db close];
    return array;
    
}





// 声明删除的方法
-(void)deleteWithTravelTitle:(NSString *)title
{
    if ([db open]) {
        NSString *sqlDeleat = [NSString stringWithFormat:@"delete from travel where title = '%@'",title];
//        NSLog(@"%@", title);
//        BOOL result =
        [db executeUpdate:sqlDeleat];
//        if (result) {
//            NSLog(@"删除数据成功");
//        }else {
//            NSLog(@"删除失败");
//        }
        [db close];
    }
}


//数据库搜索操作
-(NSString *)searchData:(NSString *)title
{
    NSString *s = [NSString stringWithFormat:@"select * from travel where title = '%@'",title];
    if ([db open]) {
        NSString *sqlSelect = s;//如果多个条件,在后面加 and where ......
        //执行查询
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *ID = [set stringForColumn:@"str"];
            return ID;
        }
        [db close];
    }
    return nil;
}

// 实现创建表的方法
-(void)createActivityTable
{
    if ([db open]) {
        NSString *sqlCreateTable = @"create table if not exists Activity (id integer primary key autoincrement, str text,destination text,title text)";
//        BOOL result =
        [db executeUpdate:sqlCreateTable];
//        if (result) {
//            NSLog(@"建表成功");
//        }else {
//            NSLog(@"建表失败");
//        }
    }
    [db close];
}


-(void)insertToActivityCollectTable:(NSString *)ip destination:(NSString *)destination title:(NSString *)title
{
    if ([db open]) {
        NSString *sqlInsert = [NSString stringWithFormat:@"insert into Activity (str,destination,title) values ('%@', '%@','%@')",ip,destination,title];
//        BOOL result =
        [db executeUpdate:sqlInsert];
//        if (result) {
//            
//        }else {
//        }
        [db close];
    }
}



-(BOOL)existsWithActivityTitle:(NSString *)title
{
    if ([db open]) {
        NSString *sqlSelect = @"select * from Activity";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *titleName = [set stringForColumn:@"title"];
            if ([titleName isEqualToString:title]) {
//                NSLog(@"已经存在，返回YES");
                [db close];
                return YES;
            }
        }
    }
    [db close];
    return NO;
}



-(NSMutableArray *)getActivityCollection
{
    NSMutableArray *array = [NSMutableArray array];
    if ([db open]) {
        NSString *sqlSelect = @"select *from Activity";
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            //            NSString *str = [set stringForColumn:@"str"];
            //            [array addObject:str];
            [array addObject:title];
        }
    }
    [db close];
    return array;
    
}





// 声明删除的方法
-(void)deleteWithActivityTitle:(NSString *)title
{
    if ([db open]) {
        NSString *sqlDeleat = [NSString stringWithFormat:@"delete from Activity where title = '%@'",title];
//        NSLog(@"%@", title);
//        BOOL result =
        [db executeUpdate:sqlDeleat];
//        if (result) {
//            NSLog(@"删除数据成功");
//        }else {
//            NSLog(@"删除失败");
//        }
        [db close];
    }
}


//数据库搜索操作
-(NSString *)searchActivityData:(NSString *)title
{
    NSString *s = [NSString stringWithFormat:@"select * from Activity where title = '%@'",title];
    if ([db open]) {
        NSString *sqlSelect = s;//如果多个条件,在后面加 and where ......
        //执行查询
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *ID = [set stringForColumn:@"str"];
            return ID;
        }
        [db close];
    }
    return nil;
}

//数据库搜索操作
-(NSString *)searchActivityDestinationData:(NSString *)title
{
    NSString *s = [NSString stringWithFormat:@"select * from Activity where title = '%@'",title];
    if ([db open]) {
        NSString *sqlSelect = s;//如果多个条件,在后面加 and where ......
        //执行查询
        FMResultSet *set = [db executeQuery:sqlSelect];
        while ([set next]) {
            NSString *destination = [set stringForColumn:@"destination"];
            return destination;
        }
        [db close];
    }
    return nil;
}

@end
