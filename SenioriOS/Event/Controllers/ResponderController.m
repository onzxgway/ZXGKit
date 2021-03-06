//
//  ResponderController.m
//  Event
//
//  Created by 朱献国 on 2018/10/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ResponderController.h"
#import "GrayView.h"
#import "YellowView.h"
#import "RedView.h"
#import "BlueView.h"

@interface ResponderController ()

@property (nonatomic, strong) GrayView *grayView;
@property (nonatomic, strong) YellowView *yellowView;
@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) BlueView *blueView;

@end

@implementation ResponderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubView];
}

/**
 
 当用户触发一个触摸事件，当前屏幕内有多个对象可以接收，那么是如何判断处理的对象是哪个？
 
 用户触摸时，UIKit会生成一个UIEvent object(包含事件发生的位置、时间、状态等信息)，把它添加到UIApplication对象维护的event队列中(FIFO)，队列把事件对象分发到keyWindow中，事件沿着一个特定的路径来传递到可处理事件的对象上来。
 
 */
- (void)layoutSubView {
    // autoLayout
    [self.view addSubview:self.grayView];
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *grayTop = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:108.f];
    NSLayoutConstraint *grayCenterX = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *grayW = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:-88.f];
    NSLayoutConstraint *grayH = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0.f constant:188.f];
    [self.view addConstraints:@[grayTop, grayCenterX, grayW, grayH]];
    
    [self.grayView addSubview:self.redView];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *redLeft = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *redW = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-38.f];
    NSLayoutConstraint *redH = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeHeight multiplier:0.5f constant:-18.f];
    [self.grayView addConstraints:@[redTop, redLeft, redW, redH]];
    
    [self.grayView addSubview:self.blueView];
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueBottom = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueW = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueH = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
    [self.grayView addConstraints:@[blueBottom, blueLeft, blueW, blueH]];
    
    [self.view addSubview:self.yellowView];
    self.yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *yellowViewTop = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeBottom multiplier:1.f constant:188.f];
    NSLayoutConstraint *yellowViewCenterX = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *yellowW = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
    NSLayoutConstraint *yellowH = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
    [self.view addConstraints:@[yellowViewTop, yellowViewCenterX, yellowW, yellowH]];
}

- (GrayView *)grayView {
    if (!_grayView) {
        _grayView = [[GrayView alloc] init];
    }
    return _grayView;
}

- (YellowView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[YellowView alloc] init];
    }
    return _yellowView;
}

- (RedView *)redView {
    if (!_redView) {
        _redView = [[RedView alloc] init];
        [_redView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redViewClick)]];
    }
    return _redView;
}

- (BlueView *)blueView {
    if (!_blueView) {
        _blueView = [[BlueView alloc] init];
    }
    return _blueView;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s", __func__);
//    [super touchesCancelled:touches withEvent:event];
//}

- (void)redViewClick {
    NSLog(@"%s", __func__);
}

@end
