//
//  OneRefreshHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "OneRefreshComponent.h"

@interface OneRefreshHeader : OneRefreshComponent

+ (instancetype)oneRefreshHeader:(id)target action:(SEL)action;

@property (nonatomic, copy) NSString *lastUpdatedTimeKey;

@end
