//
//  UIView+NewRefresh.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "UIView+NewRefresh.h"

@implementation UIView (NewRefresh)

- (void)setNr_x:(CGFloat)nr_x {
    
    CGRect frame = self.frame;
    
    frame.origin.x = nr_x;
    
    self.frame = frame;
}

- (CGFloat)nr_x {
    return self.frame.origin.x;
}


- (void)setNr_y:(CGFloat)nr_y {
    
    CGRect frame = self.frame;
    
    frame.origin.y = nr_y;
    
    self.frame = frame;
}

- (CGFloat)nr_y {
    return self.frame.origin.y;
}


- (void)setNr_w:(CGFloat)nr_w {
    
    CGRect frame = self.frame;
    
    frame.size.width = nr_w;
    
    self.frame = frame;
}

- (CGFloat)nr_w {
    return self.frame.size.width;
}


- (void)setNr_h:(CGFloat)nr_h {
    
    CGRect frame = self.frame;
    
    frame.size.height = nr_h;
    
    self.frame = frame;
}

- (CGFloat)nr_h {
    return self.frame.size.height;
}

@end
