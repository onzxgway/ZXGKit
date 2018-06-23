//
//  ViewController.m
//  LearnMasonry
//
//  Created by 朱献国 on 2018/6/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewController.h"
#import "MasonryViewController.h"

@interface ViewController ()

// ----
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sTS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tTS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tTF;

// ----
@property (weak, nonatomic) IBOutlet UIButton *first;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *third;

// ----
@property (weak, nonatomic) IBOutlet UIButton *hiddenF;
@property (weak, nonatomic) IBOutlet UIButton *hiddenS;

// ----
@property (nonatomic, strong) UIView *leftView; // <#备注#>
@property (nonatomic, strong) UIView *rightView; // <#备注#>
@property (nonatomic, strong) NSLayoutConstraint *rightRightHight;
@property (nonatomic, strong) NSLayoutConstraint *rightRightLow; // <#备注#>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hiddenF addTarget:self action:@selector(fClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.hiddenS addTarget:self action:@selector(sClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.first addTarget:self action:@selector(scrollViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.second addTarget:self action:@selector(masonryClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 原生的自动布局
    [self.leftView setTranslatesAutoresizingMaskIntoConstraints:NO];//使用自动布局要把AutoresizingMask关掉
    
    CGFloat margin = 44;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:margin];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-margin];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:66];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    [self.view addConstraints:@[left, bottom, width, height]];
    
    self.rightView.translatesAutoresizingMaskIntoConstraints = NO;
    //方式一
//    NSLayoutConstraint *rightWidth = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:66];
//    NSLayoutConstraint *rightHeight = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    //方式二
    NSLayoutConstraint *rightWidth = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *rightHeight = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *rightBottom = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *rightRightHight = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
    NSLayoutConstraint *rightRightLow = [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    rightRightLow.priority = UILayoutPriorityDefaultLow;
    rightRightHight.priority = UILayoutPriorityDefaultHigh;
    self.rightRightHight = rightRightHight;
    self.rightRightLow = rightRightLow;
    [self.view addConstraints:@[rightRightHight, rightRightLow, rightBottom, rightWidth, rightHeight]];
    
}

- (void)fClicked {
    self.first.hidden = !self.first.isHidden;
    if (self.first.hidden) {
        self.sTF.priority = 888;
        self.sTS.priority = 999;
    }
    else {
        self.sTF.priority = 999;
        self.sTS.priority = 888;
    }
}

- (void)sClicked {
    self.second.hidden = !self.second.isHidden;
    if (self.second.hidden) {
        self.tTS.priority = 888;
        self.tTF.priority = 999;
    }
    else {
        self.tTS.priority = 999;
        self.tTF.priority = 888;
    }
    
    // 约束的优先级
    if (self.rightRightHight.priority == UILayoutPriorityDefaultLow) {
        
        self.rightRightHight.priority = UILayoutPriorityDefaultHigh;
        self.rightRightLow.priority = UILayoutPriorityDefaultLow;
    }
    else {
        
        self.rightRightHight.priority = UILayoutPriorityDefaultLow;
        self.rightRightLow.priority = UILayoutPriorityDefaultHigh;
    }
}

- (void)scrollViewClicked {
    [self.navigationController pushViewController:[ScrollViewController new] animated:YES];
}

- (void)masonryClicked {
    [self.navigationController pushViewController:[MasonryViewController new] animated:YES];
}

- (UIView *)leftView {
    if (!_leftView) {
        [self.view addSubview:_leftView = [[UIView alloc] init]];
        _leftView.backgroundColor = [UIColor lightGrayColor];
    }
    return _leftView;
}

- (UIView *)rightView {
    if (!_rightView) {
        [self.view addSubview:_rightView = [[UIView alloc] init]];
        _rightView.backgroundColor = [UIColor lightGrayColor];
    }
    return _rightView;
}

@end
