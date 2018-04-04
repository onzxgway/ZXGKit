//
//  JZDatabaseColunmCondition.m
//  eStudy
//
//         我有一壶酒,足以慰风尘
//         倾倒江海里,共饮天下人
//
//  Created by 李长恩 on 17/5/25.
//  Copyright © 2017年 李长恩. All rights reserved.
//

#import "JZDatabaseColunmCondition.h"
#import "JZStringMacrocDefine.h"
@implementation JZDatabaseColunmCondition


- (instancetype)init
{
    if (self = [super init]) {
        
        self.isPrimary = NO;
        self.isAutoIncrease = NO;
    }
    return self;
}

- (NSString *)sqlString
{
    NSMutableString *sql = [NSMutableString string];
    
    //属性
    [sql appendFormat:@"%@ ",self.colunmName];
    
    //类型
    switch (self.valueType) {
        case JZDatabaseValueTypeText:
        {
            [sql appendString:@"text "];
        }
            break;
        case JZDatabaseValueTypeVarchar:
        {
            [sql appendFormat:@"varchar(%ld) ",self.limitLength];
        }
            break;
        case JZDatabaseValueTypeBigInt:
        {
            [sql appendString:@"bigint "];
        }
            break;
        case JZDatabaseValueTypeInt:
        {
            [sql appendString:@"INTEGER "];
        }
            break;
        default:
            break;
    }
    
    //是否主键
    if (self.isPrimary) {
        [sql appendFormat:@"primary key "];
    }
    
    //是否自增  AUTO_INCREMENT
    if (self.isAutoIncrease) {
        [sql appendFormat:@"AUTOINCREMENT "];
    }
    
    //是否不可以为空
    if (self.isNotNull) {
        
        [sql appendString:@"not null "];
    }
    
    //默认值
    if (![JZStringUitil stringIsNull:self.defaultValue]) {
        [sql appendFormat:@"default %@",self.defaultValue];
    }
    
    return sql;
}



@end
