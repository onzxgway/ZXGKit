//
//  ZXGUseage.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXGPerson;

@interface ZXGUseage : NSObject

//创建数据库
+ (void)createDataBaseTable;

//查询数据库数据
+ (void)queryDataBaseTableWithAccountParams:(NSDictionary *)paramsDic withSuccessBlock:(void(^)(NSArray *dataArray))successBlock withFaileBlock:(void(^)(NSString *errorStr))failureBlock;

//存储数据
+ (void)insertinto:(ZXGPerson *)loginModel;

//更新数据
+ (void)updateDataBaseTableWithAccountData:(ZXGPerson *)loginModel;

//删除数据
+ (void)deleteDataBaseTableWithLoginModel:(ZXGPerson *)loginModel withSuccessBlock:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock;

@end
