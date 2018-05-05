//
//  ZXGWindow.m
//  UIWindow
//
//  Created by feizhu on 2018/3/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGWindow.h"

@interface ZXGWindow ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UITextField *tf;
@end

@implementation ZXGWindow

//Window一旦被创建，会自动添加到界面上。
+ (instancetype)sharedWindow {
    static ZXGWindow *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithFrame:CGRectMake(50, 260, 220, 66)];
    });
    return _instance;
}

/**
 如果创建的Window需要处理键盘事件，那就需要将其设置为keyWindow,keyWindow是系统设计用来接收键盘和其他非触摸事件的Window。
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        self.btn.frame = CGRectMake(10, 10, 60, 20);
        [self.btn setTitle:@"Log in" forState:UIControlStateNormal];
        //
        self.tf = [[UITextField alloc] init];
        self.tf.frame = CGRectMake(10, 40, 60, 20);
        [self addSubview:self.tf];
        [self.tf setPlaceholder:@"请输入"];

        //
        self.backgroundColor = [UIColor redColor];

        self.windowLevel = UIWindowLevelAlert;
    }
    return self;
}

- (void)clicked {
    [self resignKeyWindow];
    self.hidden = YES;
}

- (void)show {
    [self makeKeyWindow];
    self.hidden = NO;
}

@end
