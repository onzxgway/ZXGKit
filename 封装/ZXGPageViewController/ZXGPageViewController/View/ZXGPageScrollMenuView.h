//
//  ZXGPageScrollMenuView.h
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXGPageConfigration;

NS_ASSUME_NONNULL_BEGIN

@protocol ZXGPageScrollMenuViewDelegate <NSObject>

@optional

/// 点击item
- (void)menuViewItemOnClick:(UIButton *)button index:(NSInteger)index;

/// 点击Add按钮
- (void)menuViewAddButtonAction:(UIButton *)button;

@end

@interface ZXGPageScrollMenuView : UIView

/// + 按钮
@property (nonatomic, strong) UIButton *addButton;

/// 标题数组
@property (nonatomic, strong) NSArray<NSString *> *titles;

/**
 初始化ZXGPageScrollMenuView
 
 @param frame 位置大小
 @param titles 标题集合
 @param configuration 配置信息
 @param delegate 代理对象
 @param currentIndex 当前选中下标
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                configuration:(ZXGPageConfigration *)configuration
                     delegate:(id<ZXGPageScrollMenuViewDelegate> _Nullable)delegate
                 currentIndex:(NSInteger)currentIndex NS_DESIGNATED_INITIALIZER;


/**
 <#Description#>

 @param progress <#progress description#>
 @param lastIndex <#lastIndex description#>
 @param currentIndex <#currentIndex description#>
 */
- (void)adjustItemWithProgress:(CGFloat)progress
                     lastIndex:(NSInteger)lastIndex
                  currentIndex:(NSInteger)currentIndex;

- (void)adjustItemAnimate:(BOOL)animated;

- (void)adjustItemPositionWithCurrentIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
