//
//  UIScrollView+GGRefresh.h
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (GGRefresh)

@property (nonatomic, strong) GGRefreshComponent *gg_headerRefresh;

@property (nonatomic, strong) GGRefreshComponent *gg_footerRefresh;

@end

NS_ASSUME_NONNULL_END
