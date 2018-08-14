//
//  MBProgressHUD+YJ.h
//  居家医护
//
//  Created by 提运佳 on 16/5/31.
//  Copyright © 2016年 提运佳. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YJ)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showText:(NSString *)text;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
