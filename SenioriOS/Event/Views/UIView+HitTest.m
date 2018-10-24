//
//  UIView+HitTest.m
//  Event
//
//  Created by 朱献国 on 2018/10/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "UIView+HitTest.h"

@implementation UIView (HitTest)
    
/**

 0.调用当前视图的pointInside:withEvent:方法判断触摸点是否在当前视图内；
 1.若返回NO,则hitTest:withEvent:返回nil;
 2.若返回YES,则向当前视图的所有子视图发送hitTest:withEvent:消息，所有子视图的遍历顺序是从top到bottom，即从subviews数组的末尾向前遍历,直到有子视图返回非空对象或者全部子视图遍历完毕；
 3.若第一次有子视图返回非空对象,则hitTest:withEvent:方法返回此对象，处理结束；
 4.如所有子视图都返回非，则hitTest:withEvent:方法返回自身self，处理结束；
 
 */

- (UIView *)hitTest:(CGPoint)point event:(UIEvent *)event {
    
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
        return nil;
    }

    if (![self pointInside:point withEvent:event]) {
        return nil;
    }

    NSArray *subViews = [[self.subviews reverseObjectEnumerator] allObjects];
    UIView *tempView = nil;
    for (UIView *view in subViews) {
        CGPoint pt = [self convertPoint:point toView:view];
        UIView *tempV = [view hitTest:pt event:event];
        if (tempV) {
            tempView = tempV;
            break;
        }
    }

    if (tempView) {
        return tempView;
    }
    else {
        return self;
    }

}

@end
