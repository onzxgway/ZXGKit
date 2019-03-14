//
//  GrayView.m
//  Event
//
//  Created by 朱献国 on 2018/10/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "GrayView.h"

@implementation GrayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
    
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self createView];
    }
    return self;
}
    
- (void)createView {
    
    self.backgroundColor = [UIColor grayColor];
}
    
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
//    return [self hitTest:point event:event];
//    return self.subviews[0];
//    return [self hitTest:point event:event];
//    return [super hitTest:point withEvent:event];
    
    if (self.alpha <= 0.01 || self.hidden || !self.userInteractionEnabled) {
        return nil;
    }
    
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    UIView *targetV = nil;
    for (UIView *subView in [self.subviews.reverseObjectEnumerator allObjects]) {
        
        CGPoint newP = [self convertPoint:point toView:subView];
        
        BOOL res = [subView pointInside:newP withEvent:event];
        if (res) {
            targetV = [subView hitTest:newP withEvent:event];
            break;
        }
    }
    
    if (targetV == nil && [self pointInside:point withEvent:event]) {
        targetV = self;
    }
    
    return targetV;
}

// point is in the receiver's coordinate system.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    const BOOL res = [super pointInside:point withEvent:event];
    return res;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesCancelled:touches withEvent:event];
//}

@end
