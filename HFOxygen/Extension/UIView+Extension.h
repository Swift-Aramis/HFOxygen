//
//  UIView+Extension.h
//  居家医护
//
//  Created by 提运佳 on 16/5/31.
//  Copyright © 2016年 提运佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

- (void)removeAllSubviews;
- (NSArray *)allSubviews:(UIView *)aView;

@end
