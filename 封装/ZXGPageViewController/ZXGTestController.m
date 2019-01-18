//
//  ZXGTestController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTestController.h"
#import "ZXGPageScrollMenuView.h"
#import "ZXGPageConfigration.h"

@interface ZXGTestController ()

@end

@implementation ZXGTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZXGPageConfigration *config = [ZXGPageConfigration defaultConfig];
    config.aligmentModeCenter = NO;
//    config.scrollMenu = NO;
    config.showBottomLine = YES;
    config.bottomLineColor = [UIColor blueColor];
    config.lineColor = [UIColor greenColor];
    config.itemMaxScale = 1.1;
//    config.lineLeftAndRightMargin = 6;
//    config.lineLeftAndRightAddWidth = -6;
    config.lineWidthEqualFontWidth = YES;
    
    ZXGPageScrollMenuView *scrollMenuView = [[ZXGPageScrollMenuView alloc] initWithFrame:CGRectMake(0, 108, 0, 0) titles:@[@"鞋子", @"衣服衣服", @"帽子", @"鞋子", @"衣服衣服衣服衣服", @"帽子", @"鞋子", @"衣衣服服", @"帽子", @"鞋衣服子", @"衣服", @"帽子"] configuration:config delegate:self currentIndex:1];
    [self.view addSubview:scrollMenuView];
}



@end
