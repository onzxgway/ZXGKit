
//
//  TestViewController.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/17.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

/**
 UIViewController 初始化的入口 只有两个  指定初始化方法（NS_DESIGNATED_INITIALIZER）
 
 1.- initWithNibName: bundle:   // 纯代码、xib 走这个
 
 2.- initWithCoder:             // storyboard 走这个
 
 */

@implementation TestViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

/**
 UIViewController 的生命周期
 */

- (void)loadView {
    [super loadView];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    self.view.backgroundColor = [UIColor greenColor];
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

/** 过期
 
- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"%s", __func__);
}
 
 */

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
