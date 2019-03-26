//
//  UIView+GGExtension.h
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GGExtension)

@property (nonatomic) CGFloat gg_left;
@property (nonatomic) CGFloat gg_top;
@property (nonatomic) CGFloat gg_right;
@property (nonatomic) CGFloat gg_bottom;
@property (nonatomic) CGFloat gg_width;
@property (nonatomic) CGFloat gg_height;
@property (nonatomic) CGSize gg_size;
@property (nonatomic) CGPoint gg_origin;

@end

NS_ASSUME_NONNULL_END
