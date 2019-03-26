//
//  GGRefreshBackFooter.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshBackFooter.h"

static NSTimeInterval const AnimationDuration = 0.5f;

#define kScrollViewH (self.scrollView.gg_height - self.originalContentInset.top - self.originalContentInset.bottom)

@implementation GGRefreshBackFooter

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentOffsetChanged:[NSValue valueWithCGPoint:CGPointZero]];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (kScrollViewH < self.scrollView.gg_contentH) {
        self.gg_top = self.scrollView.gg_contentH;
    }
    else {
        self.gg_top = self.scrollView.gg_height - self.originalContentInset.top;
    }
    
}

- (void)scrollViewContentOffsetChanged:(NSValue *)contentOffset {
    [super scrollViewContentOffsetChanged:contentOffset];
    
    // 偏移量
    CGFloat offsetY = [contentOffset CGPointValue].y;
    
    if (self.state == GGRefreshStateRefreshing) {
        return;
    }
    
    self.originalContentInset = self.scrollView.gg_inset;
    
    // 临界点
    CGFloat criticalValue = 0;
    CGFloat pullingPercent = 0;
    if (self.scrollView.gg_contentH < kScrollViewH) {
        criticalValue = - self.originalContentInset.top + self.gg_height;
        pullingPercent = MAX(0, MIN(1, (self.originalContentInset.top + offsetY) / self.gg_height));
    }
    else {
        criticalValue = (self.scrollView.gg_contentH - kScrollViewH - self.originalContentInset.top) + self.gg_height;
        pullingPercent = MAX(0, MIN(1, (offsetY - criticalValue + self.gg_height) / self.gg_height));
    }
    
    if (self.scrollView.isDragging) {
        
        self.pullingPercent = pullingPercent;
        
        if (self.state == GGRefreshStateIdle && offsetY > criticalValue) {
            self.state = GGRefreshStatePulling;
        }
        else if (self.state == GGRefreshStatePulling && offsetY <= criticalValue) {
            self.state = GGRefreshStateIdle;
        }
        
    }
    else if (self.state == GGRefreshStatePulling) {
        [self beginRefresh];
    }
    else {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeChanged:(NSValue *)contentSize {
    [super scrollViewContentSizeChanged:contentSize];
    
    if (kScrollViewH < self.scrollView.gg_contentH) {
        self.gg_top = self.scrollView.gg_contentH;
    }
    else {
        self.gg_top = self.scrollView.gg_height - self.originalContentInset.top;
    }
    
}

- (void)setState:(GGRefreshState)state {
    GGRefreshState oldState = self.state;
    if (oldState == state) return;
    [super setState:state];
    
    if (state == GGRefreshStateIdle) {
        if (oldState != GGRefreshStateRefreshing) {
            return;
        }
        
        // 保存刷新时间
//        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastUpdatedTimeKey"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [UIView animateWithDuration:AnimationDuration * 0.5 animations:^{
            self.scrollView.gg_insetB = self.originalContentInset.bottom;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
        }];
    }
    else if (state == GGRefreshStateRefreshing) {
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            if (self.scrollView.gg_contentH < kScrollViewH) {
                CGFloat mar = kScrollViewH - self.scrollView.gg_contentH;
                self.scrollView.gg_insetB = self.originalContentInset.bottom + self.gg_height + mar;
            }
            else {
                self.scrollView.gg_insetB = self.originalContentInset.bottom + self.gg_height;
            }
            
        } completion:^(BOOL finished) {
            if (self.beginRefreshBlock) {
                self.beginRefreshBlock();
            }
        }];
        
    }
}

@end
