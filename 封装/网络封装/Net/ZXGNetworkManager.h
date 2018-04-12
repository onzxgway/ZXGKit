//
//  ZXGNetworkManager.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGNetworkTask.h"

@interface ZXGNetworkManager : NSObject

+ (ZXGNetworkManager *)sharedJSONManager;
+ (ZXGNetworkManager *)sharedXMLManager;

- (void)addTask:(ZXGNetworkTask *)task;

@end
