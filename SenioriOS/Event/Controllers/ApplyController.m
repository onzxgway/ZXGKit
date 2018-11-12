//
//  ApplyController.m
//  Event
//
//  Created by 朱献国 on 2018/11/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ApplyController.h"
#import "GrayView.h"
#import "PracticeButton.h"

@interface ApplyController ()
@property (nonatomic, strong) GrayView *grayView;
@property (nonatomic, strong) PracticeButton *btn;
@property (nonatomic, strong) PracticeButton *Bbtn;
@end

@implementation ApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubView];
}

- (void)layoutSubView {
    // autoLayout
    [self.view addSubview:self.grayView];
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *grayTop = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:208.f];
    NSLayoutConstraint *grayCenterX = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *grayW = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:-88.f];
    NSLayoutConstraint *grayH = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0.f constant:68.f];
    [self.view addConstraints:@[grayTop, grayCenterX, grayW, grayH]];
    
    [self.grayView addSubview:self.btn];
    self.btn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeTop multiplier:1.f constant:-60.f];
    NSLayoutConstraint *redLeft = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *redW = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:68.f];
    NSLayoutConstraint *redH = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.btn attribute:NSLayoutAttributeWidth multiplier:1.f constant:30.f];
    [self.grayView addConstraints:@[redTop, redLeft, redW, redH]];
    
    [self.grayView addSubview:self.Bbtn];
    self.Bbtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *redBTop = [NSLayoutConstraint constraintWithItem:self.Bbtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *redBLeft = [NSLayoutConstraint constraintWithItem:self.Bbtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *redBW = [NSLayoutConstraint constraintWithItem:self.Bbtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.btn attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f];
    NSLayoutConstraint *redBH = [NSLayoutConstraint constraintWithItem:self.Bbtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.Bbtn attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
    [self.grayView addConstraints:@[redBTop, redBLeft, redBW, redBH]];
    
}

- (GrayView *)grayView {
    if (!_grayView) {
        _grayView = [[GrayView alloc] init];
    }
    return _grayView;
}

- (PracticeButton *)btn {
    if (!_btn) {
        _btn = [PracticeButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"哈" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor blueColor]];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (PracticeButton *)Bbtn {
    if (!_Bbtn) {
        _Bbtn = [PracticeButton buttonWithType:UIButtonTypeCustom];
        [_Bbtn setTitle:@"嘻嘻嘻" forState:UIControlStateNormal];
        [_Bbtn setBackgroundColor:[UIColor greenColor]];
        [_Bbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Bbtn;
}

- (void)click:(UIButton *)btn {
    NSLog(@"%@", btn);
}

@end
