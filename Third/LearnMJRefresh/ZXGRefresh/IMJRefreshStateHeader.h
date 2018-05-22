//
//  IMJRefreshStateHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "IMJRefreshHeader.h"

@interface IMJRefreshStateHeader : IMJRefreshHeader
#pragma mark - 刷新时间相关
/** 利用这个block来决定显示的更新时间文字 */
@property (copy  , nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
/** 显示上一次刷新时间的label */
@property (weak  , nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

#pragma mark - 状态相关
/** 文字距离圈圈、箭头的距离 */
@property (nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak  , nonatomic, readonly) UILabel *stateLabel;

@end
