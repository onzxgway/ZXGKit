//
//  NewRefreshComponent.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshComponent.h"

@implementation NewRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor redColor];
    self.state = NRRefreshStateIdle;
}

// 控件本身以及子控件的 位置和尺寸 调整。
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self placeSubViews];
}

- (void)placeSubViews {
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (!newSuperview || ![newSuperview isKindOfClass:UIScrollView.class]) return;
    
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    UIScrollView *scrollView = (UIScrollView *)newSuperview;
    self.scrollView = scrollView;
    self.originalInsets = scrollView.contentInset;
    
    NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:option context:nil];
    [self.scrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:option context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:option context:nil];
    
    self.nr_x = self.scrollView.bounds.origin.x;
    self.nr_w = self.scrollView.bounds.size.width;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        [self scrollViewDidChanged:[change objectForKey:NSKeyValueChangeNewKey]];
        
    }
    
    if ([keyPath isEqualToString:@"state"]) {
        
        [self scrollViewGestureStateDidChanged:[change objectForKey:NSKeyValueChangeNewKey]];
        
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        [self scrollViewSizeDidChanged:[change objectForKey:NSKeyValueChangeNewKey]];
        
    }
    
}

- (void)scrollViewDidChanged:(NSValue *)contentOffset {
    
}

- (void)scrollViewGestureStateDidChanged:(NSNumber *)state {
    
}

- (void)scrollViewSizeDidChanged:(NSValue *)contentSize {
    
}

+ (instancetype)refreshWithBlock:(RefreshBlock)refreshBlock {
    
    NewRefreshComponent *com = [[self alloc] init];
    com.refreshBlock = refreshBlock;
    return com;
    
}

- (void)beginRefresh {
    
    if(self.refreshBlock) self.refreshBlock();
    
}

- (void)endRefresh {
    self.state = NRRefreshStateIdle;
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"time"];
}

- (void)setState:(NRRefreshState)state {
    _state = state;
    
    
}

@end


@implementation UILabel (Refresh)

- (CGFloat)textWidth {
    
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    
}

@end
