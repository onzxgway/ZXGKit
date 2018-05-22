//
//  IMJRefreshHeader.m
//  Third
//
//  Created by 朱献国 on 2018/5/21.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "IMJRefreshHeader.h"

@interface IMJRefreshHeader ()
@property (nonatomic) CGFloat insetTDelta;
@end

@implementation IMJRefreshHeader

#pragma mark - 构造方法
/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    IMJRefreshHeader *header = [[IMJRefreshHeader alloc] init];
    header.refreshingBlock = refreshingBlock;
    return header;
}

/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    IMJRefreshHeader *header = [[IMJRefreshHeader alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

- (void)prepare {
    [super prepare];
    
    self.mj_h = MJRefreshHeaderHeight;
    
    // 设置key
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
}

- (void)placeSubviews {
    [super placeSubviews];
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.mj_y = - self.mj_h;
}

// 根据不同的偏移量设置不同的状态
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == MJRefreshStateRefreshing) {
        // 暂时保留
        if (self.window == nil) return;

        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;

        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }

    // 当前的偏移量
    CGFloat offsetY = _scrollView.mj_offsetY;
    // 头部控件刚好出现的偏移量
    CGFloat happenOffsetY = -_scrollViewOriginalInset.top;
    if (offsetY > happenOffsetY) return;
    NSLog(@"----->offsetY:%f", offsetY);
    NSLog(@"happenOffsetY:%f<-----", happenOffsetY);

    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;

    if (_scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {
        [self beginRefreshing];
    }
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;

        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:MJRefreshHeaderLastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

        // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            _scrollView.mj_insetT += self.insetTDelta;

            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;

            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    }
    else if (state == MJRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                // 增加滚动区域top
                CGFloat top = _scrollViewOriginalInset.top + self.mj_h;
                _scrollView.mj_insetT = top;
                CGPoint offset = _scrollView.contentOffset;
                offset.y = -top;
                // 设置滚动位置
                [_scrollView setContentOffset:offset animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

#pragma mark - 公共方法
- (NSDate *)lastUpdatedTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

@end
