//
//  SocketManager.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "SocketManager.h"
#import "GCDAsyncSocket.h"
#import "MBProgressHUD+YJ.h"
#import "IncomeController.h"

static NSString * const incomeIP = @"60.191.60.78";
static const NSInteger incomePort = 3888;
//static const NSInteger timeOut = 30;

typedef enum : NSUInteger {
    LoginCommand,
    TodayCommand,
    YesterdayCommand,
    AllCommand,
    SevenDayCommand
} IncomeCommand;

@interface SocketManager ()<GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *clientSocket;
@property (nonatomic, assign) BOOL connected;

@end

@implementation SocketManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - ScoketCommand
- (void)connectIncomeSocket {
    if (_connected == YES) {
        return;
    }
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    self.connected = [self.clientSocket connectToHost:incomeIP onPort:incomePort viaInterface:nil withTimeout:-1 error:&error];
    if (error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"连接发生错误!"];
    }
}

- (void)disConnectIncomeSocket {
    [self.clientSocket disconnect];
}

//登录
- (void)loginConnect {
    NSString *command = [@"登录" stringByAppendingString:self.userString];
    NSLog(@"%@",command);
    NSData *data = [self gbkEncoding:command];
    NSLog(@"%@",data);
    [self.clientSocket writeData:data withTimeout:-1 tag:LoginCommand];
    [MBProgressHUD showMessage:@"登录中..."];
}

- (NSString *)userString {
    // 用户名|密码
    return @"丨qeb丨123";
}

- (NSData *)gbkEncoding:(NSString *)aString {
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData*aData = [aString dataUsingEncoding: gbkEncoding];
    return aData;
}

- (NSArray *)receiveArrayWithData:(NSData *)data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc]initWithData:data encoding:enc];
    NSLog(@"收到数据:%@",text);
    return [text componentsSeparatedByString:@"丨"];
}

- (void)changeRootVC {
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[[IncomeController alloc] init]];
    UIApplication.sharedApplication.keyWindow.rootViewController = rootNav;
}

/**
 全院收入，昨日收入，今日收入，近七日数据
 */
- (void)sendCommandWithName:(NSString *)name tag:(IncomeCommand)tag {
    NSString *command = [name stringByAppendingString:self.userString];
    NSLog(@"%@",command);
    NSData *data = [self gbkEncoding:command];
    NSLog(@"%@",data);
    [self.clientSocket writeData:data withTimeout:-1 tag:tag];
}

- (void)todayIncome {
    [self sendCommandWithName:@"今日收入" tag:TodayCommand];
}

- (void)yesterdayIncome {
    [self sendCommandWithName:@"昨日收入" tag:YesterdayCommand];
}

- (void)allIncome {
    [self sendCommandWithName:@"全院收入" tag:AllCommand];
}

- (void)sevenIncome {
    [self sendCommandWithName:@"近七日数据" tag:SevenDayCommand];
}

#pragma mark - GCDAsyncSocketDelegate
/**
 成功连接主机对应端口号.
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [MBProgressHUD hideHUD];
    NSLog(@"\n连接主机对应端口成功\n%@",[NSString stringWithFormat:@"服务器IP: %@ \n端口: %d", host,port]);

    [self.clientSocket readDataWithTimeout:-1 tag:0];
    self.connected = YES;
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"发送数据");
}

/**
 读取数据
 
 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 本次读取的标记
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [MBProgressHUD hideHUD];
    NSArray *array = [self receiveArrayWithData:data];
    NSLog(@"收到数据数组:%@",array);
    if (!array.count) {
        [MBProgressHUD showError:@"接收数据失败"];
        return;
    }
    
    switch (tag) {
        case LoginCommand:
            if ([array[0] isEqualToString:@"登录成功"]) {
                [MBProgressHUD showSuccess:@"登录成功"];
                [self changeRootVC];
                [self todayIncome];
            }
            break;
        case TodayCommand:
            NSLog(@"TodayCommand === 收到数据数组:%@",array);
            break;
        case YesterdayCommand:
            if ([array[0] isEqualToString:@"登录成功"]) {
                [MBProgressHUD showSuccess:@"登录成功"];
                [self changeRootVC];
            }
            break;
        case AllCommand:
            if ([array[0] isEqualToString:@"登录成功"]) {
                [MBProgressHUD showSuccess:@"登录成功"];
                [self changeRootVC];
            }
            break;
        case SevenDayCommand:
            if ([array[0] isEqualToString:@"登录成功"]) {
                [MBProgressHUD showSuccess:@"登录成功"];
                [self changeRootVC];
            }
            break;
        default:
            break;
    }
   
    // 读取到服务端数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

/**
 客户端socket断开
 
 @param sock 客户端socket
 @param err 错误描述
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"断开连接");
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    self.connected = NO;
}

@end
