//
//  MultiGestureController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/13.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MultiGestureController.h"
#import "RedView.h"
#import "YellowView.h"
#import "RedGesture.h"
#import "YellowGesture.h"
#import "BlueView.h"
#import "BlueGesture.h"

@interface MultiGestureController ()

@end

@implementation MultiGestureController

/**
 1.多个手势，手势内部的touch方法是无序的。
 2.每一个手势在 调用内部的touch事件之前，都会去调用手势对象本身的代理，询问是否接受touch事件（shouldReceiveTouch），默认YES,    然后通过几个touch函数综合判断，手势的种类，此时手势到了可以识别的地步了（gestureRecognizerShouldBegin），接着会去调用target-action方式，调用之前，会有一步，再去调用手势对象本身的代理，询问是否可以与其他手势共存（shouldRecognizeSimultaneouslyWithGestureRecognizer），如果YES的话，继续调用target-action,如果NO的话，不会走target-action。（共存的原理）
 3.黄色区域的手势不识别，红色区域的手势识别。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BlueView *bl = [BlueView new];
    [self.view addSubview:bl];
    bl.frame = CGRectMake(92, 120, 148, 148);
    bl.backgroundColor = [UIColor blueColor];
    
    RedView *r = [RedView new];
    [bl addSubview:r];
    r.frame = CGRectMake(10, 10, 128, 128);
    r.backgroundColor = [UIColor redColor];
    
    YellowView *y = [YellowView new];
    [r addSubview:y];
    y.frame = CGRectMake(10, 10, 108, 108);
    y.backgroundColor = [UIColor yellowColor];
    
    BlueGesture *bG = [[BlueGesture alloc] initWithTarget:self action:@selector(bG)];
    [bl addGestureRecognizer:bG];
    
    RedGesture *rG = [[RedGesture alloc] initWithTarget:self action:@selector(rG)];
    [r addGestureRecognizer:rG];
    
    YellowGesture *yG = [[YellowGesture alloc] initWithTarget:self action:@selector(yG)];
    [y addGestureRecognizer:yG];
    
    [yG requireGestureRecognizerToFail:rG];
}

- (void)bG {
    NSLog(@"%s", __func__);
}

- (void)rG {
    NSLog(@"%s", __func__);
}

- (void)yG {
    NSLog(@"%s", __func__);
}

@end
