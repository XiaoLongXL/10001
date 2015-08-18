//
//  UIViewController+HUD.m
//  Reachabilitys
//
//  Created by yanlei wu on 15/7/30.
//  Copyright (c) 2015年 yanlei wu. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"


@interface UIViewController ()

@property(nonatomic,retain)MBProgressHUD *HUD;

@end



@implementation UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint
{
    MBProgressHUD *HUD= [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 1000;
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
  //  [HUD hide:YES afterDelay:2];
}


-(void)showhide
{
    NSArray *array = self.view.subviews;
    for (UIView *view in array) {
        if (view.tag == 1000) {
            [view removeFromSuperview];
        }
    }
    
}




- (void)showHint:(NSString *)hint  {
    //显示提示信息
//    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
//    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


@end
