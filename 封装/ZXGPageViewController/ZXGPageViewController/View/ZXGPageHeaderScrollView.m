//
//  ZXGPageHeaderScrollView.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/2/12.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGPageHeaderScrollView.h"

@interface ZXGPageHeaderScrollView () <UIScrollViewDelegate>

@end

@implementation ZXGPageHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

@end
