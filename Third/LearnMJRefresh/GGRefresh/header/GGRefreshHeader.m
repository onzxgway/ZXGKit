//
//  GGRefreshHeader.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshHeader.h"

static CGFloat const HeaderHeight = 44.f;
static NSTimeInterval const AnimationDuration = 0.5f;

@implementation GGRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.gg_height = HeaderHeight;
    self.gg_bottom = self.scrollView.gg_top;
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
    CGFloat criticalValue = -self.gg_height - self.originalContentInset.top;
    
    
    CGFloat pullingPercent = MAX(0, MIN(1, -(self.originalContentInset.top + offsetY) / self.gg_height));
    
    if (self.scrollView.isDragging) {
        
        self.pullingPercent = pullingPercent;
        
        if (self.state == GGRefreshStateIdle && offsetY <= criticalValue) {
            self.state = GGRefreshStatePulling;
        }
        else if (self.state == GGRefreshStatePulling && offsetY > criticalValue) {
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

- (void)setState:(GGRefreshState)state {
    GGRefreshState oldState = self.state;
    if (oldState == state) return;
    [super setState:state];
    
    if (state == GGRefreshStateIdle) {
        if (oldState != GGRefreshStateRefreshing) {
            return;
        }
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastUpdatedTimeKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [UIView animateWithDuration:AnimationDuration * 0.5 animations:^{
            self.scrollView.gg_insetT = self.originalContentInset.top;
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (state == GGRefreshStateRefreshing) {
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            self.scrollView.gg_insetT = self.originalContentInset.top + self.gg_height;
        } completion:^(BOOL finished) {
            if (self.beginRefreshBlock) {
                self.beginRefreshBlock();
            }
        }];
        
    }
}

@end
