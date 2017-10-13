//
//  TestView.m
//  UICategory
//
//  Created by 朱献国 on 13/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "TestView.h"

/**
 视图创建，方法执行顺序：方法（一或二）-> 在插入视图层级之前执行方法（五）-> 从nib加载执行方法（三）-> 之后执行方法（六）-> 方法（四）
 试图销毁，方法执行顺序：方法（六）-> 方法（五）-> 方法（七）-> 方法（八）
 */

@implementation TestView

//方法一： UIView的指定初始化方法，总是发送给UIView去初始化，除非从一个nib文件中加载的。
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         NSLog(@"%s",__func__);
    }
    return self;
}

//方法二： 从nib文件中加载时，发送给UIView去初始化。
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         NSLog(@"%s",__func__);
    }
    return self;
}

//方法三： 所有nib加载的对象初始化和连接后，将给UIView发送此消息，只适用于从nib加载对象，如果重写必须要调用父类的该方法。
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__func__);
}

//方法四：
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s",__func__);
}

//这两个是需要有子视图才能执行
- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    NSLog(@"%s",__func__);
}
- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview: subview];
    NSLog(@"%s",__func__);
}

//方法五： 当前视图将要添加到其父视图的时候调用
- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
     NSLog(@"%s",__func__);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
     NSLog(@"%s",__func__);
}

//方法六： 当前视图(或者其父视图)将要被添加到Windowd的时候调用
- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
     NSLog(@"%s",__func__);
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
     NSLog(@"%s",__func__);
}

//方法七：
- (void)removeFromSuperview {
    [super removeFromSuperview];
    NSLog(@"%s",__func__);
}

//方法八：
- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
