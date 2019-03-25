//
//  NewRefreshComponent.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NRRefreshState) {
    NRRefreshStateIdle,
    NRRefreshStatePulling,
    NRRefreshStateRefreshing,
};

typedef void(^RefreshBlock)(void);

@interface NewRefreshComponent : UIView

@property (nonatomic, weak  ) UIScrollView *scrollView;
@property (nonatomic) NRRefreshState state;
@property (nonatomic) RefreshBlock refreshBlock;
@property (nonatomic) UIEdgeInsets originalInsets;

+ (instancetype)refreshWithBlock:(RefreshBlock)refreshBlock;


- (void)endRefresh;
- (void)beginRefresh;

#pragma mark - subclass override
- (void)addSubViews NS_REQUIRES_SUPER;
- (void)placeSubViews NS_REQUIRES_SUPER;
- (void)scrollViewDidChanged:(NSValue *)contentOffset NS_REQUIRES_SUPER;
- (void)scrollViewGestureStateDidChanged:(NSNumber *)state NS_REQUIRES_SUPER;
- (void)scrollViewSizeDidChanged:(NSValue *)contentSize NS_REQUIRES_SUPER;

@end


@interface UILabel (Refresh)

- (CGFloat)textWidth;

@end



NS_ASSUME_NONNULL_END
