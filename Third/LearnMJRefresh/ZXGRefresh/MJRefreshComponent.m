//
//  MJRefreshComponent.m
//  Third
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshComponent.h"

@interface MJRefreshComponent ()

@end

@implementation MJRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        
        self.state = MJJRefreshStateIdle;
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
        
        self.mj_w = _scrollView.mj_w;
        self.mj_x = 0;
        
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        [self addObserver];
    }
}

- (void)prepare {
    self.backgroundColor = kRandomColor;
}

- (void)placeSubviews {
    
}

- (void)addObserver {
    NSKeyValueObservingOptions optinos = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentOffset options:optinos context:nil];
    [_scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentSize options:optinos context:nil];
}

- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathContentOffset context:nil];
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathContentSize context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([MJRefreshKeyPathContentOffset isEqualToString:keyPath]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    else if ([MJRefreshKeyPathContentSize isEqualToString:keyPath]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {}


- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
    
    if ([self isRefreshing]) return;
    
    if (self.isAutomaticallyChangeAplha) {
        self.alpha = pullingPercent;
    }
}

- (void)setAutomaticallyChangeAlpha:(CGFloat)automaticallyChangeAlpha {
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if ([self isRefreshing]) return;
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    }
    else {
        self.alpha = 1.f;
    }
}

- (void)beginRefresh {
    self.state = MJJRefreshStateRefreshing;
}

- (void)endRefresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MJJRefreshStateIdle;
    });
}

- (void)executeRefreshingCallback {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        
        if (_refreshingTarget && [_refreshingTarget respondsToSelector:_refreshingAction]) {
            [_refreshingTarget performSelector:_refreshingAction];
        }
        
    });
}

- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
    _refreshingTarget = target;
    _refreshingAction = action;
}

- (void)setState:(MJJRefreshState)state {
    _state = state;
    
//    // 加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setNeedsLayout];
//    });
}

#pragma mark - 是否正在刷新
- (BOOL)isRefreshing {
    return self.state == MJJRefreshStateRefreshing || self.state == MJJRefreshStateWillRefresh;
}

@end


@implementation UILabel(MJRefresh)

+ (instancetype)mj_label {
    UILabel *label = [[self alloc] init];
    label.font = MJRefreshLabelFont;
    label.textColor = MJRefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (CGFloat)mj_textWith {
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    if (self.text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth =[self.text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:self.font}
                      context:nil].size.width;
#else
        
        stringWidth = [self.text sizeWithFont:self.font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    return stringWidth;
}
@end



