//
//  ViewController.m
//  UISearchController
//
//  Created by onzxgway on 2019/4/28.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGView.h"
#import "ZXGFillModeView.h"

@interface ViewController ()
@property (nonatomic, strong) ZXGView *v;
@property (nonatomic, strong) ZXGFillModeView *vvv;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[UINavigationBar appearance] setTranslucent:NO];
//    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.v = [ZXGView new];
    self.vvv = [ZXGFillModeView new];
    self.vvv.frame = CGRectMake(100, 200, 220, 220);
    [self.view addSubview:self.vvv];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static CGFloat progress = 0;
    progress += 0.1;
    
    self.v.progress = progress;
    self.vvv.progress = progress;
    
}


@end
