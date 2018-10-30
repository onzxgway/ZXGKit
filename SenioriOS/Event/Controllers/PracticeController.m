//
//  PracticeController.m
//  Event
//
//  Created by 朱献国 on 2018/10/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "PracticeController.h"
#import "PracticeButton.h"
#import "PracticeView.h"

@interface PracticeController ()
@property (nonatomic, strong) PracticeButton *btn;
@end

@implementation PracticeController

- (void)loadView {
    self.view = [[PracticeView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubView];
}

- (void)layoutSubView {
    // autoLayout
    [self.view addSubview:self.btn];
    self.btn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *grayCenterX = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *grayCenterY = [NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:-38.f];
    [self.view addConstraints:@[grayCenterX, grayCenterY]];
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

- (void)click:(UIButton *)btn {
    NSLog(@"%@", btn);
}

@end
