//
//  IncomeController.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "IncomeController.h"
#import "IncomeSectionView.h"
#import "DayNumView.h"
#import "DayIncomeView.h"
#import "HistoryView.h"
#import "LineChartView.h"

@interface IncomeController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DayIncomeView *todayIncomeView;
@property (nonatomic, strong) DayIncomeView *yesterdayIncomeView;
@property (nonatomic, strong) DayNumView *dayNumView;
@property (nonatomic, strong) HistoryView *historyView;
@property (nonatomic, strong) LineChartView *lineChartView;
@end

@implementation IncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"华方医院收入报表";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"IncomeCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.todayIncomeView];
    } else if (indexPath.section == 1) {
        [cell.contentView addSubview:self.yesterdayIncomeView];
    } else if (indexPath.section == 2) {
        [cell.contentView addSubview:self.dayNumView];
    } else if (indexPath.section == 3) {
        [cell.contentView addSubview:self.historyView];
    } else {
        [cell.contentView addSubview:self.lineChartView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return [self.historyView historyHeight];
    } else if (indexPath.section == 4) {
        return 300;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        IncomeSectionView *secV = [[IncomeSectionView alloc] initWithTitle:@"今日收入汇总"];
        return secV;
        
    } else if (section == 1) {
        IncomeSectionView *secV = [[IncomeSectionView alloc] initWithTitle:@"昨日收入汇总"];
        return secV;
        
    } else if (section == 2) {
        IncomeSectionView *secV = [[IncomeSectionView alloc] initWithTitle:@"在院/出院人数汇总"];
        return secV;
        
    } else if (section == 3) {
        IncomeSectionView *secV = [[IncomeSectionView alloc] initWithTitle:@"历史收入汇总"];
        return secV;
        
    } else {
        IncomeSectionView *secV = [[IncomeSectionView alloc] initWithTitle:@"近七日收入趋势"];
        return secV;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - Getter
- (LineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
    }
    return _lineChartView;
}

- (HistoryView *)historyView {
    if (!_historyView) {
        _historyView = [[HistoryView alloc] init];
    }
    return _historyView;
}

- (DayIncomeView *)todayIncomeView {
    if (!_todayIncomeView) {
        _todayIncomeView = [[DayIncomeView alloc] init];
    }
    return _todayIncomeView;
}

- (DayIncomeView *)yesterdayIncomeView {
    if (!_yesterdayIncomeView) {
        _yesterdayIncomeView = [[DayIncomeView alloc] init];
    }
    return _yesterdayIncomeView;
}

- (DayNumView *)dayNumView {
    if (!_dayNumView) {
        _dayNumView = [[DayNumView alloc] init];
    }
    return _dayNumView;
}

@end
