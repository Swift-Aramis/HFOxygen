//
//  HistoryInputView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "HistoryInputView.h"
#import "HMDatePicker.h"
#import "MBProgressHUD+YJ.h"

@interface HistoryInputView ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
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

- (IBAction)startTimeBtnClicked:(UIButton *)sender {
    HMDatePicker * datePicker = [[HMDatePicker alloc]initWithTitle:@"请选择开始时间" completion:^(NSString *dateString) {
        [self.startBtn setTitle:dateString forState:UIControlStateNormal];
        [self.startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.startTime = dateString;
    }];
    [datePicker show];
}

- (IBAction)endTimeBtnClicked:(UIButton *)sender {
    HMDatePicker * datePicker = [[HMDatePicker alloc]initWithTitle:@"请选择结束时间" completion:^(NSString *dateString) {
        [self.endBtn setTitle:dateString forState:UIControlStateNormal];
        [self.endBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.endTime = dateString;
    }];
    [datePicker show];
}

- (IBAction)sureAction:(UIButton *)sender {
    if (_startTime.length == 0 ||
        _endTime.length == 0) {
        [MBProgressHUD showText:@"请先选择起止时间!"];
        return;
    }
    if (self.block) {
        self.block(_startTime, _endTime);
    }
}

@end
