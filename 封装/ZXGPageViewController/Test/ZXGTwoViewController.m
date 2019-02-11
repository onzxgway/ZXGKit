//
//  ZXGTwoViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/2/11.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTwoViewController.h"

@interface ZXGTwoViewController ()

@end

@implementation ZXGTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s", __func__);
}


@end
