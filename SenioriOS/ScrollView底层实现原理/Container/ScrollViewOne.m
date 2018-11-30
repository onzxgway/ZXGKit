//
//  ScrollViewOne.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ScrollViewOne.h"

@implementation ScrollViewOne

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
//                for (int i = 0; i < 2; i++) {
//        
//                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
//                    view.backgroundColor = [UIColor greenColor];
//                    [self addSubview:view];
//        
//                }
    }
    
    return self;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"oneView touchBegan ");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"oneView touchesMoved");
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"oneView touchesEnded");
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"oneView touchesCancelled");
    [super touchesCancelled:touches withEvent:event];
}

@end
