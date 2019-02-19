//
//  XGPageConfigration.h
//  XGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ZXGPage样式
 
 - ZXGPageStyleTop: MenuView在顶部
 - ZXGPageStyleNavigation: MenuView在系统导航条
 - ZXGPageStyleSuspensionTop: MenuView悬浮，刷新控件在HeaderView顶部
 - ZXGPageStyleSuspensionCenter: MenuView悬浮，刷新控件在HeaderView底部
 - ZXGPageStyleSuspensionTopPause: MenuView悬浮，刷新控件在HeaderView顶部 停顿 类似QQ联系人页面
 SuspensionTopPause 需要继承ZXGPageTableView或ZXGPageCollectionView 实现那个手势 YES,如果有自己的集成体系，则单独实现那个方法
 */
typedef NS_ENUM(NSInteger, ZXGPageStyle) {
    ZXGPageStyleTop = 0,
    ZXGPageStyleNavigation = 1,
    ZXGPageStyleSuspensionTop = 2,
    ZXGPageStyleSuspensionCenter = 3,
    ZXGPageStyleSuspensionTopPause = 4,
};


@interface XGPageConfigration : NSObject

#pragma mark - YNPage Config
/** 是否显示导航条 YES */
@property (nonatomic) BOOL showNavigation;
/** 是否显示Tabbar NO */
@property (nonatomic) BOOL showTabbar;
/** 裁剪内容高度 用来添加最上层控件 添加在父类view上 */
@property (nonatomic) CGFloat cutOutHeight;
/** 菜单位置风格 默认 ZXGPageStyleTop */
@property (nonatomic) ZXGPageStyle pageStyle;
/** 悬浮ScrollMenu偏移量 默认 0 */
@property (nonatomic) CGFloat suspenOffsetY;

#pragma mark - UIScrollMenuView Config
/** 是否显示遮盖*/
@property (nonatomic) BOOL showCover;
/** 遮盖color */
@property (nonatomic, strong) UIColor *coverColor;
/** 遮盖圆角 14 */
@property (nonatomic) CGFloat coverCornerRadius;
/** 遮盖height 28 */
@property (nonatomic) CGFloat coverHeight;



/** 是否显示指示线条 YES */
@property (nonatomic) BOOL showScrollLine;
/** 指示线height 2 */
@property (nonatomic) CGFloat lineHeight;
/** 线条底部距离 0*/
@property (nonatomic) CGFloat lineBottomMargin;
/** 线条左右偏移量 0 */
@property (nonatomic) CGFloat lineLeftAndRightMargin;
/** 线条左右增加 0  默认线条宽度是等于 item宽度 */
@property (nonatomic) CGFloat lineLeftAndRightAddWidth;
/** 线条圆角 0 */
@property (nonatomic) CGFloat lineCorner;
/** 是否需要线条宽度等于字体宽度 默认 NO */
@property (nonatomic) BOOL lineWidthEqualFontWidth;
/** 线条color */
@property (nonatomic, strong) UIColor *lineColor;


/** 是否显示底部线条 NO */
@property (nonatomic) BOOL showBottomLine;
/** 底部线条颜色 */
@property (nonatomic, strong) UIColor *bottomLineColor;
/** 底部线条左右偏移量 0 */
@property (nonatomic) CGFloat bottomLineLeftAndRightMargin;
/** 底部线height 2 */
@property (nonatomic) CGFloat bottomLineHeight;
/** 底部线条圆角 0 */
@property (nonatomic) CGFloat bottomLineCorner;


/** 缩放系数 */
@property (nonatomic) CGFloat itemMaxScale;
/** 选项字体 14 */
@property (nonatomic, strong) UIFont *itemFont;
/** 选中字体 */
@property (nonatomic, strong) UIFont *selectedItemFont;
/** 选项正常color */
@property (nonatomic, strong) UIColor *itemColor;
/** 选项选中color */
@property (nonatomic, strong) UIColor *selectedItemColor;
/** 字体颜色在过渡时是否渐变 YES */
@property (nonatomic) BOOL showGradientColor;

/** 遮盖height 28 */
@property (nonatomic) CGFloat conerHeight;
/** 是否显示按钮 NO */
@property (nonatomic) BOOL showAddButton;
/** 菜单弹簧效果 NO */
@property (nonatomic) BOOL bounces;
/** 菜单height 默认 44 */
@property (nonatomic) CGFloat menuHeight;
/** 菜单widht 默认是 屏幕宽度 */
@property (nonatomic) CGFloat menuWidth;


/** 内容区域 */
@property (nonatomic) CGFloat contentHeight;
/** 选项相邻间隙 15 */
@property (nonatomic) CGFloat itemMargin;
/** 选项左边或者右边间隙 15 */
@property (nonatomic) CGFloat itemLeftAndRightMargin;
/** 菜单背景color */
@property (nonatomic, strong) UIColor *menuViewBackgroundColor;


/** 菜单是否滚动 YES */
@property (nonatomic) BOOL scrollMenu;
/** 自定义Item 加图片 图片间隙 ... */
@property (nonatomic, strong) NSArray<UIButton *> *buttonArray;
/**
 *  是否居中 (当所有的Item + margin的宽度小于ScrollView宽度)  默认 YES
 *  scrollMenu = NO, aligmentModeCenter = NO 会变成平分
 */
@property (nonatomic) BOOL aligmentModeCenter;


/** 头部是否可以滚动页面 NO */
@property (nonatomic) BOOL headerViewCouldScrollPage;


+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
