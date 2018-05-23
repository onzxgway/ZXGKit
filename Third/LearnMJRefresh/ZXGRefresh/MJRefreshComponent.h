//
//  MJRefreshComponent.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"
#import "NSBundle+MJRefresh.h"

/** 刷新控件的状态 */
typedef NS_ENUM(NSUInteger, MJJRefreshState) {
    /** 普通闲置状态 */
    MJJRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    MJJRefreshStatePulling,
    /** 正在刷新中的状态 */
    MJJRefreshStateRefreshing,
    /** 即将刷新的状态 */
    MJJRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    MJJRefreshStateNoMoreData
};

/** 进入刷新状态的回调 */
typedef void (^MJRefreshComponentRefreshingBlock)(void);
/** 结束刷新后的回调 */
typedef void (^MJRefreshComponentEndRefreshingCompletionBlock)(void);

@interface MJRefreshComponent : UIView {
    @protected
    __weak UIScrollView *_scrollView;
    UIEdgeInsets _scrollViewOriginalInset;
}

@property (nonatomic, weak  ) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic) MJJRefreshState state;

/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
@property (nonatomic, weak  ) id refreshingTarget;
@property (nonatomic) SEL refreshingAction;

@property (nonatomic, copy  ) MJRefreshComponentRefreshingBlock refreshingBlock;
@property (nonatomic, copy  ) MJRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;
- (void)beginRefresh;
- (void)endRefresh;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

#pragma mark - 子类重写
- (void)prepare NS_REQUIRES_SUPER;
- (void)placeSubviews NS_REQUIRES_SUPER;
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

@property (nonatomic) CGFloat pullingPercent;
@property (nonatomic, getter=isAutomaticallyChangeAplha) CGFloat automaticallyChangeAlpha;

@end


@interface UILabel(MJRefresh)

+ (instancetype)mj_label;
- (CGFloat)mj_textWith;

@end

