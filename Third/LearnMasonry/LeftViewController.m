//
//  LeftViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
@property (nonatomic, strong) UILabel *titleLab; // <#备注#>
@property (nonatomic, strong) UILabel *detailLab; // <#备注#>
@property (nonatomic, strong) UILabel *updateLab; // <#备注#>
@property (nonatomic, strong) NSLayoutConstraint *UWidth; // <#备注#>
@end

/**
 Masonry的三个主要方法:
 1.mas_makeConstraints()    添加约束
     创建NSLayoutConstraint对象.
     底层调用了 addConstraints: 添加
 2.mas_remakeConstraints()  移除之前的约束，重新添加新的约束
     调用了 removeConstraints:移除之前的约束
     再调用了 addConstraints: 添加新约束
 3.mas_updateConstraints()  更新约束，写哪条更新哪条，其他约束不变
     获取到对应的NSLayoutConstraint对象,然后修改constant属性的值
 */

@implementation LeftViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.detailLab];
    [self.view addSubview:self.updateLab];
    
    CGFloat margin = 144;
    NSLayoutConstraint *x = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
    
    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    
    NSLayoutConstraint *maxW = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    
    [self.view addConstraints:@[x, y, maxW]];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.detailLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleLab attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-18];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.detailLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.detailLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLab attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self.view addConstraints:@[right, left, centerX]];
    
    NSLayoutConstraint *UCenterX = [NSLayoutConstraint constraintWithItem:self.updateLab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    NSLayoutConstraint *UCenterY = [NSLayoutConstraint constraintWithItem:self.updateLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    NSLayoutConstraint *UWidth = [NSLayoutConstraint constraintWithItem:self.updateLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:160];
    self.UWidth = UWidth;
    
    NSLayoutConstraint *UHeight = [NSLayoutConstraint constraintWithItem:self.updateLab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    
    [self.view addConstraints:@[UCenterX, UCenterY, UWidth, UHeight]];
}

#pragma mark - CreateViews

#pragma mark - Private
- (void)tapEvent {
    if (_titleLab.text.length <= 4) {
        _titleLab.text = @"面朝大海 春暖花开";
    }
    else {
        _titleLab.text = @"春暖花开";
    }
}

// 更新约束 就是更新NSLayoutContairt的constant的值
- (void)tapUEvent {
    if (self.UWidth.constant >= [UIScreen mainScreen].bounds.size.width - 28) {
        self.UWidth.constant = [UIScreen mainScreen].bounds.size.width * 0.5;
    }
    else {
        self.UWidth.constant = [UIScreen mainScreen].bounds.size.width - 28;
    }
}

#pragma mark - Public

#pragma mark - LazyLoad
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16.f];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.text = @"春暖花开";
        _titleLab.numberOfLines = 0;
        _titleLab.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLab.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [_titleLab addGestureRecognizer:tap];
        _titleLab.userInteractionEnabled = YES;
    }
    return _titleLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = [UIFont systemFontOfSize:16.f];
        _detailLab.textColor = [UIColor blackColor];
        _detailLab.text = @"从明天起，做一个幸福的人 喂马，劈柴，周游世界 从明天起，关心粮食和蔬菜 我有一所房子，面朝大海，春暖花开";
        _detailLab.numberOfLines = 0;
        _detailLab.translatesAutoresizingMaskIntoConstraints = NO;
        _detailLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _detailLab;
}

- (UILabel *)updateLab {
    if (!_updateLab) {
        _updateLab = [[UILabel alloc] init];
        _updateLab.font = [UIFont systemFontOfSize:16.f];
        _updateLab.textColor = [UIColor blackColor];
        _updateLab.text = @"从明天起，和每一个亲人通信 告诉他们我的幸福 那幸福的闪电告诉我的 我将告诉每一个人";
        _updateLab.numberOfLines = 0;
        _updateLab.translatesAutoresizingMaskIntoConstraints = NO;
        _updateLab.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUEvent)];
        [_updateLab addGestureRecognizer:tap];
        _updateLab.userInteractionEnabled = YES;
    }
    return _updateLab;
}

#pragma mark - Network

@end
