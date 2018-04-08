//
//  ZXGDBConstDefine.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#ifndef ZXGDBConstDefine_h
#define ZXGDBConstDefine_h


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

#endif /* ZXGDBConstDefine_h */
