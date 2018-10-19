//
//  LeftViewController.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/18.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "LeftViewController.h"
#import "TestView.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

// 指定初始化方法   便利初始化方法
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TestView *testView = [TestView new];
    TestView *testView = [[[NSBundle mainBundle] loadNibNamed:@"TestView" owner:nil options:nil] firstObject];
    [self.view addSubview:testView];
    testView.frame = CGRectMake(36, 106, 266, 108);
}

@end
