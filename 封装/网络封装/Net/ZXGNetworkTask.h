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

/** 服务器地址 如果有值就不使用BaseUrl*/
@property (nonatomic, copy  ) NSString *host;

/** 接口路径 */ //和上面的 interfaceType 二选一
@property (nonatomic, copy  ) NSString *interface;

/** 请求参数*/
@property (nonatomic, strong) NSDictionary *reqParams;

/** 超时时长 默认是30s*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/** 网络请求数据类型 默认是Json*/
@property (nonatomic, assign) ZXGNetworkRequestDataType reqDataType;



/** 携带数据 Uid,AccessToken*/
@property (nonatomic, strong) NSMutableDictionary *reqHeaders;
@property (nonatomic, strong) NSMutableArray<ZXGUploadFileModel *> *fileModels;


/** 成功回调*/
@property (nonatomic, copy  ) ZXGRequestSuccessBlock successBlock;

/** 失败回调*/
@property (nonatomic, copy  ) ZXGRequestFailureBlock failureBlock;

/** 进度回调*/
@property (nonatomic, copy  ) ZXGRequestProgressBlock progressBlock;

/** NSURLSessionDataTask*/
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;


@end
