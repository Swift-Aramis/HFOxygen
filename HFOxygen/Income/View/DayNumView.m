//
//  DayNumView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "DayNumView.h"

@implementation DayNumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"DayNumView" owner:nil options:nil].firstObject;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    }
    return self;
}

@end
