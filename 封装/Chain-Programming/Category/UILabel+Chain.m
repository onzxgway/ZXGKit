//
//  UILabel+Chain.m
//  Chain-Programming
//
//  Created by 朱献国 on 2018/11/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "UILabel+Chain.h"

@implementation UILabel (Chain)

+ (UILabel *)new {
    UILabel *lab = [[UILabel alloc] init];
    return lab;
}

- (UILabel *(^)(NSString *))_text {
    return ^id(NSString *msg) {
        
        self.text = msg;
        return self;
    };
}

- (UILabel *(^)(UIColor *))_zbackgroundColor {
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UILabel *(^)(UIView *))moveTo {
    return ^id(UIView *view) {
        
        [view addSubview:self];
        self.frame = CGRectMake(44, 108, 188, 44);
        return self;
    };
}

@end
