//
//  IMJRefreshComponent.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/21.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"
#import "NSBundle+MJRefresh.h"

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, MJRefreshState) {
    /** 普通闲置状态 */
    MJRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    MJRefreshStatePulling,
    /** 正在刷新中的状态 */
    MJRefreshStateRefreshing,
    /** 即将刷新的状态 */
    MJRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    MJRefreshStateNoMoreData
};

/** 进入刷新状态的回调 */
typedef void (^MJRefreshComponentRefreshingBlock)(void);
/** 结束刷新后的回调 */
typedef void (^MJRefreshComponentEndRefreshingCompletionBlock)(void);

@interface IMJRefreshComponent : UIView {
    __weak UIScrollView *_scrollView;
    UIEdgeInsets _scrollViewOriginalInset;
}

#pragma mark - 刷新状态控制
/** 刷新状态 一般交给子类内部实现 */
@property (assign, nonatomic) MJRefreshState state;
/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;

#pragma mark - 刷新回调
/** 正在刷新的回调 */
@property (copy, nonatomic) MJRefreshComponentRefreshingBlock refreshingBlock;
/** 结束刷新的回调 */
@property (copy, nonatomic) MJRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

/** 回调对象 */
@property (weak, nonatomic) id refreshingTarget;
/** 回调方法 */
@property (assign, nonatomic) SEL refreshingAction;

/** 记录scrollView刚开始的inset */
@property (nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
// 子类访问
@property (nonatomic, weak    ) UIScrollView *scrollView;   // scrollview

// 子类去重写的
- (void)prepare NS_REQUIRES_SUPER;
- (void)placeSubviews NS_REQUIRES_SUPER;
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

#pragma mark - 其他
/** 拉拽的百分比(交给子类重写) */
@property (nonatomic) CGFloat pullingPercent;
/** 根据拖拽比例自动切换透明度 */
@property (nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;

@end

@interface UILabel(MJRefresh)

+ (instancetype)mj_label;
- (CGFloat)mj_textWith;

@end




