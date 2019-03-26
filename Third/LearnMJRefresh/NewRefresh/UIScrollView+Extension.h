//
//  UIScrollView+Extension.h
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Extension)

@property (nonatomic, readonly) UIEdgeInsets nr_inset;

@property (nonatomic) CGFloat nr_insetT;
@property (nonatomic) CGFloat nr_insetB;
@property (nonatomic) CGFloat nr_insetR;
@property (nonatomic) CGFloat nr_insetL;

@property (nonatomic) CGFloat nr_contentH;
@property (nonatomic) CGFloat nr_contentW;

@property (nonatomic) CGFloat nr_offsetX;
@property (nonatomic) CGFloat nr_offsetY;

@end

NS_ASSUME_NONNULL_END
