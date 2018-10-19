//
//  LeftViewController.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/18.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "LeftViewController.h"
#import "TestView.h"

@interface LeftViewController ()
@property (nonatomic, strong) TestView *testView;
@end

@implementation LeftViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

// 指定初始化方法   便利初始化方法
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%s", __func__);
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _testView = [TestView new];
    _testView = [[[NSBundle mainBundle] loadNibNamed:@"TestView" owner:nil options:nil] firstObject];
    [self.view addSubview:_testView];
    _testView.frame = CGRectMake(36, 106, 266, 108);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%ld", _testView.count);
    [_testView setNeedsLayout]; // 该方法是异步执行
    [_testView layoutIfNeeded]; // 该方法让上句代码变为同步执行
    NSLog(@"%ld", _testView.count);
}

@end
