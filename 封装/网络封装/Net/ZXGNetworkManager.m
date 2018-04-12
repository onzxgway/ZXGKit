//
//  ZXGNetworkManager.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNetworkManager.h"
#import "ZXGBaseDataModel.h"

static NSString * const CustomErrorDomain = @"com.networkTask.test";
static NSInteger const XDefultFailed = -1000;
static NSString * const XKPParamKey = @"XKPParamKey";//新开普的key

@implementation ZXGNetworkManager {
    AFHTTPSessionManager *_manager;
}

+ (ZXGNetworkManager *)sharedJSONManager {
    static ZXGNetworkManager *_netWorkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (_netWorkManager == nil) {
            _netWorkManager = [[ZXGNetworkManager alloc] init:YES];
        }
    });
    return _netWorkManager;
}

+ (ZXGNetworkManager *)sharedXMLManager {
    static ZXGNetworkManager *_netWorkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (_netWorkManager == nil) {
            _netWorkManager = [[ZXGNetworkManager alloc] init:NO];
        }
    });
    return _netWorkManager;
}

- (instancetype)init:(BOOL)isJson {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        if (isJson) {
            
            _manager.requestSerializer = [AFJSONRequestSerializer serializer];
            _manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [_manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
            [_manager.requestSerializer setValue:@"en-us,en;q=0.5" forHTTPHeaderField:@"Accept-Language"];
            [_manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        }
        else {
            [_manager.requestSerializer setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
            _manager.requestSerializer.timeoutInterval = 30;
            _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
    }
    return self;
}

- (void)addTask:(ZXGNetworkTask *)task {
    if (task.taskType == ZXGNetworkTaskTypeJsonRequest) {
        [self addDataTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeXmlRequest) {
        [self addXKPTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeUploadFile) {
        [self addUploadFileTask:task];
    }
    else if (task.taskType == ZXGNetworkTaskTypeDownloadFile) {
        [self addDownloadFileTask:task];
    }
}

- (void)addDownloadFileTask:(ZXGNetworkTask *)networkTask{

}

- (void)addUploadFileTask:(ZXGNetworkTask *)networkTask {
    
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", networkTask.host, networkTask.interface];
    NSLog(@"请求的接口%@",URLString);
    
    _manager.requestSerializer.timeoutInterval = networkTask.timeoutInterval;
    [networkTask.reqHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [_manager POST:URLString parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [networkTask.fileModels enumerateObjectsUsingBlock:^(ZXGUploadFileModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (JZStringIsNull(obj.fileFullPath)) {
                if (obj.fileData) {
                    [formData appendPartWithFileData:obj.fileData name:@"files" fileName:obj.fileName mimeType:obj.fileType];
                }
            }
            else {
                NSError * error;
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:obj.fileFullPath] name:@"files" fileName:obj.fileName mimeType:obj.fileType error:&error];
                if (error) {
                    NSLog(@"%@",error);
                }
            }
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [self progressTask:networkTask progress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        networkTask.task = task;
        
        [self successWithTask:networkTask response:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        networkTask.task = task;
        [self failureWithTask:networkTask error:error];
    }];
}

- (void)addXKPTask:(ZXGNetworkTask *)networkTask {
    
    YYReachability *reachability   = [YYReachability reachabilityWithHostname:@"www.baidu.com"];
    YYReachabilityStatus internetStatus = reachability.status;
    if (internetStatus == YYReachabilityStatusNone) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络出了点小差~ 请检查您的网络!"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *customError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        [self failureWithTask:networkTask error:customError];
        return;
    }
    
    NSString * URLString = [NSString stringWithFormat:@"%@%@",networkTask.host,networkTask.interface];
    id params = networkTask.reqParams;
    
    NSString *paramString = [params objectForKey:XKPParamKey];
    NSLog(@"请求的接口%@",URLString);
    NSLog(@"请求的参数%@",paramString);
    
    [_manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        return paramString;
    }];
    
    [_manager POST:URLString parameters:paramString progress:^(NSProgress * _Nonnull uploadProgress) {
        [self progressTask:networkTask progress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        networkTask.task = task;
        [self successXMLWithTask:networkTask response:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        networkTask.task = task;
        [self failureXMLWithTask:networkTask error:error];
    }];
}

- (void)addDataTask:(ZXGNetworkTask *)networkTask {
    YYReachability *reachability = [YYReachability reachabilityWithHostname:@"www.baidu.com"];
    YYReachabilityStatus internetStatus = reachability.status;
    if (internetStatus == YYReachabilityStatusNone) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络出了点小差~ 请检查您的网络!"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *customError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        [self failureWithTask:networkTask error:customError];
        return;
    }
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", networkTask.host, networkTask.interface];
    id params = networkTask.reqParams;
    
    NSLog(@"请求的接口:%@", URLString);
    NSLog(@"请求的参数:%@", params);
    
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = networkTask.timeoutInterval;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [networkTask.reqHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    ZXGHttpRequestMethod method = networkTask.requestMethod;
    if (method == ZXGHttpRequestMethod_POST) {
        if (networkTask.taskType == ZXGNetworkRequestTypeXKP) {
            [_manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return params;
            }];
        }
        
        [_manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            [self progressTask:networkTask progress:uploadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.task = task;
            [self successWithTask:networkTask response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
    }
    else if (method == ZXGHttpRequestMethod_GET) {
        [_manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            [self progressTask:networkTask progress:downloadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.task = task;
            [self successWithTask:networkTask response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
    }
    else if (method == ZXGHttpRequestMethod_DELETE) {
        [_manager DELETE:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.task = task;
            [self successWithTask:networkTask response:responseObject];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
    }
    else if (method == ZXGHttpRequestMethod_PUT) {
        [_manager PUT:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            networkTask.task = task;
            [self successWithTask:networkTask response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            networkTask.task = task;
            [self failureWithTask:networkTask error:error];
        }];
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

/**
  执行任务成功回调
 */
- (void)successWithTask:(ZXGNetworkTask *)task response:(id)responseObject {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        if ([task.interface isEqualToString:@"family/user/updateUserRegistrationId"]) {
            NSLog(@"12121212121");
        }
        
        if (![task.host containsString:@"192.168"]) {
            ZXGBaseDataModel *dataModel = [ZXGBaseDataModel mj_objectWithKeyValues:responseObject];
            if (dataModel) {
//                if (dataModel.status == 4001 || dataModel.status == 4002 || dataModel.status == 4005) {
//
//                    NSMutableArray *modules =  [[JZContext shareInstance].appConfig moduleServicesWithProtocol:@protocol(JZNetWorkTaskProtocol)];
//                    id <JZNetWorkTaskProtocol> module = [modules firstObject];
//                    if (module && [module respondsToSelector:@selector(automaticRefreshTokenOnNetWorkManager:task:successBlock:failureBlock:)]) {
//                        [module automaticRefreshTokenOnNetWorkManager:self task:task successBlock:^(JZNetworkTask *task, id dictData, NSInteger statusCode) {
//
//                        } failureBlock:^(JZNetworkTask *task, NSError *error) {
//
//                        }];
//                        return;
//                    }
//
//                }
//                else if(dataModel.status == 5050){
//
//                    NSMutableArray * modules =  [[JZContext shareInstance].appConfig moduleServicesWithProtocol:@protocol(JZNetWorkTaskProtocol)];
//                    id <JZNetWorkTaskProtocol> module = [modules firstObject];
//                    if (module && [module respondsToSelector:@selector(netWorkManagerMaintain:task:response:)]) {
//                        [module netWorkManagerMaintain:self task:task response:responseObject];
//                        return;
//                    }
//                }
            }
        }
    }
    if (task.successBlock) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.task.response;
        task.successBlock(task, responseObject, response.statusCode);
    }
}


/**
  执行任务失败回调
 */
- (void)failureWithTask:(ZXGNetworkTask *)task error:(NSError *)error {
    
    NSString *customStr = [self failureWithError:error];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:customStr                                                                      forKey:NSLocalizedDescriptionKey];
    
    NSError *customError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
    if (task.failureBlock) {
        task.failureBlock(task, customError);
    }
    
}

- (NSString *)failureWithError:(NSError *)error {
    NSLog(@"%@",error.userInfo);
    if ([error.userInfo.allKeys containsObject:NSUnderlyingErrorKey]) {
        NSError *underlyError= [error.userInfo objectForKey:NSUnderlyingErrorKey];
        if(underlyError && [underlyError isKindOfClass:[NSError class]] && [underlyError.userInfo.allKeys containsObject:AFNetworkingOperationFailingURLResponseDataErrorKey]){
            NSData *responseErrorData = underlyError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (responseErrorData && [responseErrorData isKindOfClass:[NSData class]]) {
                NSString * responseError = [[NSString alloc]initWithData:responseErrorData encoding:NSUTF8StringEncoding];
                if (!(responseError || [@"" isEqualToString:responseError])) {
                    NSDictionary *responseErrorDic = [NSString jsonStringToNSDictionary:responseError];
                    if (responseErrorDic && [responseErrorDic isKindOfClass:[NSDictionary class]] && [responseErrorDic.allKeys containsObject:@"error"]) {
                        NSDictionary *errorDic = [responseErrorDic objectForKey:@"error"];
                        if (errorDic && [errorDic isKindOfClass:[NSDictionary class]] && [errorDic.allKeys containsObject:@"key"]) {
                            NSString * errorKey = [errorDic objectForKey:@"key"];
                            if (!(errorKey || [@"" isEqualToString:errorKey])) {
                                return errorKey;
                            }
                        }
                    }
                }
            }
        }
    }
    if (!JZStringIsNull(error.localizedDescription)) {
        return error.localizedDescription;
    }
    return @"网络繁忙,请稍后再试!";
}

- (void)successXMLWithTask:(ZXGNetworkTask *)task response:(id)responseObject {
    
    if (task.successBlock) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.task.response;
        task.successBlock(task, responseObject, response.statusCode);
    }
}

- (void)failureXMLWithTask:(ZXGNetworkTask *)task error:(NSError *)error {

    if (task.failureBlock) {
        task.failureBlock(task, error);
    }
}

@end
