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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setClipsToBounds:YES];
    
    [self createScrollView];
}

- (void)createScrollView {
    
    NSArray *imgs = @[@"0", @"1", @"2", @"3", @"4"];
    
    BannerView *sc = [[BannerView alloc] initWithFrame:CGRectMake(30, 108, JZSCREEN_WIDTH - 2 * 30, (JZSCREEN_WIDTH - 2 * 35) * 0.5)];
    sc.backgroundColor = [UIColor whiteColor];
    sc.pagingEnabled = YES;
    sc.contentSize = CGSizeMake(CGRectGetWidth(sc.frame) * imgs.count, 0);
    sc.clipsToBounds = NO;
    [self.view addSubview:sc];
    
    
    for (NSInteger i = 0; i < imgs.count; i ++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgs[i]]];
        [sc addSubview:img];
        img.frame = CGRectMake(10 + CGRectGetWidth(sc.frame) * i, 0, CGRectGetWidth(sc.frame) - 10, CGRectGetHeight(sc.frame));
    }
    
}


@end
