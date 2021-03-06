//
//  XGPageConfigration.m
//  XGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "XGPageConfigration.h"
#import "UIView+ZXGPageExtend.h"

@implementation XGPageConfigration

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showNavigation = YES;
        _showTabbar = NO;
        _pageStyle = ZXGPageStyleTop;
        _showCover = NO;
        _showScrollLine = YES;
        _showBottomLine = NO;
        _showGradientColor = NO;
        _showAddButton = NO;
        _scrollMenu = YES;
        _bounces = YES;
        _aligmentModeCenter = YES;
        _lineWidthEqualFontWidth = NO;

//        _pageScrollEnabled = YES;
//
//        _headerViewCouldScale = NO;
//
        _lineColor = [UIColor greenColor];
        _coverColor = [UIColor groupTableViewBackgroundColor];
//        _addButtonBackgroundColor = [UIColor whiteColor];
        _bottomLineColor = [UIColor grayColor];
        _bottomLineLeftAndRightMargin = 0.f;
        _bottomLineHeight = 2;
        _bottomLineCorner = 0.f;
        
        _menuViewBackgroundColor = [UIColor blueColor];
        _itemColor = [UIColor grayColor];
        _selectedItemColor = [UIColor greenColor];
        _lineHeight = 2;
        _lineBottomMargin = 0;
        _lineCorner = 0.f;
        _conerHeight = 28;
        _lineLeftAndRightAddWidth = 0;
        
        _menuHeight = 44.f;
        _menuWidth = XGPAGE_SCREEN_WIDTH;
        _coverCornerRadius = 14.f;
        _itemMargin = 15;
        _itemLeftAndRightMargin = 15;
        _itemFont = [UIFont systemFontOfSize:14.f];
        _selectedItemFont = _itemFont;
        _itemMaxScale = 0;
        
        _headerViewCouldScrollPage = NO;
        
        _suspenOffsetY = 0.f;

    }
    return self;
}

+ (instancetype)defaultConfig {
    return [[self alloc] init];
};

@end
