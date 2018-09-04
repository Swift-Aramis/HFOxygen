//
//  HMDatePicker.m
//  HealthManager
//
//  Created by 提运佳 on 2017/7/19.
//  Copyright © 2017年 提运佳. All rights reserved.
//

#import "HMDatePicker.h"
#import "NSCalendar+ST.h"
#import "HFAppearenceUI.h"
#import "UIView+Extension.h"

#define kPickerCell 50
#define kPickerBtn 40
#define kGlobalColor [UIColor colorWithRed:72/255.0 green:195/255.0 blue:255/255.0 alpha:1]
#define kLineColor kGlobalColor
static NSInteger const yearMin = 1900;
static NSInteger const yearSum = 200;
@interface HMDatePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) UIView * contentV;
@property (nonatomic,strong) UILabel * headLabel;
@property (nonatomic,strong) UIView * buttonLine;
@property (nonatomic,strong) UIButton * leftButton;
@property (nonatomic,strong) UIButton * rightButton;
@property (nonatomic, strong)UIPickerView * pickerView;
@property (nonatomic,strong) UIView * lineOne;
@property (nonatomic,strong) UIView * lineTwo;
@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;
@property (nonatomic,copy) NSString * dateString;

@end

@implementation HMDatePicker

- (instancetype)initWithTitle:(NSString *)title
                   completion:(HMDateBlock)completion{
    self.title = title;
    self.completion = completion;
    self = [self init];
    [self createContentView];
    [self loadData];
    return self;
}

-(void)createContentView{
    [self addSubview:self.contentV];
    self.contentView = self.contentV;
}

- (void)loadData
{
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    self.dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day];
    
    [self.pickerView selectRow:(_year - yearMin) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return yearSum;
    }else if(component == 1) {
        return 12;
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + yearMin;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kPickerCell;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
    
    UILabel *pickerLabel = [[UILabel alloc]init];
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    if (row == [pickerView selectedRowInComponent:component]) {
        pickerLabel.textColor = kGlobalColor;
    }
    return pickerLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return [NSString stringWithFormat:@"%ld年", row + 1900];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%ld月", row + 1];
    }else if (component == 2){
        return [NSString stringWithFormat:@"%ld日", row + 1];
    }
    
    return nil;
}


- (void)reloadData
{
    self.year  = [self.pickerView selectedRowInComponent:0] + yearMin;
    self.month = [self.pickerView selectedRowInComponent:1] + 1;
    self.day   = [self.pickerView selectedRowInComponent:2] + 1;
    self.dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day];
}

#pragma mark - getter
-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]init];
        _contentV.backgroundColor = [UIColor whiteColor];
        CGFloat alertW = kUIScreenWidth - 60*kAdaptiveWidth*2;
        CGFloat alertH = kPickerBtn + kPickerCell*4;
        _contentV.frame = FRAME(60*kAdaptiveWidth, kUIScreenHeight/4, alertW, alertH);
        [_contentV addSubview:self.headLabel];
        [_contentV addSubview:self.pickerView];
        [_contentV addSubview:self.leftButton];
        [_contentV addSubview:self.rightButton];
        [_contentV addSubview:self.buttonLine];
        [_contentV addSubview:self.lineOne];
        [_contentV addSubview:self.lineTwo];
        _contentV.clipsToBounds = YES;
        _contentV.layer.cornerRadius = 10;
    }
    return _contentV;
}

-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:FRAME(20*kAdaptiveWidth, 0, _contentV.width - 40*kAdaptiveWidth, kPickerCell)];
        _headLabel.font = [UIFont systemFontOfSize:17];
        _headLabel.text = _title;
    }
    return _headLabel;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:FRAME(30*kAdaptiveWidth, _headLabel.bottom, _contentV.width - 60*kAdaptiveWidth, kPickerCell*3)];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

-(UIView *)lineOne{
    if (!_lineOne) {
        _lineOne = [[UIView alloc]initWithFrame:FRAME(_pickerView.x, _headLabel.bottom + kPickerCell, _pickerView.width, 0.5)];
        _lineOne.backgroundColor = kLineColor;
    }
    return _lineOne;
}

-(UIView *)lineTwo{
    if (!_lineTwo) {
        _lineTwo = [[UIView alloc]initWithFrame:FRAME(_lineOne.x, _lineOne.bottom + kPickerCell, _pickerView.width, 0.5)];
        _lineTwo.backgroundColor = kLineColor;
    }
    return _lineTwo;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.frame = FRAME(0, _pickerView.bottom, _contentV.width/2, kPickerBtn);
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_leftButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
        _rightButton.frame = FRAME(_leftButton.right, _pickerView.bottom, _contentV.width/2, kPickerBtn);
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [_rightButton setTitleColor:kGlobalColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_rightButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(void)sure{
    if (self.completion) {
        self.completion(_dateString);
    }
    [self remove];
}

-(UIView *)buttonLine{
    if (!_buttonLine) {
        _buttonLine = [[UIView alloc]initWithFrame:FRAME(0, _pickerView.bottom, _contentV.width, 0.5)];
        _buttonLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _buttonLine;
}

@end
