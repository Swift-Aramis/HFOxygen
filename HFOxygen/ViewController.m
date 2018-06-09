//
//  ViewController.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/6/9.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

static NSString * const hostIP = @"a.socket.nat123.net";//@"192.168.3.18";
static const NSInteger hostPort = 13300;
/**
 The host parameter will be an IP address, not a DNS name. -- 引自GCDAsyncSocket
 连接的主机为IP地址,并非DNS名称.
 */
@interface ViewController ()<GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UITextView *outputTV;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
// 客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;
@property (nonatomic, assign) BOOL connected;
@property (nonatomic, strong) NSTimer *connectTimer;
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTCP];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.sendBtn.clipsToBounds = YES;
    self.sendBtn.layer.cornerRadius = 5;
}

#pragma mark - ConfigTCP
- (void)configTCP {
    //创建socket并指定代理对象为self,代理队列必须为主队列.
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //连接指定主机的对应端口.
    NSError *error = nil;
    self.connected = [self.clientSocket connectToHost:hostIP onPort:hostPort viaInterface:nil withTimeout:-1 error:&error];
}

#pragma mark - GCDAsyncSocketDelegate
/**
 成功连接主机对应端口号.
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"\n连接主机对应端口成功\n%@",[NSString stringWithFormat:@"服务器IP: %@ \n端口: %d", host,port]);

    // 连接成功开启定时器
    [self addTimer];
    // 连接后,可读取服务端的数据
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
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
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到数据:%@",text);
    self.outputTV.text = text;
    // 读取到服务端数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
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
    [self.connectTimer invalidate];
}

#pragma mark - Action
- (IBAction)sendAction:(id)sender {
    if (self.inputTF.text.length == 0) {
        NSLog(@"请输入数据后再发送");
        return;
    }
    NSData *data = [self.inputTF.text dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}

#pragma mark - Private
- (void)addTimer {
    // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}

// 心跳连接
- (void)longConnectToSocket
{
    // 发送固定格式的数据,指令@"longConnect"
    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    NSString *longConnect = [NSString stringWithFormat:@"iOS设备系统%f",version];
    NSLog(@"心跳数据:%@",longConnect);
    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}

@end
