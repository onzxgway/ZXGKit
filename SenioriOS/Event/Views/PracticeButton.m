//
//  PracticeButton.m
//  Event
//
//  Created by 朱献国 on 2018/10/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "PracticeButton.h"

@implementation PracticeButton

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    CGRect rect = self.bounds;
//    rect = CGRectMake(rect.origin.x - 20, rect.origin.y - 20, rect.size.width + 40, rect.size.height + 40);
//    
//    if (CGRectContainsPoint(rect, point)) {
//        return YES;
//    }
//    else {
//        return [super pointInside:point withEvent:event];
//    }
//    
//}

// 重写该方法可以劫持target-action事件。
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [super sendAction:@selector(btnAction) to:self forEvent:event];
}

- (void)btnAction {
    NSLog(@"😆😆😆面朝大海😆😆😆");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesMoved:touches withEvent:event];
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
