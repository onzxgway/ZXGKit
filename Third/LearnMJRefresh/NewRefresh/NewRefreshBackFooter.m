//
//  NewRefreshBackFooter.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/25.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshBackFooter.h"

@implementation NewRefreshBackFooter

- (void)placeSubViews {
    [super placeSubViews];
    
    if (self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
        self.nr_y = self.scrollView.contentSize.height;
    }
    else {
        self.nr_y = self.scrollView.frame.size.height;
    }
}

- (void)scrollViewDidChanged:(NSValue *)contentOffset {
    [super scrollViewDidChanged:contentOffset];
    
    CGFloat offsetY = [contentOffset CGPointValue].y;
    CGFloat criticalY = 0.f;
    
    if (self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
        criticalY = self.scrollView.contentSize.height - self.scrollView.frame.size.height + self.nr_h;
    }
    else {
        criticalY = self.nr_h;
    }
    
    if (self.scrollView.isDragging) {
        
        if (self.state == NRRefreshStateIdle && offsetY >= criticalY) {
            self.state = NRRefreshStatePulling;
        }
        
        if (self.state == NRRefreshStatePulling && offsetY < criticalY) {
            self.state = NRRefreshStateIdle;
        }
        
    }
    else if (self.state == NRRefreshStatePulling) {
        self.state = NRRefreshStateRefreshing;
    }
    
}

- (void)scrollViewSizeDidChanged:(NSValue *)contentSize {
    [super scrollViewSizeDidChanged:contentSize];
    
    if (self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
        
        self.nr_y = self.scrollView.contentSize.height;
        
    } else {
        
        self.nr_y = self.scrollView.frame.size.height;
        
    }
}


- (void)setState:(NRRefreshState)state {
    [super setState:state];
    
    if (state == NRRefreshStateRefreshing) {
        [UIView animateWithDuration:0.1 animations:^{
            UIEdgeInsets inset = self.scrollView.contentInset;
            if (self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
                inset.bottom += self.nr_h;
            }
            else {
                inset.bottom += (self.scrollView.frame.size.height - self.scrollView.contentSize.height + self.nr_h);
            }
            self.scrollView.contentInset = inset;
        } completion:^(BOOL finished) {
            [self beginRefresh];
        }];
    }
    
    if (state == NRRefreshStateIdle) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.scrollView.contentInset = self.originalInsets;
        } completion:nil];
    }
    
    if (state == NRRefreshStatePulling) {
        
    }
    
}

@end
