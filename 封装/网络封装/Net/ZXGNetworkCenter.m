//
//  ZXGNetworkCenter.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNetworkCenter.h"

@implementation ZXGNetworkCenter

+ (ZXGNetworkCenter *)sharedNetworkCenter {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)requestWithCondition:(ZXGNetWorkCenterCondition *)condition
                  withSuccessBlock:(ZXGRequestSuccessBlock)success
                     withFailBlock:(ZXGRequestFailureBlock)faild {
    
    if (condition.requestType == ZXGNetworkRequestTypeOrange) {
        return [self OrangeRequestWithCondition:condition withSuccessBlock:success withFaildBlock:faild];
    }
    else if (condition.requestType == ZXGNetworkRequestTypeXKP){
        return [self XKPRequestWithCondition:condition withSuccessBlock:success withFaildBlock:faild];
    }
    else if (condition.requestType == ZXGNetworkRequestTypeYouKu){
        return [self youKuRequestWithCondition:condition withSuccessBlock:success withFaildBlock:faild];
    }
    return nil;
}

#pragma mark - lifeCycle
#pragma mark - createViews
#pragma mark - private
- (NSString *)OrangeRequestWithCondition:(ZXGNetWorkCenterCondition *)condition
                        withSuccessBlock:(ZXGRequestSuccessBlock)success
                          withFaildBlock:(ZXGRequestFailureBlock)faild {
    
    ZXGNetworkTask *task = [[ZXGNetworkTask alloc]init];
    if ([self stringIsNull:condition.host]) {
//        task.host = [JZAppConfig shareInstance].apiConfigItem.host;
    }
    else {
        task.host = condition.host;
    }
    task.timeoutInterval = condition.timeoutInterval;
    task.reqParams = condition.reqParams;
    task.requestMethod = condition.requestMethod;
    task.interface = condition.interface;
    task.fileModels = condition.fileModels;
//    task.requestHeaders = [JZNetWorkCenter requestHeaders:condition.requestHeaders
//                                                  isLogin:condition.isLogin];
    task.successBlock = success;
    task.failureBlock = faild;
    task.taskType = condition.taskType;
    
    if (task.taskType == ZXGNetworkTaskTypeJsonRequest || task.taskType == ZXGNetworkTaskTypeUploadFile || task.taskType == ZXGNetworkTaskTypeDownloadFile) {
        [[ZXGNetworkManager sharedJSONManager] addTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeXmlRequest){
        [[ZXGNetworkManager sharedXMLManager]  addTask:task];
    }
    else{
        NSAssert(NO, @"一个非法请求");
    }
    
    return task.taskIdentifier;
}

- (NSString *)XKPRequestWithCondition:(ZXGNetWorkCenterCondition *)condition
                     withSuccessBlock:(ZXGRequestSuccessBlock)success
                       withFaildBlock:(ZXGRequestFailureBlock)faild {
    return nil;
}

- (NSString *)youKuRequestWithCondition:(ZXGNetWorkCenterCondition *)condition
                       withSuccessBlock:(ZXGRequestSuccessBlock)success
                         withFaildBlock:(ZXGRequestFailureBlock)faild {
    ZXGNetworkTask *task = [[ZXGNetworkTask alloc] init];
    task.timeoutInterval = condition.timeoutInterval;
    task.reqParams = condition.reqParams;
    task.requestMethod = condition.requestMethod;
    task.interface = condition.interface;
    task.successBlock = success;
    task.failureBlock = faild;
    if (task.taskType == ZXGNetworkTaskTypeJsonRequest) {
        [[ZXGNetworkManager sharedJSONManager] addTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeXmlRequest) {
        [[ZXGNetworkManager sharedXMLManager]  addTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeUploadFile) {
        [[ZXGNetworkManager sharedJSONManager] addTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeDownloadFile) {
        [[ZXGNetworkManager sharedJSONManager] addTask:task];
    }
    else {
        NSAssert(NO, @"一个非法请求");
    }
    return task.taskIdentifier;
}

#pragma mark - public
#pragma mark - lazyLoad

- (BOOL)stringIsNull:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
        return YES;
    }

    return NO;
}

@end
