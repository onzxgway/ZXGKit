//
//  UIScrollView+Refresh.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NewRefreshComponent;

@interface UIScrollView (Refresh)

@property (nonatomic, strong) NewRefreshComponent *refreshView;

@end

NS_ASSUME_NONNULL_END
