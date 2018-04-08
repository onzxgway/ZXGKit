//
//  ZXGDBWhereCondition.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGDBConstDefine.h"

@interface ZXGDBWhereCondition : NSObject

/** 连接符类型*/
@property (nonatomic, assign) ZXGDBWhereOperationType operaType;

/** 字段名称*/
@property (nonatomic, copy  ) NSString *columnName;

/** 字段值*/
@property (nonatomic, copy  ) NSString *value;

/** sql*/
@property (nonatomic, copy  , readonly) NSString *sqlWherePartStr;

@end
