//
//  ZXGUseage.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGUseage.h"
#import "ZXGDBManager.h"
#import "ZXGPerson.h"
#import <MJExtension/MJExtension.h>

@implementation ZXGUseage

//创建数据库
+ (void)createDataBaseTable {
    
    ZXGDBOperation *operation = [[ZXGDBOperation alloc] init];
    
    ZXGDBCRUDCondition *condition = [[ZXGDBCRUDCondition alloc] init];
    condition.actionType = ZXGDBActionTypeCreateTable;
    condition.tableName = @"zxg_haha";
    
    NSMutableArray *columnArrayM = [NSMutableArray array];
    
    [ZXGPerson mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        ZXGDBColumnCondition *column = [[ZXGDBColumnCondition alloc] init];
        NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
        if ([enumerateString isEqualToString:@"currentAccount"]) {
            column.isPrimaryKey = YES;
            column.isNull = NO;
        }
        column.columnName = enumerateString;
        column.valueType = ZXGDBColumnValueTypeText;
        [columnArrayM addObject:column];
    }];
    
    condition.colunmConditions = columnArrayM;
    
    operation.actionCondition = condition;
    [[ZXGDBManager sharedManager] addOperation:operation];
}

//查询数据库数据
+ (void)queryDataBaseTableWithAccountParams:(NSDictionary *)paramsDic withSuccessBlock:(void(^)(NSArray *dataArray))successBlock withFaileBlock:(void(^)(NSString *errorStr))failureBlock {
    
    ZXGDBOperation *operation = [[ZXGDBOperation alloc] init];
    ZXGDBCRUDCondition *condition = [[ZXGDBCRUDCondition alloc] init];
    condition.actionType = ZXGDBActionTypeSelect;
    condition.tableName = @"zxg_haha";
    
    if(paramsDic){
        NSArray *array = [paramsDic allKeys];
        NSMutableArray *whereArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            ZXGDBWhereCondition *whereCondition = [[ZXGDBWhereCondition alloc] init];
            NSString *propertyName = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
            NSString *valueName = [NSString stringWithFormat:@"%@",[paramsDic objectForKey:propertyName]];
            whereCondition.columnName = propertyName;
            whereCondition.value = valueName;
            whereCondition.operaType = ZXGDBWhereOperationTypeEqual;
            [whereArray addObject:whereCondition];
        }
        
        condition.andConditions = whereArray;
    }
    
    operation.actionCondition = condition;
    
    NSMutableArray *dataArray = [@[] mutableCopy];
    
    NSMutableArray * enumNameArray = [NSMutableArray array];
    [ZXGPerson mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        NSString *enumerateString = [NSString stringWithFormat:@"%@",property.name];
        [enumNameArray addObject:enumerateString];
    }];
    operation.querySuccessCallback = ^(FMResultSet *resultSet) {
        while ([resultSet next]) {
            NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
            
            for (NSString *enumerateStr in enumNameArray) {
                NSString *nameStr = [resultSet stringForColumn:enumerateStr];
                if (nameStr ) {
                    [paramsDic setObject:nameStr forKey:enumerateStr];
                }
            }
            
            ZXGPerson *model = [ZXGPerson mj_objectWithKeyValues:paramsDic];
            [dataArray addObject:model];
        }
        [resultSet close];
        
        NSLog(@"dataArray --------- %@",dataArray);
        successBlock(dataArray);
        
    };
    operation.failCallback = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSString *errorStr = [error localizedDescription];
        failureBlock(errorStr);
    };
    
    [[ZXGDBManager sharedManager] addOperation:operation];
    
}


