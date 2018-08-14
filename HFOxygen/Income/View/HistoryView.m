//
//  HistoryView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "HistoryView.h"

@interface HistoryView ()

@property (nonatomic, strong) UIView *sepView;

@end

@implementation HistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect Frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    self = [super initWithFrame:Frame];
    if (self) {
        [self addSubview:self.historyInputView];
        [self addSubview:self.historyIncomeView];
        
        UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        sepView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self addSubview:sepView];
        
        CGRect sepRect = sepView.frame;
        sepRect.origin.y = CGRectGetMaxY(self.historyInputView.frame);
        sepView.frame = sepRect;
        
        CGRect incomeRect = self.historyIncomeView.frame;
        incomeRect.origin.y = CGRectGetMaxY(sepView.frame);
        self.historyIncomeView.frame = incomeRect;
    }
    return self;
}

- (CGFloat)historyHeight {
    CGFloat totalHeight = 0;
    totalHeight += CGRectGetHeight(self.historyInputView.frame);
    totalHeight += CGRectGetHeight(self.historyIncomeView.frame);
    totalHeight += 10;
    return totalHeight;
}

#pragma mark - Getter
- (HistoryInputView *)historyInputView {
    if (!_historyInputView) {
        _historyInputView = [[HistoryInputView alloc] init];
    }
    return _historyInputView;
}

- (HistoryIncomeView *)historyIncomeView {
    if (!_historyIncomeView) {
        _historyIncomeView = [[HistoryIncomeView alloc] init];
    }
    return _historyIncomeView;
}


@end


