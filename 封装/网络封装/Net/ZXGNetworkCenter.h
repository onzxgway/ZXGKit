//
//  ZXGNetworkCenter.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGNetWorkCenterCondition.h"
#import "ZXGNetworkManager.h"

@interface ZXGNetworkCenter : NSObject

+ (ZXGNetworkCenter *)sharedNetworkCenter;


- (NSString *)requestWithCondition:(ZXGNetWorkCenterCondition *)condition
                  withSuccessBlock:(ZXGRequestSuccessBlock)success
                     withFailBlock:(ZXGRequestFailureBlock)faild;


@end
