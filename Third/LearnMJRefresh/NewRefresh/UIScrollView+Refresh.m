//
//  UIScrollView+Refresh.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "NewRefreshComponent.h"
#import <objc/runtime.h>

static NSString *const key = @"NewRefreshComponent";

@implementation UIScrollView (Refresh)

- (void)setRefreshView:(NewRefreshComponent *)refreshView {
    if (self.refreshView != refreshView) {
        [self.refreshView removeFromSuperview];
        [self insertSubview:refreshView atIndex:0];
        
        objc_setAssociatedObject(self, &key, refreshView, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (NewRefreshComponent *)refreshView {
    return objc_getAssociatedObject(self, &key);
}

@end
