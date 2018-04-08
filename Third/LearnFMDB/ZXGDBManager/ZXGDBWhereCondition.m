//
//  ZXGDBWhereCondition.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGDBWhereCondition.h"

@implementation ZXGDBWhereCondition

- (NSString *)sqlWherePartStr {
    
    NSString *operate = [[self operationDict] objectForKey:@(_operaType)];
    
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"%@ %@ '%@'", _columnName, operate, _value];
    
    return sql;
}

- (NSDictionary *)operationDict {
    
    return @{
             @(ZXGDBWhereOperationTypeEqual) : @"=",
             
             @(ZXGDBWhereOperationTypeBigger) : @">",
             
             @(ZXGDBWhereOperationTypeSmaller) : @"<",
             
             @(ZXGDBWhereOperationTypeBiggerEqual) : @">=",
             
             @(ZXGDBWhereOperationTypeSmallerEqual) : @"<=",
             
             };
}

@end
