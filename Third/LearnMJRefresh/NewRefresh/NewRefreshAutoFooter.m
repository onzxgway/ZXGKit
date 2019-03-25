//
//  NewRefreshAutoFooter.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/25.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshAutoFooter.h"

@implementation NewRefreshAutoFooter

- (void)placeSubViews {
    [super placeSubViews];
    
    self.nr_y = self.scrollView.contentSize.height;

    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.bottom += self.nr_h;
//    UIEdgeInsets inset = self.originalInsets;
//    inset.bottom += self.nr_h;
    self.scrollView.contentInset = inset;
}

- (void)scrollViewDidChanged:(NSValue *)contentOffset {
    [super scrollViewDidChanged:contentOffset];
    
    CGFloat offsetY = [contentOffset CGPointValue].y;
    
    if (self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
        if (self.state != NRRefreshStateRefreshing && offsetY > (self.scrollView.contentSize.height - self.scrollView.frame.size.height + self.nr_h)) {
            self.state = NRRefreshStateRefreshing;
        }
    }
    
}

- (void)scrollViewGestureStateDidChanged:(NSNumber *)state {
    [super scrollViewGestureStateDidChanged:state];
    
    if (self.scrollView.contentSize.height < self.scrollView.frame.size.height) {
        
        CGPoint point = [self.scrollView.panGestureRecognizer translationInView:self.scrollView];
        
        if ([state integerValue] == UIGestureRecognizerStateEnded && point.y < 0 && self.state != NRRefreshStateRefreshing) {
            self.state = NRRefreshStateRefreshing;
        }
    }
    
}

- (void)scrollViewSizeDidChanged:(NSValue *)contentSize {
    [super scrollViewSizeDidChanged:contentSize];
    
    self.nr_y = [contentSize CGSizeValue].height;
}

- (void)setState:(NRRefreshState)state {
    [super setState:state];
    
    if (state == NRRefreshStateRefreshing) {
        [self beginRefresh];
    }
}

@end
