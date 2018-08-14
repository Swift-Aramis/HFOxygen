//
//  LineChartView.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "LineChartView.h"
#import "PNChart.h"

@interface LineChartView ()

@property (nonatomic, strong) PNLineChart * lineChart;

@end

@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect Frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    self = [super initWithFrame:Frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    //For Line Chart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200.0)];
    lineChart.showGenYLabels = YES;
    lineChart.showYGridLines = YES;
    lineChart.showCoordinateAxis = YES;
    self.lineChart = lineChart;
    
    [self showLineChart];
}

- (void)showLineChart {
    [_lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];

    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"门诊收入";
    data01.color = PNFreshGreen;
    data01.itemCount = _lineChart.xLabels.count;
    
    data01.showPointLabel = YES;
    data01.pointLabelColor = [UIColor blackColor];
    data01.pointLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:15.0];
    data01.inflexionPointColor = PNRed;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"住院收入";
    data02.color = PNTwitterColor;
    data02.itemCount = _lineChart.xLabels.count;
    
    data02.showPointLabel = YES;
    data02.pointLabelColor = PNTwitterColor;
    data02.pointLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:15.0];
    data02.color = PNTwitterColor;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    _lineChart.chartData = @[data01, data02];
    [_lineChart strokeChart];
    
    [self addSubview:_lineChart];
    
    _lineChart.legendStyle = PNLegendItemStyleSerial;
    _lineChart.legendFont = [UIFont boldSystemFontOfSize:15.0f];
    _lineChart.legendFontColor = [UIColor redColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, CGRectGetMaxY(_lineChart.frame) + 10, legend.frame.size.width, 50)];
    [self addSubview:legend];
}

@end
