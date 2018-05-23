//
//  MJRefreshHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshComponent.h"

@interface MJRefreshHeader : MJRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (nonatomic, copy  ) NSString *lastUpdatedTimeKey;

@property (nonatomic, strong, readonly) NSDate *lastUpdatedTime;

@end
