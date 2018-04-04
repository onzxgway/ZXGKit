//
//  JZUserDataServiceManager.m
//  eStudy(parents)
//
//  Created by 王精飞 on 2018/1/28.
//  Copyright © 2018年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "JZUserDataServiceManager.h"

@implementation JZUserDataServiceManager

//创建数据库
+ (void)createDataBaseTable {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.action = JZDatabaseActionCreateTable;
    condition.tableName = PARENTLOGINUSERINFORMATION;
    
    NSMutableArray *columnArrayM = [NSMutableArray array];
    
    [JZUserDataContentModel mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        JZDatabaseColunmCondition *column = [[JZDatabaseColunmCondition alloc] init];
         NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
        if ([JZIFISNULL(enumerateString) isEqualToString:@"currentAccount"]) {
            column.isPrimary = YES;
            column.isNotNull = YES;
        }
        column.colunmName = JZIFISNULL(enumerateString);
        column.valueType = JZDatabaseValueTypeText;
        [columnArrayM addObject:column];
    }];
    
    condition.createColunmConditions = columnArrayM;
    operation.actionCondition = condition;
    [[JZDatabaseManager shareManager] addOperation:operation];
}
//查询数据库数据
+ (void)queryDataBaseTableWithAccountParams:(NSDictionary *)paramsDic withSuccessBlock:(void(^)(NSArray *dataArray))successBlock withFaileBlock:(void(^)(NSString *errorStr))failureBlock {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.action = JZDatabaseActionSelect;
    condition.tableName = PARENTLOGINUSERINFORMATION;

    if(paramsDic){
        NSArray *array = [paramsDic allKeys];
        NSMutableArray *whereArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            JZDatabaseWhereCondition *whereCondition = [[JZDatabaseWhereCondition alloc] init];
            NSString *propertyName = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
            NSString *valueName = [NSString stringWithFormat:@"%@",[paramsDic objectForKey:JZIFISNULL(propertyName)]];
            whereCondition.columName = JZIFISNULL(propertyName);
            whereCondition.value = JZIFISNULL(valueName);
            whereCondition.operation = JZDatabaseWhereOperationEqual;
            [whereArray addObject:whereCondition];
        }
   
        condition.andConditions = whereArray;
    }
    
    operation.actionCondition = condition;
    
    NSMutableArray *dataArray = [@[] mutableCopy];
    
    NSMutableArray * enumNameArray = [NSMutableArray array];
    
    [JZUserDataContentModel mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
        [enumNameArray addObject:JZIFISNULL(enumerateString)];
    }];

    operation.QuerySuccess = ^(FMResultSet *resultSet) {
        while ([resultSet next]) {
            NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
            
            for (NSString *enumerateStr in enumNameArray) {
                NSString *nameStr = [resultSet stringForColumn:JZIFISNULL(enumerateStr)];
                [paramsDic setObject:JZIFISNULL(nameStr) forKey:JZIFISNULL(enumerateStr)];
            }

            JZUserDataContentModel *model = [JZUserDataContentModel mj_objectWithKeyValues:paramsDic];
            [dataArray addObject:model];
        }
        [resultSet close];
        
        NSLog(@"dataArray --------- %@",dataArray);
        successBlock(dataArray);
        
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSString *errorStr = [error localizedDescription];
        failureBlock(JZIFISNULL(errorStr));
    };
    
    [[JZDatabaseManager shareManager] addOperation:operation];
    
}
//存储数据
+ (void)storeSuccessLoginInformationToTheDataBaseWithAccountData:(JZUserDataContentModel *)loginModel {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    if (JZStringIsNull(loginModel.currentAccount)) {
        return;
    }
    [paramsDic setObject:JZIFISNULL(loginModel.currentAccount) forKey:@"currentAccount"];

    [self queryDataBaseTableWithAccountParams:paramsDic withSuccessBlock:^(NSArray *dataArray) {
        if (dataArray.count > 0) {
            //说明该账号已存在
            [self performSelectorOnMainThread:@selector(updateDataBase:) withObject:loginModel waitUntilDone:0];
        }else{
            [self performSelectorOnMainThread:@selector(insertDataBase:) withObject:loginModel waitUntilDone:0];
        }
    } withFaileBlock:^(NSString *errorStr) {

    }];
}
+ (void)insertDataBase:(JZUserDataContentModel *)loginModel {
    
    if (JZStringIsNull(loginModel.currentAccount)) {
        NSLog(@"存储的数据的主键为空，数据存储失败");
        return;
    }
    //说明该账号不存在
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = PARENTLOGINUSERINFORMATION;
    condition.action = JZDatabaseActionInsert;
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[loginModel mj_keyValues]];
    [paramsDic removeObjectForKey:@"hasPassword"];
    condition.updateValues = @[paramsDic];
    
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        NSLog(@"插入数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"存储的账号失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];
}
//更新数据
+ (void)updateDataBaseTableWithAccountData:(JZUserDataContentModel *)loginModel {

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:JZIFISNULL(loginModel.currentAccount) forKey:@"currentAccount"];
    [self queryDataBaseTableWithAccountParams:paramsDic withSuccessBlock:^(NSArray *dataArray) {
        if (dataArray.count > 0) {
            [self performSelectorOnMainThread:@selector(updateDataBase:) withObject:loginModel waitUntilDone:0];
        }else{
            [self performSelectorOnMainThread:@selector(insertDataBase:) withObject:loginModel waitUntilDone:0];
        }
    } withFaileBlock:^(NSString *errorStr) {
        NSLog(@"更新数据失败");
    }];
}
//更新数据中的密码
+ (void)updateLoginPassword:(NSDictionary *)paramsDic {
    
    [self queryDataBaseTableWithAccountParams:paramsDic withSuccessBlock:^(NSArray *dataArray) {
        if (dataArray.count > 0) {
            [self performSelector:@selector(updatePasswordToEmpty:) withObject:paramsDic afterDelay:0];
        }
    } withFaileBlock:^(NSString *errorStr) {
        NSLog(@"更新数据失败");
    }];
    

}
//将密码更新为空
+ (void)updatePasswordToEmpty:(NSDictionary *)paramsDic {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = PARENTLOGINUSERINFORMATION;
    condition.action = JZDatabaseActionUpdate;
    
    condition.updateValues = @[@{@"loginPassword":@""}];
    if(paramsDic){
        NSArray *array = [paramsDic allKeys];
        NSMutableArray *whereArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            NSString *propertyName = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
            NSString *valueName = [NSString stringWithFormat:@"%@",[paramsDic objectForKey:JZIFISNULL(propertyName)]];
            JZDatabaseWhereCondition *whereCondition = [[JZDatabaseWhereCondition alloc] init];
            whereCondition.columName = JZIFISNULL(propertyName);
            whereCondition.value = JZIFISNULL(valueName);
            whereCondition.operation = JZDatabaseWhereOperationEqual;
            [whereArray addObject:whereCondition];
        }
        
        condition.andConditions = whereArray;
    }
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        NSLog(@"更新数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"更新数据失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];
}
+ (void)updateDataBase:(JZUserDataContentModel *)loginModel {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = PARENTLOGINUSERINFORMATION;
    condition.action = JZDatabaseActionUpdate;
    
    NSString *currentAccount = JZIFISNULL(loginModel.currentAccount);
    
    if(![JZIFISNULL(loginModel.currentAccount) isEqualToString:JZIFISNULL(loginModel.phone)] && [JZIFISNULL(loginModel.currentAccount) length] == 11){
        loginModel.currentAccount = loginModel.phone;
    }
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[loginModel mj_keyValues]];
//    [paramsDic removeObjectForKey:@"currentAccount"];
    [paramsDic removeObjectForKey:@"hasPassword"];
    condition.updateValues = @[paramsDic];
    if(loginModel){
        JZDatabaseWhereCondition *whereCondition = [[JZDatabaseWhereCondition alloc] init];
        whereCondition.columName = @"currentAccount";
        whereCondition.value = JZIFISNULL(currentAccount);
        whereCondition.operation = JZDatabaseWhereOperationEqual;
        condition.andConditions = @[whereCondition];
    }
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        NSLog(@"更新数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"更新数据失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];
}
//删除数据
+ (void)deleteDataBaseTableWithLoginModel:(JZUserDataContentModel *)loginModel withSuccessBlock:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock {

    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = PARENTLOGINUSERINFORMATION;
    condition.action = JZDatabaseActionDelete;
    JZDatabaseWhereCondition *whereCondition = [[JZDatabaseWhereCondition alloc] init];
    whereCondition.columName = @"currentAccount";
    whereCondition.value = JZIFISNULL(loginModel.currentAccount);
    whereCondition.operation = JZDatabaseWhereOperationEqual;
    condition.andConditions = @[whereCondition];
    
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        successBlock(@"删除数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        failureBlock(@"删除数据失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];

}

