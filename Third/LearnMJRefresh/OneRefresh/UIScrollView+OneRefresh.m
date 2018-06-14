//
//  UIScrollView+OneRefresh.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/9.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "UIScrollView+OneRefresh.h"
#import <objc/message.h>

@implementation UIScrollView (OneRefresh)

static const char RefreshHeaderKey = '\0';

- (void)setOne_Refresh:(OneRefreshHeader *)one_Refresh {
    if (self.one_Refresh != one_Refresh) {
        [self.one_Refresh removeFromSuperview];
        [self insertSubview:one_Refresh atIndex:0];
        
        [self willChangeValueForKey:@"one_Refresh"];
        objc_setAssociatedObject(self, &RefreshHeaderKey, one_Refresh, OBJC_ASSOCIATION_RETAIN);
        [self didChangeValueForKey:@"one_Refresh"];
    }
}

- (OneRefreshHeader *)one_Refresh {
    return objc_getAssociatedObject(self, &RefreshHeaderKey);
}

@end
