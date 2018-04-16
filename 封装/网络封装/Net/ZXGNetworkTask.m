//
//  ZXGNetworkTask.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNetworkTask.h"

@implementation ZXGNetworkTask 

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _requestType = ZXGNetworkRequestTypeOrange;
        _requestMethod = ZXGHttpRequestMethod_POST;
        _reqDataType = ZXGNetworkRequestDataTypeJson;
        _timeoutInterval = 30.0f;
        
        _host = @"";
        _reqHeaders = [@{} mutableCopy];
//        _taskIdentifier = [JZSystemUtils currentTimeStampString];
    }
    return self;
}

@end
