//
//  ZXGCenterViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGCenterViewController.h"

@interface ZXGCenterViewController ()

@end

@implementation ZXGCenterViewController

#pragma mark - Public Function

+ (instancetype)centerVC {
    
    ZXGPageConfigration *configration = [ZXGPageConfigration defaultConfig];
    configration.pageStyle = ZXGPageStyleTop;
//    configration.headerViewCouldScale = YES;
//    //    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
//    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
//    configration.showTabbar = NO;
//    configration.showNavigation = YES;
//    configration.scrollMenu = NO;
//    configration.aligmentModeCenter = NO;
//    configration.lineWidthEqualFontWidth = true;
//    configration.showBottomLine = YES;
    
    return [self centerVC:configration];
}

+ (instancetype)centerVC:(ZXGPageConfigration *)config {
    
    ZXGCenterViewController *vc = [[ZXGCenterViewController alloc] initPageViewControllerWithControllers:[self getArrayVCs] titles:[self getArrayTitles] config:config];
//    vc.dataSource = vc;
//    vc.delegate = vc;
//    /// 轮播图
//    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 200) imageURLStringsGroup:vc.imagesURLs];
//    autoScrollView.delegate = vc;
//
//    vc.headerView = autoScrollView;
    /// 指定默认选择index 页面
    vc.pageIndex = 2;
    
    return vc;
}

+ (NSArray *)getArrayVCs {
    
    UIViewController *vc_1 = [[UIViewController alloc] init];
//    vc_1.cellTitle = @"鞋子";
    
    UIViewController *vc_2 = [[UIViewController alloc] init];
//    vc_2.cellTitle = @"衣服";
    
    UIViewController *vc_3 = [[UIViewController alloc] init];
    
    return @[vc_1, vc_2, vc_3];
}

+ (NSArray *)getArrayTitles {
    return @[@"鞋子", @"衣服", @"帽子"];
}

@end
