//
//  MJRefreshNormalHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshHeader.h"

@interface MJRefreshStateHeader : MJRefreshHeader

@property (nonatomic, copy  ) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
@property (nonatomic, strong, readonly) UILabel *stateLabel;
@property (nonatomic, strong, readonly) UILabel *lastUpdatedTimeLabel;
/** 文字距离圈圈、箭头的距离 */
@property (nonatomic) CGFloat labelLeftInset;

@end
