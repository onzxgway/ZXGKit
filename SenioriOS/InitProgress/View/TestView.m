//
//  TestView.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TestView.h"

/**
 View 的初始化过程
 */
@implementation TestView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%s", __func__);
        [self createView];
    }
    return self;
}

// 解档
/**
 self.superview == nil
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self createView];
        NSLog(@"%s", __func__);
    }
    return self;
}

/**
 self.superview == nil
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"%s", __func__);
}

// 安全的布局方法
/**
 self.superview == <UIView: 0x10be012f0; frame = (0 0; 375 812); autoresize = W+H; layer = <CALayer: 0x1c003da60>>
 
 self == <TestView: 0x10be018e0; frame = (36 106; 266 108); autoresize = W+H; layer = <CALayer: 0x1c003d8a0>>
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _count++;
    NSLog(@"%s", __func__);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"%s", __func__);
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



- (void)createView {
    self.backgroundColor = [UIColor blueColor];
    
    _count = 0;
    
    UIView *vv = [[UIView alloc] init];
    [self addSubview:vv];
    vv.backgroundColor = [UIColor redColor];
    vv.frame = CGRectMake(30, 20, 50, 50);
}

@end
