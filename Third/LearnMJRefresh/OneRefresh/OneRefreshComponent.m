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

- (void)executeRefreshingCallback {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_target && [_target respondsToSelector:_action]) {
            [_target performSelector:_action];
        }
        
        if (_beginRefreshingCallback) {
            _beginRefreshingCallback();
        }
    });
    
}

- (void)prepare {
    self.backgroundColor = kRandomColor;
}

- (void)placeSubviews {}

- (void)scrollViewContentOffsetChanged:(NSDictionary<NSKeyValueChangeKey,id> *)change {}

- (void)beginRefresh {
    self.status = OneRefreshStatusRefreshing;
}

- (void)endRefresh {
    self.status = OneRefreshStatusNormal;
}

- (void)setTarget:(id)target sel:(SEL)action {
    _target = target;
    _action = action;
}

- (void)setAlphaPercent:(CGFloat)alphaPercent {
    _alphaPercent = alphaPercent;
    
    if (_status == OneRefreshStatusRefreshing) return;
    
    self.alpha = alphaPercent;
}

@end


@implementation UILabel (OneRefresh)

+ (instancetype)oneRefreshLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = OneRefreshLabelFont;
    label.textColor = OneRefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = kClearColor;
    return label;
}

- (CGFloat)textWidth {
    
    CGSize size = CGSizeMake(CGFLOAT_MAX, MAXFLOAT);
    if (self.text.length > 0) {
        return [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
    }
    
    return 0;
}

@end




