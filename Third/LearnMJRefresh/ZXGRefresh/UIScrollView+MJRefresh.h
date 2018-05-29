//
//  UIScrollView+MJRefresh.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/28.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
@class MJRefreshHeader;

@interface UIScrollView (MJRefresh)

// 下拉刷新
@property (nonatomic, strong) MJRefreshHeader *mj_header;

@end
