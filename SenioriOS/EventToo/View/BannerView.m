//
//  BannerView.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    
    CGRect frame = self.bounds;
    newF = CGRectMake();
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//
//    UIView *targetV = nil;
//    for (UIView *subView in [self.subviews.reverseObjectEnumerator allObjects]) {
//
//        CGPoint newP = [self convertPoint:point toView:subView];
//        BOOL res = [subView pointInside:newP withEvent:event];
//        if (res) {
//            targetV = [subView hitTest:newP withEvent:event];
//            break;
//        }
//    }
//
//    if (targetV == nil && [self pointInside:point withEvent:event]) {
//        targetV = self;
//    }
//
//    return targetV;
//}

@end
