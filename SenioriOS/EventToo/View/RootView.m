//
//  RootView.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [super hitTest:point withEvent:event];
    return v;
}

@end