#pragma mark -第三方

//创建第三方登录的数据库表
+ (void)createThirdPartyLoginTable {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.action = JZDatabaseActionCreateTable;
    condition.tableName = THIRDPARTYLOGIN_INFORMATION;
    
    NSMutableArray *columnArrayM = [NSMutableArray array];
    
    [UMSocialUserInfoResponse mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        JZDatabaseColunmCondition *column = [[JZDatabaseColunmCondition alloc] init];
        NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
        column.colunmName = JZIFISNULL(enumerateString);
        column.valueType = JZDatabaseValueTypeText;
        [columnArrayM addObject:column];
    }];
    
    condition.createColunmConditions = columnArrayM;
    operation.actionCondition = condition;
    [[JZDatabaseManager shareManager] addOperation:operation];
}

//存储第三方登录的信息
+ (void)storeThirdPartyLoginInformation:(UMSocialUserInfoResponse *)response {
    
    [self performSelector:@selector(insertThirdPartyLoginInformation:) withObject:response afterDelay:0];

}
+ (void)insertThirdPartyLoginInformation:(UMSocialUserInfoResponse *)loginModel {
   
    //说明该账号不存在
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = THIRDPARTYLOGIN_INFORMATION;
    condition.action = JZDatabaseActionInsert;
    NSMutableDictionary *dataDic = [NSMutableDictionary  dictionaryWithDictionary:[loginModel mj_keyValues]];
    condition.updateValues = @[dataDic];
    
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        NSLog(@"插入数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"存储的账号失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];
}
//获取存储的第三方信息
+ (void)obtainAllThirdPartyLoginInformation:(void(^)(NSArray<UMSocialUserInfoResponse *> *allDataArray))successBlock withFailBlock:(void(^)(NSString * errorStr))failureBlock {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.action = JZDatabaseActionSelect;
    condition.tableName = THIRDPARTYLOGIN_INFORMATION;

    operation.actionCondition = condition;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    operation.QuerySuccess = ^(FMResultSet *resultSet) {
        while ([resultSet next]) {
            NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
            [UMSocialUserInfoResponse mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
                NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
                NSString *nameStr = [resultSet stringForColumn:JZIFISNULL(enumerateString)];
                [paramsDic setObject:JZIFISNULL(nameStr) forKey:JZIFISNULL(enumerateString)];
            }];
            UMSocialUserInfoResponse *model = [UMSocialUserInfoResponse mj_objectWithKeyValues:paramsDic];
            [dataArray addObject:model];
        }
        NSLog(@"dataArray --------- %@",dataArray);
        successBlock(dataArray);
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSString *errorStr = [error localizedDescription];
        failureBlock(JZIFISNULL(errorStr));
    };
    
    [[JZDatabaseManager shareManager] addOperation:operation];
    
}
//清空表中的所有内容
+ (void)deleteThirdPartyLoginAllInformation:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock {
    
    JZDatabaseOperation *operation = [[JZDatabaseOperation alloc] init];
    JZDatabaseCRUDCondition *condition = [[JZDatabaseCRUDCondition alloc] init];
    condition.tableName = THIRDPARTYLOGIN_INFORMATION;
    condition.action = JZDatabaseActionDelete;
    operation.actionCondition = condition;
    operation.updateSuccess = ^{
        successBlock(@"删除数据成功");
    };
    operation.faild = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        failureBlock(@"删除数据失败");
    };
    [[JZDatabaseManager shareManager] addOperation:operation];
}
@end
