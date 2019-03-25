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

static NSString *const headerkey = @"NewRefreshHeader";
static NSString *const footerkey = @"NewRefreshFooter";

@implementation UIScrollView (Refresh)

- (void)setRefreshHeader:(NewRefreshComponent *)refreshHeader {
    if (self.refreshHeader != refreshHeader) {
        [self.refreshHeader removeFromSuperview];
        [self insertSubview:refreshHeader atIndex:0];
        
        objc_setAssociatedObject(self, &headerkey, refreshHeader, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (NewRefreshComponent *)refreshHeader {
    return objc_getAssociatedObject(self, &headerkey);
}

- (void)setRefreshFooter:(NewRefreshComponent *)refreshFooter {
    if (self.refreshFooter != refreshFooter) {
        [self.refreshFooter removeFromSuperview];
        [self insertSubview:refreshFooter atIndex:0];
        
        objc_setAssociatedObject(self, &footerkey, refreshFooter, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (NewRefreshComponent *)refreshFooter {
    return objc_getAssociatedObject(self, &footerkey);
}

@end
