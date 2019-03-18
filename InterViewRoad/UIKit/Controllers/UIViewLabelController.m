//
//  UIViewLabelController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "UIViewLabelController.h"
#import "CustomView.h"

@interface UIViewLabelController ()

@property (nonatomic, strong) CustomView *customView;

@property (nonatomic, strong) UIView *rView;

@end

@implementation UIViewLabelController

/**
 一.要在 UIView 上定义一个 Label有 哪几种方式？
 
    在 CustomView 上定义一个 UILabel有 哪几种方式？
 
 答案： 1.用纯代码的方式来做。2.用 storyboard 或 xib 完成。
 */

/**
 二.storyboard/xib，和纯代码构建 UI 相比，有什么优缺点？
 
 优点是：
 
 简单直接。直接拖拽和点选即可配置 UI，界面所见即所得。
 跳转关系清楚。Storyboards 中可以清楚的区分 View Controller 界面之间的跳转关系。而且在代码中，通过实现 prepare(for segue: UIStoryboardSegue, sender: Any?)，我们可以统一管理界面跳转和数据管理。
 
 
 缺点是：
 
 协作冲突。多人编辑时很容易产生冲突，且冲突很难解决。因为自带 Xcode 和系统的版本号，协作时 storyboard/xib 会在相同位置做同样修改，这样代码冲突几乎是不可避免的。解决方法是细分 storyboard 以及对应工程师的职责，但是这样同样带来了维护成本。
 很难做到界面继承和重用。代码中实现要容易和明确得多，然而 storyboard/xib 却很难做到。
 不便于进行模块化管理。storyboard/xib 中搜索起来很不方便，且统一修改多个 UI 控件的属性值不可能，必须一个一个改。在代码中一个工厂模式就可以搞定。
 性能影响。storyboard/xib 在界面渲染上有时会成为性能杀手。例如首页 UI 构造时，代码书写和优化就会比 storyboard 多图层的渲染要好很多。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.customView];
    self.customView.frame = CGRectMake(44, 102, 220, 188);
    
    // 1.用纯代码的方式来做。新建一个 label 对象，设置属性，配置它在页面上的布局（然后用 frame 或是 auto layout可以用 anchor 或 NSLayoutConstraint ），添加到父控件即可。
    UILabel *lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:12.f];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"纯代码的方式";
    lab.backgroundColor = [UIColor redColor];
    lab.frame = CGRectMake(10, 10, 88, 32);
    [self.customView addSubview:lab];
    
    // 2.用 storyboard 或 xib 完成。直接在库面板中拖拽一个 label 完成创建，然后设置相应的 constraint 进行布局，最后在属性检查器面板对相应属性进行设置。这是苹果推荐的做法。
    
    
    /**
     三.Auto Layout 和 Frame 在 UI 布局和渲染上有什么区别？
     
        Auto Layout 的性能比 Frame 差很多。Auto Layout 的布局过程首先求解线性不等式，然后再转化为 Frame 去进行布局。其中求解的计算量非常大，通常 Auto Layout 的性能损耗是 Frame 布局的 10 倍左右。
     */
    [self.view addSubview:self.rView];
    // 1.Frame 是基于 xy 坐标轴系统的布局机制。它从数学上限定了 UI 控件的具体位置，是 iOS 开发中最底层、最基本的界面布局机制。
//    self.rView.frame = CGRectMake(38, 428, 98, 68);
    
    // 2.Auto Layout 是针对多尺寸屏幕的设计。其本质是通过线性不等式对 UI 控件的相对位置进行设定，从而适配多种 iPhone/iPad 屏幕的尺寸。
    [self.rView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.rView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:428];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.rView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:38];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.rView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-138];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.rView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-138];
    [self.view addConstraints:@[top, left, right, bottom]];
}

- (CustomView *)customView {
    if (!_customView) {
        _customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil] firstObject];
    }
    return _customView;
}


- (UIView *)rView {
    if (!_rView) {
        _rView = [UIView new];
        _rView.backgroundColor = [UIColor redColor];
    }
    return _rView;
}

@end
