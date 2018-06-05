//
//  OneRefreshComponent.m
//  Third
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "OneRefreshComponent.h"

@interface OneRefreshComponent ()

@end

@implementation OneRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        
        self.status = OneRefreshStatusNormal;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self placeSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObserver];
    
    if (newSuperview) {
        _scrollView = (UIScrollView *)newSuperview;
        
        self.width = _scrollView.width;
        self.left = 0;
        _originalInsets = _scrollView.contentInset;
        
        _scrollView.alwaysBounceVertical = YES;
        
        [self addObserver];
    }
    
}

// KVO
- (void)addObserver {
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_scrollView addObserver:self forKeyPath:OneRefreshObservingContentOffset options:options context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (STRING_EQUAL(OneRefreshObservingContentOffset, keyPath)) {
        [self scrollViewContentOffsetChanged:change];
    }
}

// kvo 移除不存在的观察者会crash.
- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:OneRefreshObservingContentOffset];
}


- (void)prepare {
    self.backgroundColor = kRandomColor;
}

- (void)placeSubviews {}

- (void)scrollViewContentOffsetChanged:(NSDictionary<NSKeyValueChangeKey,id> *)change {}

- (void)beginRefresh {
    self.status = OneRefreshStatusRefreshing;
}

@end
