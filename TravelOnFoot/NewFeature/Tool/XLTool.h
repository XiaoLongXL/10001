//
//  MyTool.h
//  GZSMyDouBan
//
//  Created by xiaolong on 15/7/1.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define CustomColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


CG_INLINE CGRect CGRectMakeAdaptationScreen(CGFloat x,CGFloat y,CGFloat w,CGFloat h)
{
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    CGRect rect ;
    rect.origin.x = x * app.autoSizeWidth;
    rect.origin.y = y * app.autoSizeHeight;
    rect.size.width = w * app.autoSizeWidth;
    rect.size.height = h * app.autoSizeHeight;
    return rect;
    
}


CG_INLINE CGFloat widthScaleMakeAdaptationScreen(CGFloat f)
{
    AppDelegate * app = [UIApplication sharedApplication].delegate;

    CGFloat width = f * app.autoSizeWidth ;
    return  width;
    
}


CG_INLINE CGFloat heightScaleMakeAdaptationScreen(CGFloat f)
{
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    CGFloat height = f * app.autoSizeHeight;
    return  height;
    
}
//@protocol XLToolDelegate <NSObject>
//
////-(void)getData:(NSData*)data;
//
//@end

@interface XLTool : NSObject
//+(XLTool*)shareXLTool;
//@property(nonatomic,weak)id<XLToolDelegate>delegate;
/**自动计算文本高度*/
+(CGRect)getTextSizeWithText:(NSString*)text textWidth:(CGFloat)width textFont:(CGFloat)size;
/**自定义UIBarButtonItem*/
+(UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon highlighted:(NSString*)highlidhted target:( id)target action:(SEL)action;

//-(void)downLoadDataWithString:(NSString*)str;


//显示alertView
+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle;
//移除alertView
+ (void)removeAlertView:(UIAlertView *)alertView;

/**封装的AFNetworking*/
+(void)XLNetworkingRequestDateModelArrayFromURL:(NSString *)URLString successResponseObject:(void(^)(id responseObject))successResponseObjectBlcok failed:(void(^)(BOOL error))failedNetWorkingBlock;

 
@end
