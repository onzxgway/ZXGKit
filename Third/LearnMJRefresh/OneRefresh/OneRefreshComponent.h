//
//  OneRefreshComponent.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneRefreshConst.h"

typedef NS_ENUM(NSUInteger, OneRefreshStatus) {
    OneRefreshStatusNormal,
    OneRefreshStatusPulling,
    OneRefreshStatusRefreshing,
};

typedef void(^BeginRefreshingCallback)(void);

/**
 刷新控件 基类
 */
@interface OneRefreshComponent : UIView {
    __weak UIScrollView *_scrollView;
    UIEdgeInsets _originalInsets;
}

@property (nonatomic, weak  ) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets originalInsets;
@property (nonatomic) OneRefreshStatus status;


@property (nonatomic, copy  ) BeginRefreshingCallback beginRefreshingCallback;
- (void)setTarget:(id)target sel:(SEL)action;
@property (nonatomic, weak  ) id target;
@property (nonatomic) SEL action;
- (void)executeRefreshingCallback;

- (void)beginRefresh;
- (void)endRefresh;

- (void)prepare NS_REQUIRES_SUPER;
- (void)placeSubviews NS_REQUIRES_SUPER;
- (void)scrollViewContentOffsetChanged:(NSDictionary<NSKeyValueChangeKey,id> *)change NS_REQUIRES_SUPER;

@property (nonatomic) CGFloat alphaPercent;

@end


@interface UILabel (OneRefresh)

+ (instancetype)oneRefreshLabel;

@end




