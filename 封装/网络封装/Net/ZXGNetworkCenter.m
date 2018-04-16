//
//  ZXGNetworkCenter.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNetworkCenter.h"

@implementation ZXGNetworkCenter {
    AFHTTPSessionManager *_manager;
}

#pragma mark - singleton
+ (ZXGNetworkCenter *)sharedNetworkCenter {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - overwrite
- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - lifeCycle
- (void)addTask:(ZXGNetworkTask *)networkTask {
    
    // 0.检查网络状况
    YYReachability *reachability = [YYReachability reachabilityWithHostname:@"www.baidu.com"];
    YYReachabilityStatus internetStatus = reachability.status;
    if (internetStatus == YYReachabilityStatusNone) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络出了点小差~ 请检查您的网络!"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *customError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        [self failureWithTask:networkTask error:customError];
        return;
    }
    
    // 1.开始请求
    
    //请求头 参数
    if (networkTask.requestType == ZXGNetworkRequestDataTypeJson) {
        [self makeJsonReqHead:_manager];
        id params = networkTask.reqParams;
        NSLog(@"请求的参数:%@",params);
    }
    else if (networkTask.requestType == ZXGNetworkRequestDataTypeXml){
        [self makeXmlReqHead:_manager];
    }
    
    // 接口 超时时长
    NSString *URLStr = [NSString stringWithFormat:@"%@%@", networkTask.host, networkTask.interface];
    NSLog(@"请求的接口:%@",URLStr);
    _manager.requestSerializer.timeoutInterval = networkTask.timeoutInterval;
    
    
    ZXGHttpRequestMethod method = networkTask.requestMethod;
    if (method == ZXGHttpRequestMethod_POST) {

        [_manager POST:URLStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            [self progressTask:networkTask progress:uploadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.sessionDataTask = task;
            [self successWithTask:networkTask response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
    }
    else if (method == ZXGHttpRequestMethod_GET) {
        [_manager GET:URLStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            [self progressTask:networkTask progress:downloadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.sessionDataTask = task;
            [self successWithTask:networkTask response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
    }
}

#pragma mark - private
- (void)makeXmlReqHead:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
}

- (void)makeJsonReqHead:(AFHTTPSessionManager *)manager {
        [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"en-us,en;q=0.5" forHTTPHeaderField:@"Accept-Language"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

/**
 执行任务成功回调
 @param task 任务实体类
 @param responseObject 成功返回
 */
- (void)successWithTask:(ZXGNetworkTask *)task response:(id)responseObject {
    
    if (task.successBlock) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.sessionDataTask.response;
        task.successBlock(task, responseObject, response.statusCode);
    }
}

/**
 执行任务失败回调
 @param task 任务实体类
 @param error 错误
 */
- (void)failureWithTask:(ZXGNetworkTask *)task error:(NSError *)error{
    
    NSString * customString = [self failureWithError:error];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:customString                                                                      forKey:NSLocalizedDescriptionKey];
    
    NSError *customError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
    if (task.failureBlock) {
        task.failureBlock(task, customError);
    }
    
}

/**
 进度
 */
- (void)progressTask:(ZXGNetworkTask *)task progress:(NSProgress *)uploadProgress {
    if (task.progressBlock) {
        task.progressBlock(task, uploadProgress);
    }
}

@end
