//
//  ZXGCenterViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGCenterViewController.h"
#import "ZXGTwoViewController.h"
#import "ZXGOneViewController.h"

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
    UIView *v = [UIView new];
    v.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    vc.headerView = v;
    
    /// 指定默认选择index 页面
//    vc.pageIndex = 2;
    
    return vc;
}

+ (NSArray *)getArrayVCs {
    ZXGOneViewController *vc_1 = [[ZXGOneViewController alloc] init];
    
    ZXGTwoViewController *vc_2 = [[ZXGTwoViewController alloc] init];
    
    UIViewController *vc_3 = [[UIViewController alloc] init];
    vc_3.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc_11 = [[UIViewController alloc] init];
    vc_11.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc_22 = [[UIViewController alloc] init];
    vc_22.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc_33 = [[UIViewController alloc] init];
    vc_33.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc_111 = [[UIViewController alloc] init];
    vc_111.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc_222 = [[UIViewController alloc] init];
    vc_222.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc_333 = [[UIViewController alloc] init];
    vc_333.view.backgroundColor = [UIColor greenColor];
    
    return @[vc_1, vc_2, vc_3, vc_11, vc_22, vc_33, vc_111, vc_222, vc_333];
}

+ (NSArray *)getArrayTitles {
    return @[@"鞋子帽子", @"衣服", @"帽子帽子帽子帽子", @"鞋子帽", @"衣服123", @"帽子帽子帽子帽子cv", @"鞋子ss帽子", @"衣125服", @"帽子帽99子帽子帽子"];
}

@end
