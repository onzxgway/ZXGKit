//
//  UIViewLayerController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "UIViewLayerController.h"
#import "CustomView.h"

@interface UIViewLayerController ()
@property (nonatomic, strong) UIView *rView;
@property (nonatomic, strong) CALayer *rLayer;
@property (nonatomic, strong) CustomView *customView;
@property (nonatomic, strong) UIView *safeAreaView;

@end

@implementation UIViewLayerController

/**
 UIView 和 CALayer 有什么区别？
 
    1.UIView 和 CALayer 都是 UI 操作的对象。两者都是 NSObject 的子类，发生在 UIView 上的操作本质上也发生在对应的 CALayer 上。
 
    2.UIView 是 CALayer 用于交互的抽象。UIView 是 UIResponder 的子类（ UIResponder 是 NSObject 的子类），提供了很多 CALayer 所没有的交互上的接口，主要负责处理用户触发的种种操作。
 
    3.CALayer 在图像和动画渲染上性能更好。这是因为 UIView 有冗余的交互接口，而且相比 CALayer 还有层级之分。CALayer 在无需处理交互时进行渲染可以节省大量时间。
 */

/**
 
 5.请说明并比较以下关键词：Frame, Bounds, Center
 
 Frame 是指当前视图（View）相对于父视图的平面坐标系统中的位置和大小。
 Bounds 是指当前视图相对于自己的平面坐标系统中的位置和大小。
 Center 是一个 CGPoint，指当前视图在父视图的平面坐标系统中最中间位置点。
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     SafeAreaLayoutGuide 是指 SafeArea 的区域范围和限制 。在布局设置中，我们可以分别取得它的上下左右 4 个边界的位置进行相应布局处理。
     
     */
    [self.view addSubview:self.safeAreaView];
    [self.safeAreaView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.safeAreaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.safeAreaView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.safeAreaView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.safeAreaView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[top, left, right, bottom]];
    
    NSLog(@"__%@__", NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    
    //
    [self.view addSubview:self.rView];
    self.rView.frame = CGRectMake(38, 428, 98, 68);
    
    //
    [self.view.layer addSublayer:self.rLayer];
    self.rLayer.frame = CGRectMake(38, 228, 98, 68);
    
}

- (UIView *)rView {
    if (!_rView) {
        _rView = [UIView new];
        _rView.backgroundColor = [UIColor redColor];
    }
    return _rView;
}

- (CALayer *)rLayer {
    if (!_rLayer) {
        _rLayer = [CALayer new];
        _rLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _rLayer;
}

/**
 6.请说明并比较以下方法：layoutIfNeeded, layoutSubviews, setNeedsLayout
 
 
    layoutSubviews 是用来自定义视图尺寸位置调整的。它是系统自动调用的，开发者不能手动调用。我们能做的就是重写该方法，让系统在尺寸调整时能按照希望的效果去进行布局。这个方法主要在屏幕旋转、滑动或触摸界面、子视图修改时被触发。
 
    setNeedsLayout 与 layoutIfNeeded 相似，唯一不同的就是它不会立刻强制视图重新布局，而是在下一个布局周期才会触发更新。它主要用在多个 view 布局先后更新的场景下。例如我们要在两个布局不停变化的点之间连一条线，这个线的布局就可以调用 setNeedsLayout 方法。
 
    layoutIfNeeded 方法一旦调用，主线程会立即强制重新布局，它从当前视图开始，一直到完成所有子视图的布局。
 */
- (CustomView *)customView {
    if (!_customView) {
        _customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil] firstObject];
    }
    return _customView;
}


- (UIView *)safeAreaView {
    if (!_safeAreaView) {
        _safeAreaView = [UIView new];
        _safeAreaView.backgroundColor = [UIColor blueColor];
    }
    return _safeAreaView;
}

@end
