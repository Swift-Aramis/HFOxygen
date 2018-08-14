//
//  SocketManager.h
//  HFOxygen
//
//  Created by 提运佳 on 2018/8/13.
//  Copyright © 2018年 提运佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketManager : NSObject

+ (instancetype)sharedInstance;

- (void)connectIncomeSocket;
- (void)disConnectIncomeSocket;
- (void)loginConnect;

@end
