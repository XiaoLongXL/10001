//
//  XLNetworking.m
//  TravelOnFoot
//
//  Created by xiaolong on 15/8/11.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "XLNetworking.h"
#import "AFNetworking.h"
//#import "MJExtension.h"
//#import "JSONKit.h"
@implementation XLNetworking
 +(void)XLNetworkingRequestDateModelArrayFromURL:(NSString *)URLString successResponseObject:(void(^)(id responseObject))successResponseObjectBlcok failed:(void(^)(BOOL error))failedNetWorkingBlock
{
    AFNetworkReachabilityManager * reachbility = [AFNetworkReachabilityManager sharedManager];
    [reachbility setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       if(status==AFNetworkReachabilityStatusNotReachable){
            [XLNetworking  showAlertViewWithTitle:@"提示" message:@"网络故障,请检查网络设置!" cancelButtonTitle:@"确定" otherButtonTitle:nil];
           failedNetWorkingBlock(YES);
        }else {
        
            AFHTTPRequestOperationManager * maneger = [AFHTTPRequestOperationManager manager];
            [maneger GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                successResponseObjectBlcok(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failedNetWorkingBlock(YES);
            }];
       }
       
       }];
}
//+(void)XLRequestDateFromURL:(NSString *)URLString ResponseObject:(void(^)(id responseObject))responseObjectBlcok failed:(void(^)(BOOL error))breakNetWorkingBlock
//{
//        AFNetworkReachabilityManager * reachbility = [AFNetworkReachabilityManager sharedManager];
//        [reachbility startMonitoring];
//       [reachbility setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//           if(status==AFNetworkReachabilityStatusNotReachable){
//               [XLNetworking  showAlertViewWithTitle:@"提示" message:@"网络故障,请检查网络设置!" cancelButtonTitle:@"确定" otherButtonTitle:nil];
//        breakNetWorkingBlock(YES);
//
//           }else{
//               [XLNetworking requestDateWithURL:URLString ResponseObject:^(id responseObject) {
//                dispatch_queue_t  queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//               } NoData:^(BOOL haveData) {
//                }
//                }];
//           }
//       }];
//     
//}
//
//+(void)requestDateWithURL:(NSString*)URLString ResponseObject:(void(^)(id responseObject))responseObjectBlcok NoData:(void(^)(BOOL haveData))haveDataBlock
//{
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
//    
//    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData * data = operation.responseData ;
////    manager.responseSerializer  = [AFJSONResponseSerializer serializer];

//        if (responseObject==nil) {
////        [XLNetworking showAlertViewWithTitle:@"提示" message:@"网络数据异常!" cancelButtonTitle:@"确定" otherButtonTitle:nil];
//            haveDataBlock(YES);
//            return ;
//        }else{
//            responseObjectBlcok(responseObject);
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        haveDataBlock(YES);
//    }];
//
//}
//显示alertView
+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
    
    return alertView;
}

@end
