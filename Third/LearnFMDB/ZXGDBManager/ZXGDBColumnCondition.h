//
//  ZXGDBColumnCondition.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGDBConstDefine.h"

@interface ZXGDBColumnCondition : NSObject

/** 是否是主键*/
@property (nonatomic, assign) BOOL isPrimaryKey;

/** 主键是否自增长*/
@property (nonatomic, assign) BOOL isAutoIncrease;

/** 字段名称*/
@property (nonatomic, copy  ) NSString *columnName;

/** 字段数据类型*/
@property (nonatomic, assign) ZXGDBColumnValueType valueType;

/** 数据长度*/
@property (nonatomic, assign) NSInteger limitLength;

/** 字段默认值*/
@property (nonatomic, copy  ) NSString *defaultValue;

/** 是否为空*/
@property (nonatomic, assign) BOOL isNull;

/** sql语句*/
@property (nonatomic, copy  ) NSString *sqlPartStr;

@end
