//
//  JZUserDataServiceManager.h
//  eStudy(parents)
//
//  Created by 王精飞 on 2018/1/28.
//  Copyright © 2018年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JZUserDataServiceManager : NSObject

//创建数据库
+ (void)createDataBaseTable;

//查询数据库数据
+ (void)queryDataBaseTableWithAccountParams:(NSDictionary *)paramsDic withSuccessBlock:(void(^)(NSArray *dataArray))successBlock withFaileBlock:(void(^)(NSString *errorStr))failureBlock;

//存储数据
+ (void)storeSuccessLoginInformationToTheDataBaseWithAccountData:(JZUserDataContentModel *)loginModel;


//更新数据
+ (void)updateDataBaseTableWithAccountData:(JZUserDataContentModel *)loginModel;

//更新数据中的密码
+ (void)updateLoginPassword:(NSDictionary *)paramsDic;


//删除数据
+ (void)deleteDataBaseTableWithLoginModel:(JZUserDataContentModel *)loginModel withSuccessBlock:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock;

#pragma mark -第三方登录

//创建第三方登录的数据库表
+ (void)createThirdPartyLoginTable;

//存储第三方登录的信息
+ (void)storeThirdPartyLoginInformation:(UMSocialUserInfoResponse *)response;

//获取存储的第三方信息
+ (void)obtainAllThirdPartyLoginInformation:(void(^)(NSArray<UMSocialUserInfoResponse *> *allDataArray))successBlock withFailBlock:(void(^)(NSString * errorStr))failureBlock;

//清空表中的所有内容
+ (void)deleteThirdPartyLoginAllInformation:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock;

@end
