//
//  UIScrollView+GGExtension.h
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (GGExtension)

@property (nonatomic, readonly) UIEdgeInsets gg_inset;

@property (nonatomic) CGFloat gg_insetT;
@property (nonatomic) CGFloat gg_insetB;
@property (nonatomic) CGFloat gg_insetR;
@property (nonatomic) CGFloat gg_insetL;

@property (nonatomic) CGFloat gg_contentH;
@property (nonatomic) CGFloat gg_contentW;

@property (nonatomic) CGFloat gg_offsetX;
@property (nonatomic) CGFloat gg_offsetY;

@end

NS_ASSUME_NONNULL_END
