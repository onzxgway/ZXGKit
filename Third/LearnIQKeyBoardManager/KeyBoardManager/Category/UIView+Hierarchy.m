//
//  UIView+Hierarchy.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/20.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "UIView+Hierarchy.h"

@implementation UIView (Hierarchy)

- (UIViewController *)viewContainingController {
    UIResponder *nextResponder = self;
    do {
        nextResponder = [nextResponder nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController *)nextResponder;
        
    } while (nextResponder);
    
    return nil;
}

- (UIViewController *)topMostController {
    
    NSMutableArray<UIViewController *> *controllersHierarchy = [NSMutableArray array];
    
    UIViewController *topViewController = self.window.rootViewController;
    if(topViewController) [controllersHierarchy addObject:topViewController];
    
    while ([topViewController presentedViewController]) {
        topViewController = [topViewController presentedViewController];
        [controllersHierarchy addObject:topViewController];
    }
    
    UIViewController *matchController = [self viewContainingController];
    while (matchController && [controllersHierarchy containsObject:matchController] == NO) {
        do {
            matchController = (UIViewController *)[matchController nextResponder];
        } while (matchController && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    
    return matchController;
}

- (UIScrollView*)superScrollView {
    UIView *superview = self.superview;
    
    while (superview) {
        if ([superview isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)superview;
        }
        else
            superview = superview.superview;
    }
    return nil;
}

@end
