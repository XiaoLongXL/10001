//
//  RequestBaseClass.m
//  Reachabilitys
//
//  Created by yanlei wu on 15/7/30.
//  Copyright (c) 2015年 yanlei wu. All rights reserved.
//

#import "RequestBaseClass.h"
#import "AFNetworkReachabilityManager.h"

 @implementation RequestBaseClass


-(void)getFromURL:(NSString *)URLString ViewController:(UIViewController *)viewController requestDate:(void  (^)(NSData *data))dataBlocks error:(void (^)(BOOL isNetError))isNetErrors;
{
         AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
        [maneger1 startMonitoring];
        //网络判断
        [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusNotReachable) {
                UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败,请检测网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                isNetErrors(YES);
                [al show];
                [viewController showhide];
            }else{
                NSURL *url = [[NSURL alloc] initWithString:URLString];
                NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:url];
                [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if (data == nil) {
                        [viewController showHint:@"数据异常:201" ];
                    }else
                    {
                        dataBlocks(data);
                    }
                }];

            }
        }];}
        
-(void)getFromURL:(NSString *)URLString ViewController:(UIViewController *)viewController requestDate:(void  (^)(NSData *data))dataBlocks
{
    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
    [maneger1 startMonitoring];
    //网络判断
    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败,请检测网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [al show];
            [viewController showhide];
        }else{
            NSURL *url = [[NSURL alloc] initWithString:URLString];
            NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:url];
            [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data == nil) {
                    [viewController showHint:@"数据异常:201" ];
                }else
                {
                    dataBlocks(data);
                }
            }];
            
        }
    }];}

@end
