//
//  HMAlertView.h
//  HMAlert
//
//  Created by 提运佳 on 2017/7/19.
//  Copyright © 2017年 提运佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAlertView : UIButton

@property (nonatomic,strong) UIView * contentView;
- (void)show;
- (void)remove;

@end
