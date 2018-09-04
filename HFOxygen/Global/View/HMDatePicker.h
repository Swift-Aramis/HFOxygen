//
//  HMDatePicker.h
//  HealthManager
//
//  Created by 提运佳 on 2017/7/19.
//  Copyright © 2017年 提运佳. All rights reserved.
//

#import "HMAlertView.h"
typedef void(^HMDateBlock)(NSString *dateString);
@interface HMDatePicker : HMAlertView

@property (nonatomic, strong)NSString *title;
@property (nonatomic,copy) HMDateBlock completion;

- (instancetype)initWithTitle:(NSString *)title
                   completion:(HMDateBlock)completion;

@end
