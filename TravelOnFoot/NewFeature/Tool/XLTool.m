//
//  MyTool.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//
//#import "AppDelegate.h"
#import "AFNetworking.h"
#import "XLTool.h"
// static XLTool * xlTool = nil;

@interface XLTool ()
 

@end
@implementation XLTool

//+(XLTool*)shareXLTool
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        xlTool = [[self alloc]init];
//    });
//     return xlTool;
//}



//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    return [XLTool shareXLTool];
//}
//

+(void)XLNetworkingRequestDateModelArrayFromURL:(NSString *)URLString successResponseObject:(void(^)(id responseObject))successResponseObjectBlcok failed:(void(^)(BOOL error))failedNetWorkingBlock
{

            AFHTTPRequestOperationManager * maneger = [AFHTTPRequestOperationManager manager];
            [maneger GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSData * data = operation.responseData ;
//                manager.responseSerializer  = [AFJSONResponseSerializer serializer];
                

                successResponseObjectBlcok(responseObject);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failedNetWorkingBlock(YES);
            }];
     
 }
+(CGRect)getTextSizeWithText:(NSString*)text textWidth:(CGFloat)width textFont:(CGFloat)size
{
    return  [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];

}

+(UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon highlighted:(NSString*)highlidhted target:( id)target action:(SEL)action
{
    
    UIButton * button = [[UIButton alloc]init];
    UIImage * imageH = [[UIImage imageNamed:highlidhted] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:imageH forState:UIControlStateHighlighted];
    
    UIImage * image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0,button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    

    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
 }

//显示alertView
+(UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
     
    return alertView;
}

//移除alertView
+(void)removeAlertView:(UIAlertView *)alertView
{
    //alertView消失
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
}

//-(void)downLoadDataWithString:(NSString*)str
//{
//    NSURL *url = [NSURL URLWithString:str];
//    
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
//    
////    __weak XLTool * tool = self;
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
////        NSError * error = nil;
////      NSDictionary * dic = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//        if (data==nil) {
//            return ;
//        }
//        
////        if ( [tool.delegate respondsToSelector:@selector(getData:)]) {
////            [tool.delegate getData:data];
////        }
//        
//    }];
//}


//-(void)getFromURL:(NSString *)URLString ViewController:(UIViewController *)viewController requestDate:(void  (^)(NSData *data))dataBlocks
//{
//    AFNetworkReachabilityManager * maneger1 = [AFNetworkReachabilityManager sharedManager];
//    [maneger1 startMonitoring];
//    //网络判断
//    [maneger1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败,请检测网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [al show];
//            [viewController showhide];
//        }else{
//            NSURL *url = [[NSURL alloc] initWithString:URLString];
//            NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:url];
//            [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                if (data == nil) {
//                    [viewController showHint:@"数据异常:201" ];
//                }else
//                {
//                    dataBlocks(data);
//                }
//            }];
//            
//        }
//    }];}
//

@end
