//
//  ZXGPageConfigration.h
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ZXGPage样式
 
 - YNPageStyleTop: MenuView在顶部
 - YNPageStyleNavigation: MenuView在系统导航条
 - YNPageStyleSuspensionTop: MenuView悬浮，刷新控件在HeaderView顶部
 - YNPageStyleSuspensionCenter: MenuView悬浮，刷新控件在HeaderView底部
 - YNPageStyleSuspensionTopPause: MenuView悬浮，刷新控件在HeaderView顶部 停顿 类似QQ联系人页面
 SuspensionTopPause 需要继承YNPageTableView或YNPageCollectionView 实现那个手势 YES,如果有自己的集成体系，则单独实现那个方法
 */
typedef NS_ENUM(NSInteger, ZXGPageStyle) {
    ZXGPageStyleTop = 0,
    ZXGPageStyleNavigation = 1,
    ZXGPageStyleSuspensionTop = 2,
    ZXGPageStyleSuspensionCenter = 3,
    ZXGPageStyleSuspensionTopPause = 4,
};


@interface ZXGPageConfigration : NSObject

#pragma mark - YNPage Config
/** 是否显示导航条 YES */
@property (nonatomic) BOOL showNavigation;
/** 是否显示Tabbar NO */
@property (nonatomic) BOOL showTabbar;
/** 裁剪内容高度 用来添加最上层控件 添加在父类view上 */
@property (nonatomic) CGFloat cutOutHeight;
/** 菜单位置风格 默认 ZXGPageStyleTop */
@property (nonatomic) ZXGPageStyle pageStyle;

#pragma mark - UIScrollMenuView Config
/** 菜单height 默认 44 */
@property (nonatomic) CGFloat menuHeight;
/** 菜单widht 默认是 屏幕宽度 */
@property (nonatomic) CGFloat menuWidth;
/** 内容区域 */
@property (nonatomic) CGFloat contentHeight;
/** 菜单背景color */
@property (nonatomic, strong) UIColor *scrollViewBackgroundColor;
/** 自定义Item 加图片 图片间隙 ... */
@property (nonatomic, strong) NSArray<UIButton *> *buttonArray;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
