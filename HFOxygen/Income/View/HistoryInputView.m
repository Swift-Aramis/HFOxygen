//
//  HistoryInputView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "HistoryInputView.h"

@interface HistoryInputView ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation HistoryInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HistoryInputView" owner:nil options:nil].firstObject;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
        _tipLabel.layer.cornerRadius = _sureBtn.layer.cornerRadius = 5;
        _tipLabel.clipsToBounds = _sureBtn.clipsToBounds = YES;
        _startBtn.layer.cornerRadius = _endBtn.layer.cornerRadius = 5;
        _startBtn.layer.borderColor = _endBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _startBtn.layer.borderWidth = _endBtn.layer.borderWidth = 1;
    }
    return self;
}

- (IBAction)sureAction:(UIButton *)sender {
}

@end
