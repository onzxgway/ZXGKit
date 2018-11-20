//
//  BannerController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "BannerController.h"
#import "BannerView.h"

@interface BannerController ()

@end

#define JZSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define JZSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation BannerController

//- (void)loadView {
//    self.view = [BannerView new];
//}

/**
 1. 轮播图片越界。
 2. 边界不能滑动。
 3. 导航控制器的 侧滑返回手势与b轮播图的左侧滑动手势冲突。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setClipsToBounds:YES]; // 解决1
    
    [self createScrollView];
    
}

- (void)createScrollView {
    
    NSArray *imgs = @[@"0", @"1", @"2", @"3", @"4"];
    
    BannerView *sc = [[BannerView alloc] initWithFrame:CGRectMake(30, 108, JZSCREEN_WIDTH - 2 * 30, (JZSCREEN_WIDTH - 2 * 35) * 0.5)];
    sc.backgroundColor = [UIColor whiteColor];
    sc.showsHorizontalScrollIndicator = NO;
    sc.pagingEnabled = YES;
    sc.contentSize = CGSizeMake(CGRectGetWidth(sc.frame) * imgs.count, 0);
    sc.clipsToBounds = NO;
    [self.view addSubview:sc];
    
    
    for (NSInteger i = 0; i < imgs.count; i ++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgs[i]]];
        img.userInteractionEnabled = YES;
        [sc addSubview:img];
        img.frame = CGRectMake(10 + CGRectGetWidth(sc.frame) * i, 0, CGRectGetWidth(sc.frame) - 10, CGRectGetHeight(sc.frame));
    }
    
    // 解决3
    [self.navigationController.interactivePopGestureRecognizer requireGestureRecognizerToFail:sc.panGestureRecognizer];
    
}


@end
