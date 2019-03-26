//
//  GGRefreshComponent.h
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GGRefreshState) {
    GGRefreshStateIdle = 1,  // 普通闲置状态
    GGRefreshStatePulling,
    GGRefreshStateRefreshing,
    GGRefreshStateNoMoreData,
};

typedef void(^BeginRefresh)(void);  // 开始刷新

@interface GGRefreshComponent : UIView {
    @protected
    __weak UIScrollView *_scrollView;
    UIEdgeInsets _originalContentInset;
}

+ (instancetype)refreshWithBlock:(BeginRefresh)beginRefresh;

@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic) GGRefreshState state;
@property (nonatomic) UIEdgeInsets originalContentInset;
@property (nonatomic) BeginRefresh beginRefreshBlock;
@property (nonatomic) CGFloat pullingPercent;

- (void)beginRefresh;
- (void)endRefresh;

#pragma mark - SubClass Override
- (void)prepare NS_REQUIRES_SUPER;
- (void)placeSubviews NS_REQUIRES_SUPER;
- (void)scrollViewContentOffsetChanged:(NSValue *)contentOffset NS_REQUIRES_SUPER;
- (void)scrollViewPanGestureChanged:(NSNumber *)PanGestureState NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeChanged:(NSValue *)contentSize NS_REQUIRES_SUPER;

@end


@interface UILabel (GGRefresh)

- (CGFloat)textWidth;

@end

NS_ASSUME_NONNULL_END
