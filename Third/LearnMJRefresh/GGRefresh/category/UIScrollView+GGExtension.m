//
//  UIScrollView+GGExtension.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "UIScrollView+GGExtension.h"

@implementation UIScrollView (GGExtension)

- (UIEdgeInsets)gg_inset {
    
    if (@available(iOS 11.0, *)) {
//        if (respondsToAdjustedContentInset_) {
            return self.adjustedContentInset;
//        }
//        return self.contentInset;
    }
    else {
        return self.contentInset;
    }

}

- (void)setGg_insetT:(CGFloat)gg_insetT {
    UIEdgeInsets inset = self.contentInset;
    inset.top = gg_insetT;
    if (@available(iOS 11.0, *)) {
//        if (respondsToAdjustedContentInset_) {
            inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
//        }
    }
    self.contentInset = inset;
}

- (CGFloat)gg_insetT {
    return self.contentInset.top;
}

- (void)setGg_insetB:(CGFloat)gg_insetB {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = gg_insetB;
    if (@available(iOS 11.0, *)) {
//        if (respondsToAdjustedContentInset_) {
            inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
//        }
    }
    self.contentInset = inset;
}

- (CGFloat)gg_insetB {
    return self.contentInset.bottom;
}

- (void)setGg_insetR:(CGFloat)gg_insetR {
    UIEdgeInsets inset = self.contentInset;
    inset.right = gg_insetR;
    if (@available(iOS 11.0, *)) {
//        if (respondsToAdjustedContentInset_) {
            inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
//        }
    }
    self.contentInset = inset;
}

- (CGFloat)gg_insetR {
    return self.contentInset.right;
}

- (void)setGg_insetL:(CGFloat)gg_insetL {
    UIEdgeInsets inset = self.contentInset;
    inset.left = gg_insetL;
    if (@available(iOS 11.0, *)) {
//        if (respondsToAdjustedContentInset_) {
            inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
//        }
    }
    self.contentInset = inset;
}

- (CGFloat)gg_insetL {
    return self.contentInset.left;
}



- (void)setGg_contentH:(CGFloat)gg_contentH {
    CGSize size = self.contentSize;
    size.height = gg_contentH;
    self.contentSize = size;
}

- (CGFloat)gg_contentH {
    return self.contentSize.height;
}

- (void)setGg_contentW:(CGFloat)gg_contentW {
    CGSize size = self.contentSize;
    size.width = gg_contentW;
    self.contentSize = size;
}

- (CGFloat)gg_contentW {
    return self.contentSize.width;
}

- (void)setGg_offsetX:(CGFloat)gg_offsetX {
    CGPoint point = self.contentOffset;
    point.x = gg_offsetX;
    self.contentOffset = point;
}

- (CGFloat)gg_offsetX {
    return self.contentOffset.x;
}

- (void)setGg_offsetY:(CGFloat)gg_offsetY {
    CGPoint point = self.contentOffset;
    point.y = gg_offsetY;
    self.contentOffset = point;
}

- (CGFloat)gg_offsetY {
    return self.contentOffset.y;
}


@end
