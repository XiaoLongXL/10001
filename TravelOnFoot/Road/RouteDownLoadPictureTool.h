//
//  RouteDownLoadPictureTool.h
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol sendDataDelegate <NSObject>

-(void)sendDataFromTool:(NSData *)data;

@end


@protocol sendDataDelegate2 <NSObject>

-(void)sendDataFromTool2:(NSMutableArray *)array2;

@end


@protocol sendDataDelegate3 <NSObject>

-(void)sendDataFromTool3:(NSMutableArray *)array3;

@end


@interface RouteDownLoadPictureTool : NSObject

// 声明一个下载的方法，传过来网址
-(void)downLoadData:(NSString *)strUrl;
-(void)downLoaddataRoute5:(NSString *)RouteStrUrl;
-(void)downLoaddataRoute6:(NSString *)RouteStrUrl;


// 设置代理
@property(nonatomic,weak)id<sendDataDelegate>myDelegate;
@property(nonatomic,weak)id<sendDataDelegate2>myDelegate2;
@property(nonatomic,weak)id<sendDataDelegate3>myDelegate3;


@property(nonatomic,strong)NSMutableArray *SubjectRouteArray1;
@property(nonatomic,strong)NSMutableArray *SubjectRouteArray2;




@end
