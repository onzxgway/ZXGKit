//
//  BannerView.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

// 解决2

//// 方式一
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//
//    CGRect frame = self.bounds;
//    frame = CGRectMake(CGRectGetMinX(frame) - 30, CGRectGetMinY(frame), CGRectGetMaxX(frame) + 60, CGRectGetHeight(frame));
//
//    return CGRectContainsPoint(frame, point);
//}

// 方式二
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//
//    UIView *targetV = nil;
//    for (UIView *v in [self.subviews.reverseObjectEnumerator allObjects]) {
//        
//        CGPoint newP = [self convertPoint:point toView:v];
//        BOOL res = [v pointInside:newP withEvent:event];
//        if (res) {
//            targetV = [v hitTest:newP withEvent:event];
//            break;
//        }
//        
//    }
//    
//    if (!targetV && [self pointInside:point withEvent:event]) {
//        targetV = self;
//    }
//    
//    return targetV;
//}


// ScrollView 对touch事件的拦截（相对于 父View）
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesMoved:touches withEvent:event];
//    [self.nextResponder touchesMoved:touches withEvent:event]; // 改方法可以让touch事件继续向 superView 方向传递。
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesCancelled:touches withEvent:event];
}

@end
