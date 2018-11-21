
//
//  TGTestController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TGTestController.h"
#import "RedView.h"
#import "YellowView.h"
#import "RedGesture.h"
#import "YellowGesture.h"
#import "BlueView.h"
#import "BlueGesture.h"
#import "BannerView.h"
#import "TableView.h"
#import "RootView.h"

@interface TGTestController ()

@end

@implementation TGTestController

- (void)loadView {
    self.view = [RootView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self touchHit];
}

/**
 
 ** ScrollView 会阻止控件内部的touch事件 继续向 父控件 传递。 原因：不是因为ScrollView本身有个pan手势。已验证
 
 ** 如果ScrollView的父控件有外部手势的话，正常响应。
 */
- (void)touchHit {
    BlueView *bl = [BlueView new];
    [bl addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(event)]];
    [self.view addSubview:bl];
    bl.frame = CGRectMake(92, 120, 148, 148);
    bl.backgroundColor = [UIColor blueColor];
    
    BannerView *r = [BannerView new];
    [bl addSubview:r];
    r.frame = CGRectMake(10, 10, 128, 128);
//    [self.view addSubview:r];
//    r.frame = CGRectMake(102, 130, 128, 128);
    r.backgroundColor = [UIColor redColor];
    
    YellowView *y = [YellowView new];
    [r addSubview:y];
    y.frame = CGRectMake(10, 10, 108, 108);
//    [self.view addSubview:y];
//    y.frame = CGRectMake(112, 140, 108, 108);
    y.backgroundColor = [UIColor yellowColor];
}

- (void)event {
    NSLog(@"event");
}

@end
