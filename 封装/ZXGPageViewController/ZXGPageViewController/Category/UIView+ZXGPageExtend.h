//
//  UIView+ZXGPageExtend.h
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define ZXGPAGE_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define ZXGPAGE_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// iPhone X/XS: 375*812 (@3x)
// iPhone XS Max: 414*896 (@3x)
// iPhone XR: 414*896 (@2x)
#define kZXGPAGE_IS_IPHONE_X  ((ZXGPAGE_SCREEN_WIDTH == 375.f && ZXGPAGE_SCREEN_HEIGHT == 812.f) || (ZXGPAGE_SCREEN_WIDTH == 414.f && ZXGPAGE_SCREEN_HEIGHT == 896.f))

#define kZXGPAGE_NAVHEIGHT (kZXGPAGE_IS_IPHONE_X ? 88 : 64)

#define kZXGPAGE_TABBARHEIGHT (kZXGPAGE_IS_IPHONE_X ? 83 : 49)

@interface UIView (ZXGPageExtend)

@property (nonatomic) CGFloat zxg_x;

@property (nonatomic) CGFloat zxg_y;

@property (nonatomic) CGFloat zxg_width;

@property (nonatomic) CGFloat zxg_height;

@property (nonatomic) CGFloat zxg_bottom;

@end

NS_ASSUME_NONNULL_END
