//
//  AppDelegate.m
//  HFOxygen
//
//  Created by 提运佳 on 2018/6/9.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "IncomeController.h"
#import "SocketManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[SocketManager sharedInstance] connectIncomeSocket];
    self.window.rootViewController = [[LoginController alloc] init];
    
//    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[[IncomeController alloc] init]];
//    self.window.rootViewController = rootNav;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[SocketManager sharedInstance] disConnectIncomeSocket];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[SocketManager sharedInstance] connectIncomeSocket];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[SocketManager sharedInstance] disConnectIncomeSocket];
}


@end
