//
//  TestBViewController.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/18.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TestBViewController.h"

@interface TestBViewController ()
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *nibLab;
@property (weak, nonatomic) IBOutlet UILabel *nibLabB;
@end

@implementation TestBViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

// 指定初始化方法
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%s", __func__);
        
//        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}


/**
 UIViewController.view的加载方式 是懒加载
 
 if (!_view) {
     [self loadView];
     [self viewDidLoad];
 }
 
 [self loadView] 和 [self viewDidLoad] 这两句代码 和 初始化控制器的view密切相关。且两方法都只走一遍。
 
 */

//- (void)loadView {
//    [super loadView];
//
//    NSLog(@"%s", __func__);
//}


/**
 UIViewController.view的子控件布局时机。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    
    // frame
//    self.lab.frame = CGRectMake(36, 108, 300, 168);
    
    // autoLayout
    [self.view addSubview:self.lab];
//    self.lab.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.lab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:108.f];
//    [self.view addConstraint:top];
//
//    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.lab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:38.f];
//    [self.view addConstraint:left];
//
//    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.lab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:-38.f];
//    [self.view addConstraint:right];
//
//    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.lab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0.f constant:168.f];
//    [self.view addConstraint:height];
    
    /**
     此时刻 self.view.superview 是nil
     */
    [self.view addSubview:self.subLab];

}

/**
 此时刻 self.view.superview 是nil
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/**
    此时刻 self.view.superview 是有值的， <_UIParallaxDimmingView: 0x103c01d00; frame = (0 0; 375 812); opaque = NO; layer = <CALayer: 0x1cc03a380>>
 
    _UIParallaxDimmingView 过渡。
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 从该方法起，布局是安全的。
    // 理由：如果当前控制器通过xib文件创建的话，那么当函数走到viewDidLoad内部的时候，Controller.view.size等于xib中选中设备的size，而不是真实的size, 只有走到viewWillAppear的时候，Controller.view.size 才是正确的size。
    // autoResizing
    self.lab.frame = CGRectMake(CGRectGetMinX(self.nibLabB.frame), CGRectGetMaxY(self.nibLabB.frame), CGRectGetWidth(self.nibLabB.frame), CGRectGetHeight(self.nibLabB.frame));
}

/**
 此时刻 self.view.superview 是有值的， <_UIParallaxDimmingView: 0x14d402d00; frame = (0 0; 375 812); opaque = NO; layer = <CALayer: 0x1c0023fc0>>
 
 _UIParallaxDimmingView 过渡。
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // autoLayout
//    self.lab.frame = CGRectMake(CGRectGetMinX(self.nibLab.frame), CGRectGetMaxY(self.nibLab.frame), CGRectGetWidth(self.nibLab.frame), CGRectGetHeight(self.nibLab.frame));
    
    // 在当前方法可以拿到 autoLayout 控件的frame. 该方法之前都取不到， 通过xib可以得到，但是布局会出问题。
    self.subLab.frame = CGRectMake(CGRectGetMinX(self.lab.frame), CGRectGetMaxY(self.lab.frame), CGRectGetWidth(self.lab.frame), CGRectGetHeight(self.lab.frame));
}


/**
 此时刻 self.view.superview 是有值的， <UIViewControllerWrapperView: 0x106018650; frame = (0 0; 375 812); autoresize = W+H; layer = <CALayer: 0x1d0039720>>
 
 UIViewControllerWrapperView 最终值。
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}


#pragma mark - LazyLoad

- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] init];
        _lab.text = @"Hello,world!";
        _lab.textColor = [UIColor whiteColor];
        _lab.backgroundColor = [UIColor blueColor];
        _lab.textAlignment = NSTextAlignmentCenter;
    }
    return _lab;
}

- (UILabel *)subLab {
    if (!_subLab) {
        _subLab = [[UILabel alloc] init];
        _subLab.text = @"Welcome to China!";
        _subLab.textColor = [UIColor whiteColor];
        _subLab.backgroundColor = [UIColor greenColor];
        _subLab.textAlignment = NSTextAlignmentCenter;
    }
    return _subLab;
}

@end
