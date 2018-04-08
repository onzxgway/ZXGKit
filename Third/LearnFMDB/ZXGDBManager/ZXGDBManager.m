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
@property (nonatomic, strong) NSMutableArray<ZXGDBOperation *> *operationPools;
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

- (NSMutableArray<ZXGDBOperation *> *)operationPools {
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
}

@end
