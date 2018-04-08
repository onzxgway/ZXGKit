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

- (NSString *_Nullable)deleteQuery {
    
    NSMutableString *sql = [NSMutableString string];
    NSString *conditionStr = [self whereConditionSql];
    if (!conditionStr) {
        [sql appendFormat:@"DELETE FROM %@", _tableName];
    }
    else {
        [sql appendFormat:@"DELETE FROM %@ WHERE %@", _tableName, [self whereConditionSql]];
    }
    return sql;
}

- (NSString *_Nullable)updateQuery {
    
    return nil;
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

@end
