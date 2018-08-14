//
//  LoginController.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "LoginController.h"
#import "SocketManager.h"

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.clipsToBounds = YES;
}

- (IBAction)loginAction:(UIButton *)sender {
    [[SocketManager sharedInstance] loginConnect];
}

@end
