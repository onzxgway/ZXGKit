//
//  ZXGPageViewController.h
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/2/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGPageConfigration.h"
#import "XGPageScrollMenuView.h"

NS_ASSUME_NONNULL_BEGIN

@class ZXGPageViewController;

@protocol ZXGPageViewControllerDataSource <NSObject>
@required

/**
 根据 index 取 数据源 ScrollView
 
 @param pageViewController PageVC
 @param index pageIndex
 @return 数据源
 */
//- (__kindof UIScrollView *)pageViewController:(ZXGPageViewController *)pageViewController
//                                 pageForIndex:(NSInteger )index;


@optional


/**
 取得ScrollView(列表)的高度 默认是控制器的高度 可用于自定义底部按钮(订单、确认按钮)等控件
 
 @param pageViewController PageVC
 @param index pageIndex
 @return ScrollView高度
 */
//- (CGFloat)pageViewController:(ZXGPageViewController *)pageViewController heightForScrollViewAtIndex:(NSInteger )index;

/**
 自定义缓存Key 如果不实现，则不允许相同的菜单栏title
 如果对页面进行了添加、删除、调整顺序、请一起调整传递进来的数据源，防止缓存Key取错
 @param pageViewController pageViewController
 @param index pageIndex
 @return 唯一标识 (一般是后台ID)
 */
- (NSString *)pageViewController:(ZXGPageViewController *)pageViewController
          customCacheKeyForIndex:(NSInteger )index;

@end


@interface ZXGPageViewController : UIViewController

// 配置信息
@property (nonatomic, strong) XGPageConfigration *config;
// 控制器数组
@property (nonatomic, strong) NSArray<UIViewController *> *controllers;

// 标题数组 默认 缓存 key 为 title 可通过数据源代理 进行替换
@property (nonatomic, strong) NSArray<NSString *> *titles;


// 数据源
@property (nonatomic, weak) id<ZXGPageViewControllerDataSource> dataSource;
// 当前页面索引
@property (nonatomic) NSInteger pageIndex;
// 头部headerView
@property (nonatomic, strong) UIView *headerView;
// 菜单栏
@property (nonatomic, strong) XGPageScrollMenuView *scrollMenuView;



#pragma mark - initialize
/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray<UIViewController *> *)controllers
                                           titles:(NSArray<NSString *> *)titles
                                           config:(XGPageConfigration *)config;
/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
- (instancetype)initPageViewControllerWithControllers:(NSArray<UIViewController *> *)controllers
                                               titles:(NSArray<NSString *> *)titles
                                               config:(XGPageConfigration *)config NS_DESIGNATED_INITIALIZER;


@end

NS_ASSUME_NONNULL_END
