//
//  GGRefreshComponent.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshComponent.h"


static NSString *const ContentOffset = @"contentOffset";
static NSString *const ContentSize = @"contentSize";
static NSString *const PanGesture = @"state";

@interface GGRefreshComponent ()
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation GGRefreshComponent

/**
 原理：监听UIScrollView的contentOffset.y值，根据偏移量的不同，设置不同的状态，不同的状态对应不同的显示。
 
 1.观察者模式 kvo
 */
+ (instancetype)refreshWithBlock:(BeginRefresh)beginRefresh {
    GGRefreshComponent *com = [[self alloc] init];
    com.beginRefreshBlock = beginRefresh;
    return com;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        
        self.state = GGRefreshStateIdle;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self placeSubviews];
}

- (void)prepare {
    self.backgroundColor = [UIColor greenColor];
}

- (void)placeSubviews {
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 有值但不是UIScrollView
    if (newSuperview && ![newSuperview isKindOfClass:UIScrollView.class]) return;
    
    // 移除监听
    [self.superview removeObserver:self forKeyPath:ContentOffset];
    [self.superview removeObserver:self forKeyPath:ContentSize];
    [self.pan removeObserver:self forKeyPath:PanGesture];
    self.pan = nil;
    
    if (newSuperview) {
        
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _originalContentInset = _scrollView.gg_inset;
        self.gg_left = _scrollView.gg_left;
        self.gg_width = _scrollView.gg_width;
        
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        // 添加监听
        [_scrollView addObserver:self forKeyPath:ContentOffset options:options context:nil];
        [_scrollView addObserver:self forKeyPath:ContentSize options:options context:nil];
        self.pan = _scrollView.panGestureRecognizer;
        [self.pan addObserver:self forKeyPath:PanGesture options:options context:nil];
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:ContentOffset]) {
        [self scrollViewContentOffsetChanged:[change objectForKey:NSKeyValueChangeNewKey]];
    }
    else if ([keyPath isEqualToString:PanGesture]) {
        [self scrollViewPanGestureChanged:[change objectForKey:NSKeyValueChangeNewKey]];
    }
    else if ([keyPath isEqualToString:ContentSize]) {
        [self scrollViewContentSizeChanged:[change objectForKey:NSKeyValueChangeNewKey]];
    }
}

- (void)scrollViewContentOffsetChanged:(NSValue *)contentOffset {}
- (void)scrollViewContentSizeChanged:(NSValue *)contentSize {}
- (void)scrollViewPanGestureChanged:(NSNumber *)PanGestureState {}


- (void)beginRefresh {
    
    self.pullingPercent = 1.0;
    
    self.state = GGRefreshStateRefreshing;
}

- (void)endRefresh {
    self.state = GGRefreshStateIdle;
}

#pragma mark 根据拖拽进度设置透明度
- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
    
    if (self.state == GGRefreshStateRefreshing) {
        return;
    }
    
    self.alpha = _pullingPercent;
}

@end


@implementation UILabel (GGRefresh)

- (CGFloat)textWidth {
    
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    
}

@end
