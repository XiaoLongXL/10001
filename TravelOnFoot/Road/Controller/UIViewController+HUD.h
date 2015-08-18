//
//  UIViewController+HUD.h
//  Reachabilitys
//
//  Created by yanlei wu on 15/7/30.
//  Copyright (c) 2015年 yanlei wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
- (void)showHint:(NSString *)hint;
-(void)showhide;
@end
