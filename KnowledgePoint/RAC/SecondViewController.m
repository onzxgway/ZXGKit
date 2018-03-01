//
//  SecondViewController.m
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondViewModel.h"
#import "Book.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passwork;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) SecondViewModel *secondViewModel;

@end

@implementation SecondViewController

- (SecondViewModel *)secondViewModel {
    if (!_secondViewModel) {
        _secondViewModel = [[SecondViewModel alloc] init];
    }
    return _secondViewModel;
}

// MVVM:
// VM:视图模型,处理界面上所有业务逻辑 每一个控制器对应一个VM模型
// VM:最好不要包括视图V
- (void)viewDidLoad {
    [super viewDidLoad];

    [self bindViewModel];
    [self loginEvent];
}

// 绑定viewModel
- (void)bindViewModel {
    RAC(self.secondViewModel, account) = _userName.rac_textSignal;
    RAC(self.secondViewModel, pwd) = _passwork.rac_textSignal;
}

// 登录事件
- (void)loginEvent {
    @weakify(self)

    RAC(self.loginBtn, enabled) = self.secondViewModel.loginBtnEnableSignal;

    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.secondViewModel.loginSignal execute:nil];
    }];

    RACSignal *signal = [self.secondViewModel.reqSignal execute:nil];

    [signal subscribeNext:^(id  _Nullable x) {

        NSArray *dictArr = x[@"books"];

        NSArray *models = [[dictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {

            return [Book bookWithDict:value];
        }] array];

        for (Book *book in models) {
            NSLog(@"name:%@", book.title);
        }
    }];

}

//07-ReactiveCocoa核心操作方法过滤
- (void)filter { // 过滤信号的某些值 = 忽略某些信号
    // 只有当我们文本框的内容长度大于5,才想要获取文本框的内容
    [[self.userName.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length >= 3 ;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)ignore { // 忽略某些信号

    // ignore:忽略一些值
    // ignoreValues:忽略所有的值

    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    // 2.忽略一些
//    RACSignal *ignoreSignal = [subject ignoreValues];
    RACSignal *ignoreSignal = [subject ignore:@"2"];

    // 3.订阅信号
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    // 4.发送数据
    [subject sendNext:@"13"];
    [subject sendNext:@"2"];
    [subject sendNext:@"44"];

}

- (void)take {
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    RACSubject *signal = [RACSubject subject];

    // take:取前面几个值
    // takeLast:取后面多少个值.必须要发送完成
    // takeUntil:只要传入信号发送完成或者发送任意数据,就不能再接收源信号的内容
    [[subject takeUntil:signal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    [subject sendNext:@"1"];
    [signal sendCompleted];

    [signal sendError:nil];

    [subject sendNext:@"2"];
    [subject sendNext:@"3"];

}

- (void)distinctUntilChanged {
    // distinctUntilChanged:如果当前的值跟上一个值相同,就不会被订阅到

    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"2"];
}

// skip 跳跃几个值
- (void)skip {
    RACSubject *subject = [RACSubject subject];

    [[subject skip:2] subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];

    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

//06-ReactiveCocoa核心操作方法组合
- (void)set {
    @weakify(self)
    RACSignal *combineSignal = [RACSignal combineLatest:@[_userName.rac_textSignal, _passwork.rac_textSignal] reduce:^id _Nonnull{
        @strongify(self);

        return @(self.userName.text.length && self.passwork.text.length);
    }];

    //    [combineSignal subscribeNext:^(NSNumber * _Nullable x) {
    //        @strongify(self);
    //        self.loginBtn.enabled = [x boolValue];
    //    }];

    RAC(self.loginBtn, enabled) = combineSignal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
