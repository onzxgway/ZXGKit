//
//  ZXGDBManager.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGDBManager.h"

@interface ZXGDBManager ()
/** 操作集合*/
@property (nonatomic, strong) NSMutableArray<FMDatabaseQueue *> *operationPools;
@end

@implementation ZXGDBManager

+ (ZXGDBManager *)sharedManager {
    static ZXGDBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMutableArray<FMDatabaseQueue *> *)operationPools {
    if (!_operationPools) {
        _operationPools = [NSMutableArray array];
    }
    return _operationPools;
}

- (void)addOperation:(ZXGDBOperation *)operation {
    
    FMDatabaseQueue *findQueue = nil;
    for (FMDatabaseQueue *dbQueue in _operationPools) {
        
        if ([dbQueue.path isEqualToString:operation.dbPath]) {
            findQueue = dbQueue;
            break;
        }
    }
    
    //如果能找到对应的数据库路径
    if (!findQueue) {
        //创建一个新的库
        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc] initWithPath:operation.dbPath];
        [_operationPools addObject:queue];
        NSLog(@"数据库地址:-->\n %@ \n<--\n",operation.dbPath);
        
        findQueue = queue;
    }
    
    //操作条件是否合法
    if (!operation.actionCondition.isValidate) {
        if (operation.failCallback) {
//            operation.failCallback([NSError errorWithDomain:@"com.ZXGDBManager.error" code:-888 userInfo:@{@"errMsg":operation.actionCondition.conditionErrorMsg}]);
        }
        return;
    }
    
    [findQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [self exeSql:db opera:operation];
    }];
}

- (void)exeSql:(FMDatabase *)db opera:(ZXGDBOperation *)operation {
    
    //打开数据库
    if (![db open]) {
        if (operation.failCallback) {
            operation.failCallback([NSError errorWithDomain:@"com.ZXGDBManager.error" code:-888 userInfo:@{@"errMsg" : @"数据库未打开"}]);
        }
        return;
    }
    
    switch (operation.actionCondition.actionType) {
        case ZXGDBActionTypeCreateTable: {
            NSLog(@"创建表");
        }
        case ZXGDBActionTypeDelete: {
            [self delete:db opera:operation];
        }
            break;
        case ZXGDBActionTypeUpdate: {
            [self update:db opera:operation];
        }
            break;
        case ZXGDBActionTypeInsert: {
            [self insert:db opera:operation];
        }
            break;
        case ZXGDBActionTypeSelect: {
            [self select:db opera:operation];
        }
            break;
            
        default:
            break;
    }
}

- (void)insert:(FMDatabase *)db opera:(ZXGDBOperation *)operation {
    
    [db beginTransaction];
    BOOL isRollBack = NO;
    
    @try {
        
        for (NSArray *valueItem in operation.actionCondition.insertValues) {
            
            [db executeUpdate:operation.actionCondition.sqlStr withArgumentsInArray:valueItem];
            
        }
    } @catch (NSException *exception) {
        
        isRollBack = YES;
        [db rollback];
        
    } @finally {
        if (!isRollBack) {
            
            [db commit];
            
            if (operation.updateSuccessCallback) {
                
                operation.updateSuccessCallback();
            }
            
        }
        else {
            
            if (operation.failCallback) {
                
                operation.failCallback([NSError errorWithDomain:@"ZXGDBManager" code:999 userInfo:@{@"msg":@"数据库执行失败"}]);
            }
        }
    }
}

- (void)update:(FMDatabase *)db opera:(ZXGDBOperation *)operation {
    [db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (NSDictionary *valueItem in operation.actionCondition.updateValues) {
            
            [db executeUpdate:operation.actionCondition.sqlStr withArgumentsInArray:valueItem.allValues];
            
        }
    } @catch (NSException *exception) {
        
        isRollBack = YES;
        [db rollback];//如果失败了，一定要回滚（一条插入失败，所有的都失败）
        
    } @finally {
        if (!isRollBack) {
            
            [db commit];
            
            if (operation.updateSuccessCallback) {
                
                operation.updateSuccessCallback();
            }
        }
        else {
            
            if (operation.failCallback) {
                
                operation.failCallback([NSError errorWithDomain:@"ZXGDBManager" code:999 userInfo:@{@"msg":@"数据库执行失败"}]);
            }
        }
    }
}

- (void)select:(FMDatabase *)db opera:(ZXGDBOperation *)operation {
    FMResultSet *resultSet = [db executeQuery:operation.actionCondition.sqlStr];
    
    if (resultSet) {
        
        if (operation.querySuccessCallback) {
            operation.querySuccessCallback(resultSet);
        }
    }
    else {
        
        if (operation.failCallback) {
            
            operation.failCallback([NSError errorWithDomain:@"ZXGDBManager" code:999 userInfo:@{@"msg":@"数据库执行失败"}]);
        }
    }
}

- (void)delete:(FMDatabase *)db opera:(ZXGDBOperation *)operation {
    BOOL result = [db executeUpdate:operation.actionCondition.sqlStr];
    
    if (result) {
        
        if (operation.updateSuccessCallback) {
            operation.updateSuccessCallback();
        }
        
    }
    else {
        
        if (operation.failCallback) {
            operation.failCallback([NSError errorWithDomain:@"ZXGDBManager" code:999 userInfo:@{@"msg":@"数据库执行失败"}]);
        }
    }
}

@end
