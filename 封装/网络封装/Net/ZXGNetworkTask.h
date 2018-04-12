//
//  ZXGNetworkTask.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGNetworkConstsDefine.h"
#import "ZXGUploadFileModel.h"

@interface ZXGNetworkTask : NSObject

@property (nonatomic, copy  , readonly) NSString *taskIdentifier;

/** 网络请求类型 默认是 橘子网络的请求*/
@property (nonatomic, assign) ZXGNetworkRequestType requestType;

/** 网络请求方式 默认是 POST请求*/
@property (nonatomic, assign) ZXGHttpRequestMethod requestMethod;

/** 如果该host有值,就不使用BaseUrl*/
@property (nonatomic, copy  ) NSString *host;

/** 接口 和上面的 interfaceType 二选一*/
@property (nonatomic, copy  ) NSString *interface;

/** 网络请求任务类型*/
@property (nonatomic, assign) ZXGNetworkTaskType taskType;

/** 请求参数*/
@property (nonatomic, strong) NSDictionary *reqParams;

/** 携带数据 Uid,AccessToken*/
@property (nonatomic, strong) NSMutableDictionary *reqHeaders;

/** 超时时长 默认是30s*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/** 成功回调*/
@property (nonatomic, copy  ) ZXGRequestSuccessBlock successBlock;

/** 失败回调*/
@property (nonatomic, copy  ) ZXGRequestFailureBlock failureBlock;

/** 进度回调*/
@property (nonatomic, copy  ) ZXGRequestProgressBlock progressBlock;

/** NSURLSessionDataTask*/
@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, strong) NSMutableArray<ZXGUploadFileModel *> *fileModels;

@end
