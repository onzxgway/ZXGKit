//
//  MJStatusResult.h
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJStatusResult : NSObject
/** 存放着某一页微博数据（里面都是Status模型） */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 存放着一堆的广告数据（里面都是MJAd模型） */
@property (strong, nonatomic) NSArray *ads;
/** 总数 */
@property (strong, nonatomic) NSNumber *totalNumber;
/** 上一页的游标 */
@property (assign, nonatomic) long long previousCursor;
/** 下一页的游标 */
@property (assign, nonatomic) long long nextCursor;
@end
