//
//  DecoupleController.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "DecoupleController.h"
#import "DecoupleView.h"

@interface DecoupleController ()
//<DecoupleViewDelegate>

@end

@implementation DecoupleController

//解耦
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    DecoupleView *decoupleView = [[DecoupleView alloc] init];
    [self.view addSubview:decoupleView];
    decoupleView.frame = CGRectMake(80, 80, 80, 80);
    decoupleView.contentStr = @"abcdefg";
    
//    decoupleView.delegate = self;

//    decoupleView.decoupleController = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Clicked) name:ClickEventNofi object:nil];
}

- (void)decoupleViewTapEvent:(UIView *)deView {
    [self Clicked];
}

- (void)Clicked {
    NSLog(@"%s Clicked", __func__);

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ClickEventNofi object:nil];

    NSLog(@"%s", __func__);
}

@end
