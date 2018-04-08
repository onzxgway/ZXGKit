//
//  ZXGDBColumnCondition.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGDBColumnCondition.h"

@implementation ZXGDBColumnCondition

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isPrimaryKey = NO;
        _isAutoIncrease = NO;
        _isNull = NO;
    }
    return self;
}

- (NSString *)sqlPartStr {
    
    if (!_columnName || [@"" isEqualToString:_columnName]) {
        [self createTableErr:@"建表错误 字段名称不可以为空"];
        return nil;
    }
    
    //名称
    NSMutableString *sqlPartStr = [NSMutableString string];
    [sqlPartStr appendFormat:@"%@ ", _columnName];
    
    //数据类型及长度
    switch (_valueType) {
        case ZXGDBColumnValueTypeInt: {
            [sqlPartStr appendString:@"INTEGER "];
        }
            break;
        case ZXGDBColumnValueTypeBigInt: {
            [sqlPartStr appendString:@"BIGINT "];
        }
            break;
        case ZXGDBColumnValueTypeVarchar: {
            [sqlPartStr appendFormat:@"VARCHAR(%ld) ", _limitLength];
        }
            break;
        case ZXGDBColumnValueTypeText: {
            [sqlPartStr appendString:@"TEXT "];
        }
            break;
        default:
            break;
    }
    
    //是否是主键
    if (_isPrimaryKey) {
        [sqlPartStr appendFormat:@"PRIMARY KEY "];
        
        //是否自增
        if (_isAutoIncrease) {
            [sqlPartStr appendFormat:@"AUTOINCREMENT "];
        }
    }
    
    //是否为空
    if (!_isNull) {
        [sqlPartStr appendString:@"NOT NULL "];
    }
    
    //默认值
    if (_defaultValue) {
        [sqlPartStr appendFormat:@"DEFAULT %@", _defaultValue];
    }
    
    return sqlPartStr;
}

- (void)createTableErr:(NSString *)errorMsg {
    NSString *errMsg = [NSString stringWithFormat:@"%@ %@", NSStringFromClass([self class]), errorMsg];
    NSAssert(0, errMsg);
}

@end
