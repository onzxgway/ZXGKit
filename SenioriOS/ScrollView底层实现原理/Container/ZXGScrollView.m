//
//  ZXGScrollView.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGScrollView.h"

@interface ZXGScrollView () <UIGestureRecognizerDelegate>


@end

@implementation ZXGScrollView

/**
  一： 自定义一个 ZXGScrollView 继承自 UIView，高仿 UIScrollView 的功能。
 */

// UIScrollView底层原理： 根据 View 上的拖拽手势，可以获取手势滑动的方向和距离，由此改变 View.bounds.origin 即可实现，滑动效果。

/**
 
 UIScrollView 默认
 
    clipsToBounds = YES;
 
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        panGes.cancelsTouchesInView = NO;
        panGes.delegate = self;
        [self addGestureRecognizer:panGes];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)panGes:(UIPanGestureRecognizer *)panGes {

    CGPoint p = [panGes translationInView:self];
//    NSLog(@"+++___%@___+++", NSStringFromCGPoint(p));
    CGRect bounds = self.bounds;

    // 设置ContentSize
    {
        CGFloat minimumOffset = 0.f;
        CGFloat maximumOffset = _contentSize.width - bounds.size.width;
        CGFloat actualOffset = fmax(minimumOffset, fmin(maximumOffset, (bounds.origin.x - p.x)));
        bounds.origin.x = actualOffset;
    }
    {
        CGFloat minimumOffset = 0.f;
        CGFloat maximumOffset = _contentSize.height - bounds.size.height;
        CGFloat actualOffset = fmax(minimumOffset, fmin(maximumOffset, (bounds.origin.y - p.y)));
        bounds.origin.y = actualOffset;
    }
    
//    bounds.origin.x -= p.x;
//    bounds.origin.y -= p.y;

    [panGes setTranslation:CGPointZero inView:self];
    self.bounds = bounds;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//
//    return YES;
//}
//
/**
 模拟 系统的 效果。
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {

    if (self.bounds.origin.x == self.contentSize.width - self.frame.size.width) {
        // 往左滑动
        CGPoint transitionPoint = [gestureRecognizer translationInView:self];
        if (transitionPoint.x < 0) {
            return NO;
        }
        return YES;
    }
    return YES;
    
}


@end
