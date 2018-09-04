//
//  HFAppearenceUI.h
//  Clinic_Doctor
//
//  Created by 提运佳 on 2017/3/27.
//  Copyright © 2017年 提运佳. All rights reserved.
//

/**
 *  AppearenceFrame
 */

#define kUIScreenSize [UIScreen mainScreen].bounds.size
#define kUIScreenWidth kUIScreenSize.width
#define kUIScreenHeight kUIScreenSize.height
#define kNavigationBarHeight 64
#define kTabbarHeight 49
#define kAdaptiveHeight  (kUIScreenHeight / 667.)
#define kAdaptiveWidth  (kUIScreenWidth / 375.)
#define FRAME(X, Y, W, H) CGRectMake(X, Y, W, H)

//判断屏幕
#define kIsIphone6P                     ([[UIScreen mainScreen] bounds].size.height == 736)
#define kIsIphone6                      ([[UIScreen mainScreen] bounds].size.height == 667)
#define kIsIphone5                      ([[UIScreen mainScreen] bounds].size.height == 568)
#define kIsIphone4                      ([[UIScreen mainScreen] bounds].size.height == 480)
