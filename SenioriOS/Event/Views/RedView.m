//
//  RedView.m
//  Event
//
//  Created by 朱献国 on 2018/10/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "RedView.h"

@implementation RedView

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
    
    self.backgroundColor = [UIColor redColor];
}
    
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    //    return [self hitTest:point event:event];
    return [super hitTest:point withEvent:event];
}
    
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    return [super pointInside:point withEvent:event];
}

@end
