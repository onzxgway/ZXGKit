//
//  UIScrollView+Extension.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "UIScrollView+Extension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (Extension)

static BOOL respondsToAdjustedContentInset_;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self instancesRespondToSelector:@selector(adjustedContentInset)];
    });
}

- (UIEdgeInsets)nr_inset {
    
    if (@available(iOS 11.0, *)) {
        if (respondsToAdjustedContentInset_) {
            return self.adjustedContentInset;
        }
        return self.contentInset;
    }
    else {
        return self.contentInset;
    }

}

- (void)setNr_insetT:(CGFloat)nr_insetT {
    UIEdgeInsets inset = self.contentInset;
    inset.top = nr_insetT;
    if (@available(iOS 11.0, *)) {
        if (respondsToAdjustedContentInset_) {
            inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
        }
    }
    self.contentInset = inset;
}

- (CGFloat)nr_insetT {
    return self.contentInset.top;
}

- (void)setNr_insetB:(CGFloat)nr_insetB {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = nr_insetB;
    if (@available(iOS 11.0, *)) {
        if (respondsToAdjustedContentInset_) {
            inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
        }
    }
    self.contentInset = inset;
}

- (CGFloat)nr_insetB {
    return self.contentInset.bottom;
}

- (void)setNr_insetR:(CGFloat)nr_insetR {
    UIEdgeInsets inset = self.contentInset;
    inset.right = nr_insetR;
    if (@available(iOS 11.0, *)) {
        if (respondsToAdjustedContentInset_) {
            inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
        }
    }
    self.contentInset = inset;
}

- (CGFloat)nr_insetR {
    return self.contentInset.right;
}

- (void)setNr_insetL:(CGFloat)nr_insetL {
    UIEdgeInsets inset = self.contentInset;
    inset.left = nr_insetL;
    if (@available(iOS 11.0, *)) {
        if (respondsToAdjustedContentInset_) {
            inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
        }
    }
    self.contentInset = inset;
}

- (CGFloat)nr_insetL {
    return self.contentInset.left;
}


- (void)setNr_contentH:(CGFloat)nr_contentH {
    CGSize size = self.contentSize;
    size.height = nr_contentH;
    self.contentSize = size;
}

- (CGFloat)nr_contentH {
    return self.contentSize.height;
}

- (void)setNr_contentW:(CGFloat)nr_contentW {
    CGSize size = self.contentSize;
    size.width = nr_contentW;
    self.contentSize = size;
}

- (CGFloat)nr_contentW {
    return self.contentSize.width;
}

- (void)setNr_offsetX:(CGFloat)nr_offsetX {
    CGPoint point = self.contentOffset;
    point.x = nr_offsetX;
    self.contentOffset = point;
}

- (CGFloat)nr_offsetX {
    return self.contentOffset.x;
}

- (void)setNr_offsetY:(CGFloat)nr_offsetY {
    CGPoint point = self.contentOffset;
    point.y = nr_offsetY;
    self.contentOffset = point;
}

- (CGFloat)nr_offsetY {
    return self.contentOffset.y;
}

@end

#pragma clang diagnostic pop
