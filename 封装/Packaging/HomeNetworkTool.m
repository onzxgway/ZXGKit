//
//  HomeNetworkTool.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/16.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "HomeNetworkTool.h"

@implementation HomeNetworkTool

+ (NSString *)reqEHeadlineMsgWithParams:(NSDictionary *)params
                       withSuccessBlock:(ZXGRequestSuccessBlock)successBlock
                       withFailureBlock:(ZXGRequestFailureBlock)failureBlock {
    
    ZXGNetworkTask *task = [[ZXGNetworkTask alloc] init];
    task.successBlock = successBlock;
    task.failureBlock = failureBlock;
    
    [[ZXGNetworkCenter sharedNetworkCenter] addTask:task];
    
    return task.taskIdentifier;
}

@end
