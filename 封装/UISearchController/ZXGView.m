//
//  ZXGView.m
//  UISearchController
//
//  Created by onzxgway on 2019/4/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGView.h"

@implementation ZXGView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawTop:rect];
    [self drawBottom:rect];
}


- (void)drawTop:(CGRect)rect {
    
}

- (void)drawBottom:(CGRect)rect {
    
}

- (void)setProgress:(CGFloat)progress {
    
    if (_progress != progress) {
        
        
        _progress = progress;
    }
    
}

@end
