//
//  ZXGDBConstDefine.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#ifndef ZXGDBConstDefine_h
#define ZXGDBConstDefine_h
#import <FMDB/FMDB.h>

/**
 数据库操作类型

 - ZXGDBActionTypeCreateTable: 建表
 - ZXGDBActionTypeInsert: 增
 - ZXGDBActionTypeDelete: 删
 - ZXGDBActionTypeUpdate: 改
 - ZXGDBActionTypeSelect: 查
 */
typedef NS_ENUM(NSUInteger, ZXGDBActionType) {
    ZXGDBActionTypeCreateTable,
    ZXGDBActionTypeInsert,
    ZXGDBActionTypeDelete,
    ZXGDBActionTypeUpdate,
    ZXGDBActionTypeSelect,
};


/**
 字段类型

 - ZXGDBColumnValueTypeText: 字符串
 - ZXGDBColumnValueTypeVarchar: <#ZXGDBColumnValueTypeVarchar description#>
 - ZXGDBColumnValueTypeInt: 整型
 - ZXGDBColumnValueTypeBigInt: <#ZXGDBColumnValueTypeBigInt description#>
 */
typedef NS_ENUM(NSUInteger, ZXGDBColumnValueType) {
    ZXGDBColumnValueTypeText,
    ZXGDBColumnValueTypeVarchar,
    ZXGDBColumnValueTypeInt,
    ZXGDBColumnValueTypeBigInt,
};

/**
 查询条件语句连接符

 - ZXGDBWhereOperationTypeEqual: 等于
 - ZXGDBWhereOperationTypeBigger: 大于
 - ZXGDBWhereOperationTypeSmaller: 小于
 - ZXGDBWhereOperationTypeBiggerEqual: 大于等于
 - ZXGDBWhereOperationTypeSmallerEqual: 小于等于
 */
typedef NS_ENUM(NSUInteger, ZXGDBWhereOperationType) {
    ZXGDBWhereOperationTypeEqual,
    ZXGDBWhereOperationTypeBigger,
    ZXGDBWhereOperationTypeSmaller,
    ZXGDBWhereOperationTypeBiggerEqual,
    ZXGDBWhereOperationTypeSmallerEqual,
};

#endif /* ZXGDBConstDefine_h */
