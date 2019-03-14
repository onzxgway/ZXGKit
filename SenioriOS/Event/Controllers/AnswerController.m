//
//  AnswerController.m
//  Event
//
//  Created by onzxgway on 2019/3/14.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "AnswerController.h"
#import "GrayView.h"
#import "YellowView.h"
#import "RedView.h"
#import "BlueView.h"

@interface AnswerController ()

@property (nonatomic, strong) GrayView *grayView;
@property (nonatomic, strong) YellowView *yellowView;
@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) BlueView *blueView;

@end


@implementation AnswerController

/**
 
 响应者链：
 
 self.redView.nextResponder
 <GrayView: 0x7ffe9fd3d460; frame = (44 108; 287 188); layer = <CALayer: 0x600003dd1c60>>
 
 self.redView.nextResponder.nextResponder
 <UIView: 0x7ffe9fd02520; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x600003dd6ce0>>
 
 self.redView.nextResponder.nextResponder.nextResponder
 <AnswerController: 0x7ffe9fe20740>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder
 <UIViewControllerWrapperView: 0x7ffe9fe04c10; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x600003ddc2c0>>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <UINavigationTransitionView: 0x7ffe9fc0eec0; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x600003dd1680>>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <UILayoutContainerView: 0x7ffe9fc04d20; frame = (0 0; 375 667); autoresize = W+H; gestureRecognizers = <NSArray: 0x6000033c9800>; layer = <CALayer: 0x600003dd0940>>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <UINavigationController: 0x7ffea001c600>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <UIWindow: 0x7ffe9ff02210; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x6000033d4900>; layer = <UIWindowLayer: 0x600003d845e0>>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <UIApplication: 0x7ffe9fd01da0>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 <AppDelegate: 0x600003d811c0>
 
 self.redView.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder
 nil
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubView];
}

#pragma mark - Navigation
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

- (void)redViewClick {
    NSLog(@"%s", __func__);
}

@end
