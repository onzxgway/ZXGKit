//
//  PracticeView.m
//  Event
//
//  Created by 朱献国 on 2018/10/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "PracticeView.h"

@implementation PracticeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *v = [self.subviews firstObject];
    
    CGRect rect = v.frame;
    rect = CGRectMake(rect.origin.x - 20, rect.origin.y - 20, rect.size.width + 40, rect.size.height + 40);

    if (CGRectContainsPoint(rect, point)) {
        return v;
    }
    else {
        return [super hitTest:point withEvent:event];
    }

}

@end
