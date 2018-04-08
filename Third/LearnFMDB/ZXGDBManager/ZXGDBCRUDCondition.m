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
    
    switch (_actionType) {
        case ZXGDBActionTypeCreateTable: {
            return [self createTable];
        }
            break;
        case ZXGDBActionTypeInsert: {
            
        }
            break;
        case ZXGDBActionTypeDelete: {
            
        }
            break;
        case ZXGDBActionTypeUpdate: {
            
        }
            break;
        case ZXGDBActionTypeSelect: {
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSString *_Nullable)createTable {
    
    if (!_tableName || [@"" isEqualToString:_tableName]) {
        [self createTableErr:@"建表错误没有表名称"];
        return nil;
    }
    
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
    
    return nil;
}

- (void)createTableErr:(NSString *)errorMsg {
    NSString *errMsg = [NSString stringWithFormat:@"%@ %@", NSStringFromClass([self class]), errorMsg];
    NSAssert(0, errMsg);
}

@end
