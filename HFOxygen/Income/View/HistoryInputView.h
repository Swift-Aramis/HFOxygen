//
//  HistoryInputView.h
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FormTimeBlock)(NSString *startTime, NSString *endTime);

@interface HistoryInputView : UIView

@property (nonatomic, copy) FormTimeBlock block;

@end
