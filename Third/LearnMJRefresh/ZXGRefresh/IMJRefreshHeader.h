//
//  IMJRefreshHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/21.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "IMJRefreshComponent.h"

@interface IMJRefreshHeader : IMJRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;


@end
