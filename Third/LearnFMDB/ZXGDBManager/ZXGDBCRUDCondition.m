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
    if ([JZStringUitil stringIsNull:self.tableName]) {
        NSLog(@"%@ 建表错误没有表名字",NSStringFromClass([JZDatabaseCRUDCondition class]));
        return nil;
    }
    if (self.createColunmConditions.count == 0) {
        NSLog(@"%@ 建表错误没有属性字段",NSStringFromClass([JZDatabaseCRUDCondition class]));
        return nil;
    }
    
    return nil;
}

@end
