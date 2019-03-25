//
//  NewRefreshHeader.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshHeader.h"

@implementation NewRefreshHeader

- (void)placeSubViews {
    [super placeSubViews];
    
    self.nr_h = 44.f;
    self.nr_y = - self.nr_h;
}

- (void)scrollViewDidChanged:(NSValue *)contentOffset {
    [super scrollViewDidChanged:contentOffset];
    
    CGFloat offsetY = [contentOffset CGPointValue].y;
    
    CGFloat alphaP = -offsetY / self.nr_h;
    // 临界值
    CGFloat boundararyOffset = - self.nr_h - self.originalInsets.top;
    
    if (self.state == NRRefreshStateRefreshing) {
        self.alpha = 1.0f;
        return;
    }
    
    self.originalInsets = self.scrollView.contentInset;
    
    if (self.scrollView.isDragging) {
        
        if (self.state == NRRefreshStateIdle && offsetY <= boundararyOffset) {
            self.state = NRRefreshStatePulling;
        }
        else if (self.state == NRRefreshStatePulling && offsetY > boundararyOffset) {
            self.state = NRRefreshStateIdle;
        }
        
    }
    else if (self.state == NRRefreshStatePulling) {
        self.state = NRRefreshStateRefreshing;
    }
    
    self.alpha = alphaP;
}

- (void)setState:(NRRefreshState)state {
    NRRefreshState oldState = self.state;
    if (state == oldState) return; 
    [super setState:state];
    
    if (state == NRRefreshStateIdle) {
        if (oldState != NRRefreshStateRefreshing) return;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.scrollView.contentInset = self.originalInsets;
        }];
    }
    else if (state == NRRefreshStateRefreshing) {
        [UIView animateWithDuration:0.1 animations:^{
            UIEdgeInsets inset = self.originalInsets;
            inset.top += self.nr_h;
            self.scrollView.contentInset = inset;
        } completion:^(BOOL finished) {
            [self beginRefresh];
        }];
    }
    
}

@end
