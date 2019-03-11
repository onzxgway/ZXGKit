//
//  CustomScrollView.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2019/3/11.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CustomScrollView.h"

/**
 自己创建一个ScrollView,继承自UIView.功能类似于UIScrollView.
 目的： 了解UIScrollView的底层实现原理。
 */

@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        [self addGestureRecognizer:pan];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)panGes:(UIPanGestureRecognizer *)panGes {
    
    CGRect tmpBound = self.bounds;
    
    CGPoint p = [panGes translationInView:self];
    
    // 设置ContentSize
    {
        CGFloat minimumOffset = 0.f;
        CGFloat maximumOffset = _contentSize.width - self.bounds.size.width;
        CGFloat actualOffset = fmax(minimumOffset, fmin(maximumOffset, (self.bounds.origin.x - p.x)));
        tmpBound.origin.x = actualOffset;
    }
    {
        CGFloat minimumOffset = 0.f;
        CGFloat maximumOffset = _contentSize.height - self.bounds.size.height;
        CGFloat actualOffset = fmax(minimumOffset, fmin(maximumOffset, (self.bounds.origin.y - p.y)));
        tmpBound.origin.y = actualOffset;
    }
    
    [panGes setTranslation:CGPointZero inView:self];
    
    self.bounds = tmpBound;
    
}

@end
