//
//  ZXGNetworkConstsDefine.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#ifndef ZXGNetworkConstsDefine_h
#define ZXGNetworkConstsDefine_h

#import "AFNetworking.h"
#import "JZStringMacrocDefine.h"
#import <YYKit.h>
#import "MJExtension.h"
@class ZXGNetworkTask;

typedef void (^ZXGRequestSuccessBlock)(ZXGNetworkTask *, id dictData, NSInteger statusCode);
typedef void (^ZXGRequestFailureBlock)(ZXGNetworkTask *, NSError *);
typedef void (^ZXGRequestProgressBlock)(ZXGNetworkTask *, NSProgress *);

/**
 网络请求地址

 - ZXGNetworkRequestTypeOrange: 橘子网络的请求
 - ZXGNetworkRequestTypeXKP: 新开普的请求
 - ZXGNetworkRequestTypeYouKu: 优酷的请求
 */
typedef NS_ENUM(NSUInteger, ZXGNetworkRequestType){
    ZXGNetworkRequestTypeOrange,
    ZXGNetworkRequestTypeXKP,
    ZXGNetworkRequestTypeYouKu,
};

/**
 网络请求方式

 - ZXGHttpRequestMethod_POST: POST
 - ZXGHttpRequestMethod_GET: GET
 - ZXGHttpRequestMethod_DELETE: DELETE
 - ZXGHttpRequestMethod_PUT: PUT
 */
typedef NS_ENUM (NSUInteger, ZXGHttpRequestMethod) {
    ZXGHttpRequestMethod_POST,
    ZXGHttpRequestMethod_GET,
    ZXGHttpRequestMethod_DELETE,
    ZXGHttpRequestMethod_PUT,
};


/**
 网络请求任务类型

 - ZXGNetworkTaskTypeJsonRequest: json请求
 - ZXGNetworkTaskTypeXmlRequest: xml请求
 - ZXGNetworkTaskTypeUploadFile: 上传文件
 - ZXGNetworkTaskTypeDownloadFile: 下载文件
 */
typedef NS_ENUM(NSUInteger, ZXGNetworkTaskType){
    ZXGNetworkTaskTypeJsonRequest,
    ZXGNetworkTaskTypeXmlRequest,
    ZXGNetworkTaskTypeUploadFile,
    ZXGNetworkTaskTypeDownloadFile,
};

#endif /* ZXGNetworkConstsDefine_h */