//存储数据
+ (void)insertinto:(ZXGPerson *)loginModel {
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    if (loginModel.currentAccount == nil) {
        return;
    }
    
    [paramsDic setObject:loginModel.currentAccount forKey:@"currentAccount"];
    
    [self queryDataBaseTableWithAccountParams:paramsDic withSuccessBlock:^(NSArray *dataArray) {
        if (dataArray.count > 0) {
            //说明该账号已存在
            [self performSelectorOnMainThread:@selector(updateDataBase:) withObject:loginModel waitUntilDone:0];
        }
        else {
            [self performSelectorOnMainThread:@selector(insertDataBase:) withObject:loginModel waitUntilDone:0];
        }
    } withFaileBlock:^(NSString *errorStr) {
        NSLog(@"%@", errorStr);
    }];
}

+ (void)insertDataBase:(ZXGPerson *)loginModel {
    
    if (loginModel.currentAccount == nil) {
        NSLog(@"存储的数据的主键为空，数据存储失败");
        return;
    }
    //说明该账号不存在
    ZXGDBOperation *operation = [[ZXGDBOperation alloc] init];
    ZXGDBCRUDCondition *condition = [[ZXGDBCRUDCondition alloc] init];
    condition.tableName = @"zxg_haha";
    condition.actionType = ZXGDBActionTypeInsert;
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[loginModel mj_keyValues]];
    condition.updateValues = @[paramsDic];
    
    operation.actionCondition = condition;
    operation.updateSuccessCallback = ^{
        NSLog(@"插入数据成功");
    };
    operation.failCallback = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"插入数据失败");
    };
    [[ZXGDBManager sharedManager] addOperation:operation];
}

//更新数据
+ (void)updateDataBaseTableWithAccountData:(ZXGPerson *)loginModel {
    
    if (loginModel.currentAccount == nil) {
        return;
    }
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:loginModel.currentAccount forKey:@"currentAccount"];
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

+ (void)updateDataBase:(ZXGPerson *)loginModel {
    
    ZXGDBOperation *operation = [[ZXGDBOperation alloc] init];
    ZXGDBCRUDCondition *condition = [[ZXGDBCRUDCondition alloc] init];
    condition.tableName = @"zxg_haha";
    condition.actionType = ZXGDBActionTypeUpdate;
    
    NSString *currentAccount = loginModel.currentAccount ?: @"";
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[loginModel mj_keyValues]];
    condition.updateValues = @[paramsDic];
    if(loginModel){
        ZXGDBWhereCondition *whereCondition = [[ZXGDBWhereCondition alloc] init];
        whereCondition.columnName = @"currentAccount";
        whereCondition.value = currentAccount;
        whereCondition.operaType = ZXGDBWhereOperationTypeEqual;
        condition.andConditions = @[whereCondition];
    }
    operation.actionCondition = condition;
    operation.updateSuccessCallback = ^{
        NSLog(@"更新数据成功");
    };
    operation.failCallback = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        NSLog(@"更新数据失败");
    };
    [[ZXGDBManager sharedManager] addOperation:operation];
}

//删除数据
+ (void)deleteDataBaseTableWithLoginModel:(ZXGPerson *)loginModel withSuccessBlock:(void(^)(NSString *successStr))successBlock withFailureBlock:(void(^)(NSString *errorStr))failureBlock {
    
    ZXGDBOperation *operation = [[ZXGDBOperation alloc] init];
    ZXGDBCRUDCondition *condition = [[ZXGDBCRUDCondition alloc] init];
    condition.tableName = @"zxg_haha";
    condition.actionType = ZXGDBActionTypeDelete;
    ZXGDBWhereCondition *whereCondition = [[ZXGDBWhereCondition alloc] init];
    whereCondition.columnName = @"currentAccount";
    whereCondition.value = loginModel.currentAccount;
    whereCondition.operaType = ZXGDBWhereOperationTypeEqual;
    condition.andConditions = @[whereCondition];
    
    operation.actionCondition = condition;
    operation.updateSuccessCallback = ^{
        successBlock(@"删除数据成功");
    };
    operation.failCallback = ^(NSError *error) {
        NSLog(@"error ------- %@",error);
        failureBlock(@"删除数据失败");
    };
    [[ZXGDBManager sharedManager] addOperation:operation];
    
}

@end
