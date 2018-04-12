//
//  ZXGNetWorkCenterCondition.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNetWorkCenterCondition.h"

@implementation ZXGNetWorkCenterCondition

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestType = ZXGNetworkRequestTypeOrange;
        _requestMethod = ZXGHttpRequestMethod_POST;
        
        _timeoutInterval = 30.0f;
    }
    return self;
}

@end
