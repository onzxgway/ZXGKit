//
//  GGRefreshAutoFooter.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshAutoFooter.h"

@implementation GGRefreshAutoFooter

- (void)placeSubviews {
    [super placeSubviews];
    
    self.gg_top = self.scrollView.gg_contentH;
    
    self.scrollView.gg_insetB = self.originalContentInset.bottom + self.gg_height;
}

- (void)scrollViewPanGestureChanged:(NSNumber *)PanGestureState {
    [super scrollViewPanGestureChanged:PanGestureState];
    
    if (@available(iOS 11.0, *)) {
        if (self.scrollView.gg_contentH >= (self.scrollView.gg_height - self.scrollView.adjustedContentInset.top - self.scrollView.adjustedContentInset.bottom)) {
            return;
        }
    } else {
        if (self.scrollView.gg_contentH >= self.scrollView.gg_height) {
            return;
        }
    }
    
    CGPoint point = [self.scrollView.panGestureRecognizer translationInView:self.scrollView];
    
    if (point.y < 0 && [PanGestureState integerValue] == UIGestureRecognizerStateEnded && self.state == GGRefreshStateIdle) {
        [self beginRefresh];
    }
    
}

- (void)scrollViewContentSizeChanged:(NSValue *)contentSize {
    [super scrollViewContentSizeChanged:contentSize];
    
    self.gg_top = self.scrollView.gg_contentH;
}

- (void)scrollViewContentOffsetChanged:(NSValue *)contentOffset {
    [super scrollViewContentOffsetChanged:contentOffset];
    
    if (@available(iOS 11.0, *)) {
        if (self.scrollView.gg_contentH < (self.scrollView.gg_height - self.scrollView.adjustedContentInset.top - self.scrollView.adjustedContentInset.bottom)) {
            return;
        }
    }
    else {
        if (self.scrollView.gg_contentH < self.scrollView.gg_height) {
            return;
        }
    }
    
    // 偏移量
    CGFloat offsetY = [contentOffset CGPointValue].y;
    
    if (self.state == GGRefreshStateRefreshing) {
        return;
    }
    
    self.originalContentInset = self.scrollView.gg_inset;
    
    // 临界点
    CGFloat criticalValue = (self.scrollView.gg_contentH - self.scrollView.gg_height) + self.gg_height;
    
    if (self.scrollView.isDragging) {
        
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

}

- (void)setState:(GGRefreshState)state {
    GGRefreshState oldState = self.state;
    if (oldState == state) return;
    [super setState:state];
    
    if (state == GGRefreshStateRefreshing) {
        if (self.beginRefreshBlock) {
            self.beginRefreshBlock();
        }
    }
}

@end
