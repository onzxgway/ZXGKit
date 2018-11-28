//
//  UILabel+Chain.h
//  Chain-Programming
//
//  Created by 朱献国 on 2018/11/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Chain)

+ (UILabel *)new;

- (UILabel *(^)(NSString *))_text;

- (UILabel *(^)(UIColor *))_zbackgroundColor;

- (UILabel *(^)(UIView *))moveTo;

@end

NS_ASSUME_NONNULL_END
