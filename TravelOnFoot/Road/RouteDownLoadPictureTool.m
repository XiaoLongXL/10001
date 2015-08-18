//
//  RouteDownLoadPictureTool.m
//  Travel3
//
//  Created by lanou on 15/7/20.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteDownLoadPictureTool.h"
#import "JSONKit.h"
#import "SubjectRoute.h"
#import "regionsModel.h"
#import "RouteSubjectList.h"
#import "provinceRouteModel.h"
#import "SceniceRouteModel.h"

@implementation RouteDownLoadPictureTool

-(void)downLoadData:(NSString *)strUrl
{

    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    // 异步block请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self.myDelegate sendDataFromTool:data];
    }];
}


-(void)downLoaddataRoute5:(NSString *)RouteStrUrl
{
    NSURL *url = [NSURL URLWithString:RouteStrUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    // 异步block请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            return ;
        }
        // json解析
        NSMutableDictionary *dic = [data objectFromJSONData];
        NSMutableArray *arr = [dic objectForKey:@"logs"];
        self.SubjectRouteArray1 = [NSMutableArray array];
        for (int i = 0; i < [arr count]; i++) {
            SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
            srm.specialCover = [[arr objectAtIndex:i] valueForKey:@"cover"];
            srm.specialAvatar = [[[arr objectAtIndex:i] valueForKey:@"created_by"] valueForKey:@"avatar"];
            srm.specialNickname = [[[arr objectAtIndex:i] valueForKey:@"created_by"] valueForKey:@"nickname"];
            srm.specialStart_date = [[arr objectAtIndex:i] valueForKey:@"start_date"];
            srm.specialTotal_days = [[[arr objectAtIndex:i] valueForKey:@"total_days"] stringValue];
            srm.specialPhoto_number = [[arr objectAtIndex:i] valueForKey:@"photo_number"];
            srm.specialEnd_date = [[arr objectAtIndex:i] valueForKey:@"end_date"];
            [self.SubjectRouteArray1 addObject:srm];
        }
        [self.myDelegate2 sendDataFromTool2:self.SubjectRouteArray1];
    }];
}


-(void)downLoaddataRoute6:(NSString *)RouteStrUrl
{
    NSURL *url = [NSURL URLWithString:RouteStrUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    // 异步block请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            return ;
        }
        // json解析
        NSMutableDictionary *dic = [data objectFromJSONData];
        NSMutableArray *arr = [dic objectForKey:@"trails"];
        self.SubjectRouteArray2 = [NSMutableArray array];
        for (int i = 0; i < [arr count]; i++) {
            SceniceRouteModel *srm = [[SceniceRouteModel alloc] init];
            srm.correlationName = [[arr objectAtIndex:i] valueForKey:@"name"];
            srm.correlationCover = [[arr objectAtIndex:i] valueForKey:@"cover"];
            [self.SubjectRouteArray2 addObject:srm];
        }
        [self.myDelegate3 sendDataFromTool3:self.SubjectRouteArray2];
    }];
}


@end
