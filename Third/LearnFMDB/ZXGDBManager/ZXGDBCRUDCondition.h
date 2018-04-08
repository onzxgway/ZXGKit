//
//  ZXGDBCRUDCondition.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGDBColumnCondition.h"
#import "ZXGDBWhereCondition.h"

@interface ZXGDBCRUDCondition : NSObject

/** 操作类型*/
@property (nonatomic, assign) ZXGDBActionType actionType;

/** 建表 表名*/
@property (nonatomic, copy  ) NSString *tableName;

/** 建表 字段属性集合*/
@property (nonatomic, strong) NSArray<ZXGDBColumnCondition *> *colunmConditions;

/** 查询 目标字段集合*/
@property (nonatomic, strong) NSArray<NSString *> *queryColoums;

/** 查询 条件集合*/
@property (nonatomic, strong) NSArray<ZXGDBWhereCondition *> *andConditions;

/** 操作sql语句*/
@property (nonatomic, copy  , readonly) NSString *sqlStr;

@end
