//
//  RequestBaseClass.h
//  Reachabilitys
//
//  Created by yanlei wu on 15/7/30.
//  Copyright (c) 2015年 yanlei wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+HUD.h"

@interface RequestBaseClass : NSObject

-(void)getFromURL:(NSString *)URLString ViewController:(UIViewController *)viewController requestDate:(void  (^)(NSData *data))dataBlocks error:(void (^)(BOOL isNetError))isNetErrors;

-(void)getFromURL:(NSString *)URLString ViewController:(UIViewController *)viewController requestDate:(void  (^)(NSData *data))dataBlocks;

@end
