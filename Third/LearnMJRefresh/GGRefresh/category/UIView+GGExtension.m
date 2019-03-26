//
//  UIView+GGExtension.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "UIView+GGExtension.h"

@implementation UIView (GGExtension)

- (void)setGg_left:(CGFloat)gg_left {
    
    CGRect frame = self.frame;
    frame.origin.x = gg_left;
    self.frame = frame;
    
}

- (CGFloat)gg_left {
    return self.frame.origin.x;
}

- (void)setGg_right:(CGFloat)gg_right {
    
    CGRect frame = self.frame;
    frame.origin.x = gg_right - frame.size.width;
    self.frame = frame;
    
}

- (CGFloat)gg_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setGg_top:(CGFloat)gg_top {
    
    CGRect frame = self.frame;
    frame.origin.y = gg_top;
    self.frame = frame;
    
}

- (CGFloat)gg_top {
    return self.frame.origin.y;
}

- (void)setGg_bottom:(CGFloat)gg_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = gg_bottom - frame.size.height;
    self.frame = frame;
    
}

- (CGFloat)gg_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setGg_width:(CGFloat)gg_width {
    
    CGRect frame = self.frame;
    frame.size.width = gg_width;
    self.frame = frame;
    
}

- (CGFloat)gg_width {
    return self.frame.size.width;
}

- (void)setGg_height:(CGFloat)gg_height {
    
    CGRect frame = self.frame;
    frame.size.height = gg_height;
    self.frame = frame;
    
}

- (CGFloat)gg_height {
    return self.frame.size.height;
}

- (void)setGg_size:(CGSize)gg_size {
    CGRect frame = self.frame;
    frame.size = gg_size;
    self.frame = frame;
}

- (CGSize)gg_size {
    return self.frame.size;
}

- (void)setGg_origin:(CGPoint)gg_origin {
    CGRect frame = self.frame;
    frame.origin = gg_origin;
    self.frame = frame;
}

- (CGPoint)gg_origin {
    return self.frame.origin;
}

@end
