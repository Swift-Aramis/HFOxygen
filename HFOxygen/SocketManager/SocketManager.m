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

static NSString * const incomeIP = @"60.191.60.78";
static const NSInteger incomePort = 3888;
static const NSInteger timeOut = 30;

typedef enum : NSUInteger {
    LoginCommand,
    TodayCommand,
    YesterdayCommand,
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

- (void)connectIncomeSocket {
    if (_connected == YES) {
        return;
    }
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    self.connected = [self.clientSocket connectToHost:incomeIP onPort:incomePort viaInterface:nil withTimeout:timeOut error:&error];
    if (error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发生错误!"];
    }
}

- (void)disConnectIncomeSocket {
    [self.clientSocket disconnect];
}

- (void)loginConnect {
    NSString *command = @"登录丨002丨123";
    NSData *data = [command dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:timeOut tag:LoginCommand];
    [MBProgressHUD showMessage:@""];
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

/**
 读取数据
 
 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 本次读取的标记
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [MBProgressHUD hideHUD];

    switch (tag) {
        case LoginCommand:
            
            break;
        
        default:
            break;
    }
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到数据:%@",text);
//    self.outputTV.text = text;
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

#pragma mark - Action
//- (IBAction)sendAction:(id)sender {
//    if (self.inputTF.text.length == 0) {
//        NSLog(@"请输入数据后再发送");
//        return;
//    }
//    NSData *data = [self.inputTF.text dataUsingEncoding:NSUTF8StringEncoding];
//    // withTimeout -1 : 无穷大,一直等
//    // tag : 消息标记
//    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
//}

#pragma mark - Private
//- (void)addTimer {
//    // 长连接定时器
//    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
//    // 把定时器添加到当前运行循环,并且调为通用模式
//    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
//}

//// 心跳连接
//- (void)longConnectToSocket
//{
//    // 发送固定格式的数据,指令@"longConnect"
//    float version = [[UIDevice currentDevice] systemVersion].floatValue;
//    NSString *longConnect = [NSString stringWithFormat:@"iOS设备系统%f",version];
//    NSLog(@"心跳数据:%@",longConnect);
//    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
//    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
//}

@end
