//
//  ZXGDBCRUDCondition.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGDBCRUDCondition.h"

@implementation ZXGDBCRUDCondition

- (NSString *)sqlStr {
    
    [self judgeTableName];
    
    switch (_actionType) {
        case ZXGDBActionTypeCreateTable: {
            return [self createTable];
        }
            break;
        case ZXGDBActionTypeInsert: {
            return [self insertQuery];
        }
            break;
        case ZXGDBActionTypeDelete: {
            return [self deleteQuery];
        }
            break;
        case ZXGDBActionTypeUpdate: {
            return [self updateQuery];
        }
            break;
        case ZXGDBActionTypeSelect: {
            return [self selectQuery];
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSString *_Nullable)insertQuery {
    
    if (_updateValues.count == 0) {
        NSLog(@"试图更新表，却没有任何更新值！");
        return nil;
    }
    NSDictionary *item = [_updateValues firstObject];
    NSMutableString *sqlStr = [NSMutableString string];
    
    [sqlStr appendFormat:@"INSERT INTO %@ (%@) VALUES %@", _tableName, [self updateKeysToString:item.allKeys], [self argumentTupleOfSize:item.allKeys.count]];;
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), sqlStr);
    return sqlStr;
}

- (NSString *)updateKeysToString:(NSArray *)array {
    return [array componentsJoinedByString:@","];
}

- (NSString *)argumentTupleOfSize:(NSUInteger)tupleSize {
    NSMutableArray * tupleString = [NSMutableArray array];
    [tupleString addObject:@"("];
    for (NSUInteger columnIdx = 0; columnIdx < tupleSize; columnIdx++)
    {
        if (columnIdx > 0) {
            [tupleString addObject:@","];
        }
        [tupleString addObject:@"?"];
    }
    [tupleString addObject:@")"];
    
    return [tupleString componentsJoinedByString:@" "];
}

- (NSString *_Nullable)deleteQuery {
    
    NSMutableString *sql = [NSMutableString string];
    NSString *conditionStr = [self whereConditionSql];
    if (!conditionStr) {
        [sql appendFormat:@"DELETE FROM %@", _tableName];
    }
    else {
        [sql appendFormat:@"DELETE FROM %@ WHERE %@", _tableName, [self whereConditionSql]];
    }
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), sql);
    return sql;
}

- (NSString *_Nullable)updateQuery {
    if (_updateValues.count == 0) {
        NSLog(@"试图更新表，却没有任何更新值！");
        return nil;
    }
    NSDictionary *item = [_updateValues firstObject];
    NSMutableString *sqlStr = [NSMutableString string];
    
    [sqlStr appendFormat:@"update %@ set %@ where %@", _tableName, [self argumentTupleOfSizeWithParams:item.allKeys], [self whereConditionSql]];

    
    NSLog(@"%@ %@", NSStringFromClass([self class]), sqlStr);
    return sqlStr;
}

- (NSString *)argumentTupleOfSizeWithParams:(NSArray *)params {
    NSMutableArray * tupleString = [NSMutableArray array];
    for (NSUInteger columnIdx = 0; columnIdx < params.count; columnIdx++)
    {
        if (columnIdx > 0)
        {
            [tupleString addObject:@","];
        }
        [tupleString addObject:[params objectAtIndex:columnIdx]];
        [tupleString addObject:@"="];
        [tupleString addObject:@"?"];
    }
    
    return [tupleString componentsJoinedByString:@" "];
}

- (NSString *_Nullable)selectQuery {
    
    NSMutableString *sqlStr = [NSMutableString string];
    if (_queryColoums && _queryColoums.count > 0) {
        
        if (_andConditions && _andConditions.count > 0) {
            [sqlStr appendFormat:@"select %@ from %@ where %@",[_queryColoums componentsJoinedByString:@","], _tableName, [self whereConditionSql]];
        }
        else {
            [sqlStr appendFormat:@"select %@ from %@",[_queryColoums componentsJoinedByString:@","], _tableName];
        }
    }
    else {
        
        if (_andConditions && _andConditions.count > 0) {
            
            [sqlStr appendFormat:@"select * from %@ where %@", _tableName, [self whereConditionSql]];
        }
        else {
            [sqlStr appendFormat:@"select * from %@", _tableName];
        }
        
    }
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), sqlStr);
    return sqlStr;
}

- (NSString *_Nullable)createTable {
    
    if (!_colunmConditions || _colunmConditions.count == 0) {
        [self createTableErr:@"建表错误没有属性字段"];
        return nil;
    }
    
    NSMutableString *sqlStr = [NSMutableString string];
    [sqlStr appendFormat:@"create table if not exists %@ (", _tableName];
    
    for (NSInteger i = 0 ; i < _colunmConditions.count ; ++i) {
        
        ZXGDBColumnCondition *columnCondition = [_colunmConditions objectAtIndex:i];
        
        if (i != _colunmConditions.count - 1) {
            [sqlStr appendFormat:@"%@,", columnCondition.sqlPartStr];
            
        }
        else {
            [sqlStr appendFormat:@"%@)", columnCondition.sqlPartStr];
        }
    }
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), sqlStr);
    return sqlStr;
}


- (void)createTableErr:(NSString *)errorMsg {
    NSString *errMsg = [NSString stringWithFormat:@"%@ %@", NSStringFromClass([self class]), errorMsg];
    NSAssert(0, errMsg);
}

- (void)judgeTableName {
    if (!_tableName || [@"" isEqualToString:_tableName]) {
        [self createTableErr:@"建表错误没有表名称"];
    }
}

- (NSString *_Nullable)whereConditionSql {
    if (!_andConditions || _andConditions.count <= 0) {
        return nil;
    }
    
    NSMutableString *sql = [NSMutableString string];
    for (NSInteger i = 0; i < _andConditions.count; ++i) {
        
        ZXGDBWhereCondition *condition = [_andConditions objectAtIndex:i];
        
        if (i != _andConditions.count -1) {
            
            [sql appendFormat:@"%@ and ", condition.sqlWherePartStr];
            
        }
        else {
            [sql appendFormat:@"%@",condition.sqlWherePartStr];
        }
        
    }
    
    return sql;
}


- (BOOL)isValidate {
    BOOL isValidate = YES;
    
    if (!_tableName || [@"" isEqualToString:_tableName]) {
        isValidate = NO;
//        _conditionErrorMsg = @"没有表名";
        return isValidate;
    }
    
    switch (_actionType) {
        case ZXGDBActionTypeInsert: {
            if (_updateValues.count == 0) {
//                _conditionErrorMsg = @"插入一行记录但是没有任何值可以用";
                isValidate = NO;
            }
        }
            break;
        default:
            break;
    }
    
    return isValidate;
}

- (NSArray *)insertValues {
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (NSDictionary *item in _updateValues) {
        [valueArray addObject:item.allValues];
    }
    
    return valueArray;
}

@end
