//
//  GestureEventController.m
//  Event
//
//  Created by 朱献国 on 2018/11/6.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "GestureEventController.h"
#import "GrayView.h"
#import "YellowView.h"
#import "RedView.h"
#import "BlueView.h"
#import "RedTapGestureRecognizer.h"

@interface GestureEventController ()

@property (nonatomic, strong) GrayView *grayView;
@property (nonatomic, strong) YellowView *yellowView;
@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) BlueView *blueView;

@end

/**
 3.手势种类：
 UITapGestureRecognizer
 UIPanGestureRecognizer   (拖动)
 UISwipeGestureRecognizer (轻扫)
 UIPinchGestureRecognizer (捏合)
 UIRotationGestureRecognizer  (旋转)
 UILongPressGestureRecognizer (长按)
 UIScreenEdgePanGestureRecognizer (屏幕边缘)
 */
@implementation GestureEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubView];
}

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
//        [_grayView addGestureRecognizer:[[RedTapGestureRecognizer alloc] initWithTarget:self action:@selector(redViewClick)]];
    }
    return _grayView;
}

- (YellowView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[YellowView alloc] init];
    }
    return _yellowView;
}

/**
 1.手势与 hitTest 和 pointInside 的关系？
 
    必须先通过两个函数找到View,然后View上添加的手势才能响应。
 
    View 以及 View.superview... 上如果有手势都会响应。
 */
- (RedView *)redView {
    if (!_redView) {
        _redView = [[RedView alloc] init];
        RedTapGestureRecognizer *ges = [[RedTapGestureRecognizer alloc] initWithTarget:self action:@selector(redViewClick)];
        ges.cancelsTouchesInView = YES; // 识别手势之后，是否取消View的touch事件。
        ges.delaysTouchesBegan = YES;   // 是否延迟View的touch事件识别。如果延迟了，那么手势也识别了，就放弃touch事件。
        [_redView addGestureRecognizer:ges];
    }
    return _redView;
}
/**
 4.手势和view的touch事件的关系？
    delaysTouchesBegan
    cancelsTouchesInView
 */

- (BlueView *)blueView {
    if (!_blueView) {
        _blueView = [[BlueView alloc] init];
    }
    return _blueView;
}

- (void)redViewClick {
    NSLog(@"%s", __func__);
}

@end
