//
//  OneRefreshHeader.m
//  Third
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "OneRefreshHeader.h"

@interface OneRefreshHeader ()

@end

@implementation OneRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.height = OneRefreshHeaderHeight;
    self.top = - OneRefreshHeaderHeight;
}

- (void)scrollViewContentOffsetChanged:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    [super scrollViewContentOffsetChanged:change];
    
    if (self.status == OneRefreshStatusRefreshing) {
        return;
    }
    
    //监听偏移量设置不同状态
    CGFloat offsetY = _scrollView.contentOffset.y;  //当前偏移量
    
    CGFloat happenOffsetY = -_originalInsets.top;    //刚好出现的偏移量
    
    if (offsetY > happenOffsetY) return;
    
    CGFloat normal2Pulling = happenOffsetY - self.height; //临界偏移量
    CGFloat alphaPercent = (happenOffsetY - offsetY) / self.height;
    
    if (_scrollView.isDragging) {
        self.alphaPercent = alphaPercent;
        
        if (offsetY < normal2Pulling && self.status == OneRefreshStatusNormal) {
            self.status = OneRefreshStatusPulling;
        }
        else if (offsetY >= normal2Pulling && self.status == OneRefreshStatusPulling) {
            self.status = OneRefreshStatusNormal;
        }
    }
    else if (self.status == OneRefreshStatusPulling) {
        // 开始刷新
        [self beginRefresh];
    }
    else if (self.alpha < 1) {
        self.alphaPercent = alphaPercent;
    }
}

- (void)setStatus:(OneRefreshStatus)status {
    OneRefreshStatus oldStatus = self.status;
    if (status == oldStatus) return;
    [super setStatus:status];
    
    if (status == OneRefreshStatusRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:OneRefreshFastDuration animations:^{
                
                UIEdgeInsets inset = _originalInsets;
                inset.top += self.height;
                _scrollView.contentInset = inset;
                
                CGPoint offset = _scrollView.contentOffset;
                offset.y = -_scrollView.contentInset.top;
//                _scrollView.contentOffset = curOffset;  这种方法设置无效
                [_scrollView setContentOffset:offset animated:NO];
            } completion:^(BOOL finished) {
                // 刷新回调
                [self executeRefreshingCallback];
            }];
        });
    }
    else if (status == OneRefreshStatusNormal) {
        if (oldStatus != OneRefreshStatusRefreshing) return;
        
        [UIView animateWithDuration:OneRefreshSlowDuration animations:^{
            
            _scrollView.contentInset = _originalInsets;
            
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.alphaPercent = 0;
        }];
    }
}

@end
