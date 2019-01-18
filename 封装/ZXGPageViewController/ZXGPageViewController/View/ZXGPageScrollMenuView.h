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
- (void)pagescrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index;

/// 点击Add按钮
- (void)pagescrollMenuViewAddButtonAction:(UIButton *)button;

@end

@interface ZXGPageScrollMenuView : UIView

/// 标题数组
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;

/**
 初始化ZXGPageScrollMenuView
 
 @param frame 大小
 @param titles 标题
 @param configration 配置信息
 @param delegate 代理
 @param currentIndex 当前选中下标
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSMutableArray<NSString *> *)titles
                 configration:(ZXGPageConfigration *)configration
                     delegate:(id<ZXGPageScrollMenuViewDelegate>)delegate
                 currentIndex:(NSInteger)currentIndex NS_DESIGNATED_INITIALIZER;

- (void)adjustItemWithProgress:(CGFloat)progress
                     lastIndex:(NSInteger)lastIndex
                  currentIndex:(NSInteger)currentIndex;


@end

NS_ASSUME_NONNULL_END
