//
//  UIScrollView+GGRefresh.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "UIScrollView+GGRefresh.h"
#import <objc/runtime.h>

static NSString *const headerRefreshKey = @"gg_headerRefresh";
static NSString *const footerRefreshKey = @"gg_footerRefresh";

@implementation UIScrollView (GGRefresh)

- (void)setGg_headerRefresh:(GGRefreshComponent *)gg_headerRefresh {
    if (self.gg_headerRefresh == gg_headerRefresh) return;
    [self.gg_headerRefresh removeFromSuperview];
    
    [self insertSubview:gg_headerRefresh atIndex:0];
    objc_setAssociatedObject(self, &headerRefreshKey, gg_headerRefresh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (GGRefreshComponent *)gg_headerRefresh {
    
    return objc_getAssociatedObject(self, &headerRefreshKey);
    
}

- (void)setGg_footerRefresh:(GGRefreshComponent *)gg_footerRefresh {
    if (self.gg_footerRefresh == gg_footerRefresh) return;
    [self.gg_footerRefresh removeFromSuperview];
    
    [self insertSubview:gg_footerRefresh atIndex:0];
    objc_setAssociatedObject(self, &footerRefreshKey, gg_footerRefresh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (GGRefreshComponent *)gg_footerRefresh {
    
    return objc_getAssociatedObject(self, &footerRefreshKey);
    
}

@end
