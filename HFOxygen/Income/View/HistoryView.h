//
//  HistoryView.h
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryIncomeView.h"
#import "HistoryInputView.h"

@interface HistoryView : UIView

@property (nonatomic, strong) HistoryIncomeView *historyIncomeView;
@property (nonatomic, strong) HistoryInputView *historyInputView;

- (CGFloat)historyHeight;

@end
