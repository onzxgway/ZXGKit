//
//  UIScrollView+MJRefresh.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/28.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import <objc/runtime.h>

static NSString *const key = @"MJRefreshHeaderKey";

@implementation UIScrollView (MJRefresh)

- (void)setMj_header:(MJRefreshHeader *)mj_header {
    if (self.mj_header != mj_header) {
        [self.mj_header removeFromSuperview];
        [self insertSubview:mj_header atIndex:0];
        
        objc_setAssociatedObject(self, &key, mj_header, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (MJRefreshHeader *)mj_header
{
    return objc_getAssociatedObject(self, &key);
}

@end
