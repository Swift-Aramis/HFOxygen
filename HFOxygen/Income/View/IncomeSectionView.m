//
//  IncomeSectionView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "IncomeSectionView.h"

@interface IncomeSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;

@end

@implementation IncomeSectionView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"IncomeSectionView" owner:nil options:nil].firstObject;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
        self.titleLabel.text = title;
        self.refreshBtn.hidden = YES;
        if ([title isEqualToString:@"今日收入汇总"]) {
            self.refreshBtn.hidden = NO;
        }
    }
    return self;
}

- (IBAction)refreshAction:(UIButton *)sender {
    
}

@end
