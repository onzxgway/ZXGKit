//
//  ZXGTestPageViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/2/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTestPageViewController.h"

@interface ZXGTestPageViewController () <ZXGPageViewControllerDataSource>

@end

@implementation ZXGTestPageViewController

+ (instancetype)centerVC {
    
    XGPageConfigration *configration = [XGPageConfigration defaultConfig];
    configration.pageStyle = ZXGPageStyleSuspensionTop;
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

+ (instancetype)centerVC:(XGPageConfigration *)config {
    
    ZXGTestPageViewController *vc = [[ZXGTestPageViewController alloc] initPageViewControllerWithControllers:[self getArrayVCs] titles:[self getArrayTitles] config:config];
    vc.dataSource = vc;
    //    vc.delegate = vc;
    
    //    /// 轮播图
    //    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 200) imageURLStringsGroup:vc.imagesURLs];
    //    autoScrollView.delegate = vc;
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor redColor];
    v.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    vc.headerView = v;
    
    /// 指定默认选择index 页面
    //    vc.pageIndex = 2;
    
    return vc;
}

+ (NSArray *)getArrayVCs {
    UITableViewController *vc_1 = [[UITableViewController alloc] init];
    
    UITableViewController *vc_2 = [[UITableViewController alloc] init];
    
    UITableViewController *vc_3 = [[UITableViewController alloc] init];
    //    vc_3.view.backgroundColor = [UIColor greenColor];
    
    UITableViewController *vc_11 = [[UITableViewController alloc] init];
    //    vc_11.view.backgroundColor = [UIColor redColor];
    
    UITableViewController *vc_22 = [[UITableViewController alloc] init];
    //    vc_22.view.backgroundColor = [UIColor blueColor];
    
    UITableViewController *vc_33 = [[UITableViewController alloc] init];
    //    vc_33.view.backgroundColor = [UIColor greenColor];
    
    UITableViewController *vc_111 = [[UITableViewController alloc] init];
    //    vc_111.view.backgroundColor = [UIColor redColor];
    
    UITableViewController *vc_222 = [[UITableViewController alloc] init];
    //    vc_222.view.backgroundColor = [UIColor blueColor];
    
    UITableViewController *vc_333 = [[UITableViewController alloc] init];
    //    vc_333.view.backgroundColor = [UIColor greenColor];
    
    return @[vc_1, vc_2, vc_3, vc_11, vc_22, vc_33, vc_111, vc_222, vc_333];
}

+ (NSArray *)getArrayTitles {
    return @[@"鞋子帽子", @"衣服", @"帽子帽子帽子帽子", @"鞋子帽", @"衣服123", @"帽子帽子帽子帽子cv", @"鞋子ss帽子", @"衣125服", @"帽子帽99子帽子帽子"];
}

- (__kindof UIScrollView *)pageViewController:(ZXGPageViewController *)pageViewController
                                 pageForIndex:(NSInteger )index {
    UITableViewController *vc = pageViewController.controllers[index];
    return vc.tableView;
}

@end
