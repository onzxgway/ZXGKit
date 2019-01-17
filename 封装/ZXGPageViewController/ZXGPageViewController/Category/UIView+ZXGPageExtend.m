//
//  UIView+ZXGPageExtend.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "UIView+ZXGPageExtend.h"

@implementation UIView (ZXGPageExtend)

- (void)setZxg_x:(CGFloat)zxg_x {
    CGRect frame = self.frame;
    frame.origin.x = zxg_x;
    self.frame = frame;
}

- (CGFloat)zxg_x {
    return self.frame.origin.x;
}

- (void)setZxg_y:(CGFloat)zxg_y {
    CGRect frame = self.frame;
    frame.origin.y = zxg_y;
    self.frame = frame;
}

- (CGFloat)zxg_y {
    return self.frame.origin.y;
}

- (CGFloat)zxg_width {
    return self.frame.size.width;
}

- (void)setZxg_width:(CGFloat)zxg_width {
    CGRect frame = self.frame;
    frame.size.width = zxg_width;
    self.frame = frame;
}

- (CGFloat)zxg_height {
    return self.frame.size.height;
}

- (void)setZxg_height:(CGFloat)zxg_height {
    CGRect frame = self.frame;
    frame.size.height = zxg_height;
    self.frame = frame;
}

- (CGFloat)zxg_bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setZxg_bottom:(CGFloat)zxg_bottom {
    CGRect frame = self.frame;
    frame.origin.y = zxg_bottom - frame.size.height;
    self.frame = frame;
}

@end
