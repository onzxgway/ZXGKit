//
//  ZXGView.m
//  KnowledgePoint
//
//  Created by 朱献国 on 10/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "ZXGView.h"

@implementation ZXGView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

//通过遍历，从当时的UIView的父视图开始遍历，一层一层的遍历， 如果这个父视图的响应者是UIViewController类就返回UIViewController的对象。
//响应链方法：得到此view所在的Controller
//方法一
- (UIViewController*)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//方法二
- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

@end
