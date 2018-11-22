
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

/**
 总结：
 
 1.子控件的 内部的 touch事件在触发的时候，会向其父类方向，层层向上传递。（目前已知 ScrollView 会阻止控件内部的touch事件 继续向 父控件方向 传递）
 
 2.控件的 内部touch事件 与 外部添加的手势事件，没必然的联系。 内部的touch事件不响应，手势依旧可以触发。（手势触发与否与手势内部的touch事件和手势代理有关）
 
 3.不同层级的手势冲突发生在同种手势之间。
 */

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
    
    /**
     当 r 是 ScrollView 的时候，其本身的 UIScrollViewPanGestureRecognizer 手势与 其 父类的UIPanGestureRecognizer手势 并不冲突，
     */
    BannerView *r = [BannerView new];
    [bl addSubview:r];
    r.frame = CGRectMake(10, 10, 128, 128);
//    [self.view addSubview:r];
//    r.frame = CGRectMake(102, 130, 128, 128);
    r.backgroundColor = [UIColor redColor];
    
    YellowView *y = [YellowView new];
    [y addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(event1)]];
    [self.view addSubview:y];
    [r addSubview:y];
    y.frame = CGRectMake(10, 10, 108, 108);
//    [self.view addSubview:y];
//    y.frame = CGRectMake(112, 140, 108, 108);
    y.backgroundColor = [UIColor yellowColor];
}

- (void)event {
    NSLog(@"BlueView event");
}

- (void)event1 {
    NSLog(@"YellowView event");
}


@end
