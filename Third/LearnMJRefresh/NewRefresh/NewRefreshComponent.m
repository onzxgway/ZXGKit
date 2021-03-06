//
//  NewRefreshComponent.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshComponent.h"

@interface NewRefreshComponent ()

@property (strong, nonatomic) UIPanGestureRecognizer *pan; // 记录拖拽手势

@end

@implementation NewRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubViews];
        
        self.state = NRRefreshStateIdle;
    }
    return self;
}

- (void)addSubViews {
    
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor redColor];
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
    
    //
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
    [self.pan removeObserver:self forKeyPath:@"state"];
    self.pan = nil;
    
    
    _scrollView = (UIScrollView *)newSuperview;
    self.originalInsets = _scrollView.nr_inset;
    
    //
    NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:option context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:option context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:@"state" options:option context:nil];
    
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

- (void)scrollViewDidChanged:(NSValue *)contentOffset {}
- (void)scrollViewGestureStateDidChanged:(NSNumber *)state {}
- (void)scrollViewSizeDidChanged:(NSValue *)contentSize {}


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

@end


@implementation UILabel (Refresh)

- (CGFloat)textWidth {
    
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    
}

@end
