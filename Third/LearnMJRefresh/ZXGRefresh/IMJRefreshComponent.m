//
//  IMJRefreshComponent.m
//  Third
//
//  Created by 朱献国 on 2018/5/21.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "IMJRefreshComponent.h"

@interface IMJRefreshComponent ()

@end

@implementation IMJRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        
        _state = MJRefreshStateIdle;
    }
    return self;
}

- (void)prepare {
    self.backgroundColor = kRandomColor;
}

- (void)layoutSubviews {
    [self placeSubviews];
    
    [super layoutSubviews];
}

- (void)placeSubviews {
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 父控件移除旧的监听
    [self removeObservers];
    
    if (newSuperview) {
        _scrollView = (UIScrollView *)newSuperview;
        self.mj_w = _scrollView.mj_w;
        self.mj_x = 0;//_scrollView.mj_insetL;
        
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceVertical = YES;
        
        _scrollViewOriginalInset = _scrollView.mj_inset;
        
        [self addObservers];
    }
}

//添加监听
- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentOffset options:options context:nil];
    [_scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentSize options:options context:nil];
//    [_scrollView addObserver:self forKeyPath:<#(nonnull NSString *)#> options:options context:nil];
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathContentSize];
//    [self.pan removeObserver:self forKeyPath:MJRefreshKeyPathPanState];
//    self.pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:MJRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:MJRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {}

#pragma mark - 公共方法
#pragma mark 设置回调对象和回调方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

#pragma mark 进入刷新状态
- (void)beginRefreshing {
    
    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    if (self.window) {
        self.state = MJRefreshStateRefreshing;
    }
}

- (void)endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MJRefreshStateIdle;
    });
}

#pragma mark - 内部方法
- (void)executeRefreshingCallback {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            MJRefreshMsgSend(MJRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
//        if (self.beginRefreshingCompletionBlock) {
//            self.beginRefreshingCompletionBlock();
//        }
    });
}

#pragma mark 是否正在刷新
- (BOOL)isRefreshing {
    return self.state == MJRefreshStateRefreshing || self.state == MJRefreshStateWillRefresh;
}

#pragma mark 根据拖拽进度设置透明度
- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) return;
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

#pragma mark 自动切换透明度
- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha {
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if (self.isRefreshing) return;
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    }
    else {
        self.alpha = 1.0;
    }
}

@end


@implementation UILabel(MJRefresh)
+ (instancetype)mj_label
{
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

