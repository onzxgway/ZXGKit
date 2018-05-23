//
//  MJRefreshHeader.m
//  Third
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshHeader.h"

@interface MJRefreshHeader ()

@end

@implementation MJRefreshHeader

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshHeader *header = [[MJRefreshHeader alloc] init];
    header.refreshingBlock = refreshingBlock;
    return header;
}
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshHeader *header = [[MJRefreshHeader alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

- (void)prepare {
    [super prepare];
    
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    self.mj_h = MJRefreshHeaderHeight;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.mj_y = - self.mj_h;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    //当前偏移量
    CGFloat offsetY = _scrollView.mj_offsetY;
    NSLog(@"=====> %f <=====", offsetY);
    
    //刷新控件 刚好出现的时候的 偏移量
    CGFloat happenOffsetY = -_scrollViewOriginalInset.top;
    NSLog(@" %f ", happenOffsetY);
    
    if (offsetY > happenOffsetY) return;
    
    //刷新控件 普通和即将刷新临界点 偏移量
    CGFloat normal2PullingOffsetY = happenOffsetY - self.mj_h;
    NSLog(@"_____ %f _____", normal2PullingOffsetY);
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    
    if (_scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        if (self.state == MJJRefreshStateIdle && offsetY < normal2PullingOffsetY) {
            self.state = MJJRefreshStatePulling;
        }
        else if (self.state == MJJRefreshStatePulling && offsetY >= normal2PullingOffsetY) {
            self.state = MJJRefreshStateIdle;
        }
    }
    else if (self.state == MJJRefreshStatePulling) {
        [self beginRefresh];
    }
    else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(MJJRefreshState)state {
    MJJRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    if (self.state == MJJRefreshStateIdle) {
        if (oldState != MJJRefreshStateRefreshing) return;
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:MJRefreshHeaderLastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset值
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            _scrollView.mj_insetT -= self.mj_h;
        } completion:^(BOOL finished) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    }
    else if (self.state == MJJRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置inset和offset值
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                _scrollView.mj_insetT = _scrollViewOriginalInset.top + self.mj_h;
                
                CGPoint offset = _scrollView.contentOffset;
                offset.y = -_scrollView.mj_insetT;
                [_scrollView setContentOffset:offset animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

- (NSDate *)lastUpdatedTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

@end
