//
//  ViewController.m
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TableViewController.h"
#import "SecondViewController.h"

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTF;
@property (weak, nonatomic) IBOutlet UILabel *myLab;
@property (weak, nonatomic) IBOutlet UILabel *btmLab;

@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UITextField *leftTf;
@property (nonatomic, strong) UIButton *topBtn;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat h = 36;
    CGFloat sH = [UIScreen mainScreen].bounds.size.height;

    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topBtn setTitle:@"Next" forState:UIControlStateNormal];
        _topBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_topBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _topBtn.frame = CGRectMake(20, 60, 60, h);
        [_topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_topBtn];

    if (!_leftTf) {
        _leftTf = [[UITextField alloc] init];
        _leftTf.frame = CGRectMake(20, sH - h - 20, 120, h);
        _leftTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    [self.view addSubview:_leftTf];

    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"Clear" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(CGRectGetMaxX(_leftTf.frame) + 20, sH - h - 20, 60, h);
    }
    [self.view addSubview:_rightBtn];

    [self set];
}

//06-ReactiveCocoa核心操作方法组合
- (void)set {
    [self zip];
}

- (void)zip {//等所有信号都发送内容的时候才会调用订阅者的block
    // zipWith:夫妻关系
    // 创建信号A
    RACSubject *signalA = [RACSubject subject];

    // 创建信号B
    RACSubject *signalB = [RACSubject subject];

    // 压缩成一个信号
    // zipWith:当一个界面多个请求的时候,要等所有请求完成才能更新UI
    // zipWith:等所有信号都发送内容的时候才会调用
    RACSignal *zipSignal = [signalA zipWith:signalB];

    // 订阅信号
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    // 发送信号
    [signalB sendNext:@2];
    [signalA sendNext:@1];

}

// 任意一个信号请求完成都会订阅到
- (void)merge {
    // 创建信号A
    RACSubject *signalA = [RACSubject subject];

    // 创建信号B
    RACSubject *signalB = [RACSubject subject];

    // 组合信号
    RACSignal *mergeSiganl = [signalA merge:signalB];

    // 订阅信号
    [mergeSiganl subscribeNext:^(id x) {
        // 任意一个信号发送内容都会来这个block
        NSLog(@"%@",x);
    }];

    // 发送数据
    [signalB sendNext:@"下部分"];
    [signalA sendNext:@"上部分"];
}

- (void)then {//then:创建组合信号 忽略掉第一个信号所有值

    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送上部分请求");

        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送下部分请求");

        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];

    // 创建组合信号
    // then:忽悠掉第一个信号所有值
    RACSignal *thenSiganl = [signalA then:^RACSignal * _Nonnull{
        // 返回信号就是需要组合的信号
        return signalB;
    }];

    // 订阅信号
    [thenSiganl subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];
}

- (void)concat {// 组合

    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送上部分请求");

        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送下部分请求");

        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];

    // concat:按顺序去连接
    // 注意:concat,第一个信号必须要调用sendCompleted
    // 创建组合信号
    RACSignal *totalSignal = [signalA concat:signalB];

    // 订阅组合信号
    [totalSignal subscribeNext:^(id  _Nullable x) {
        // 既能拿到A信号的值,又能拿到B信号的值
        NSLog(@"%@",x);
    }];

}

//05-ReactiveCocoa核心操作方法映射
- (void)map {
    RACSubject *subject = [RACSubject subject];

//    把源信号的值映射成一个新的值
    RACSignal *signal = [subject map:^id _Nullable(NSNumber * _Nullable value) {
        NSInteger tempValue = [value integerValue];
        return @(++tempValue);
    }];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"map:%@",x);
    }];

    [subject sendNext:@123];
    [subject sendNext:@13];
}

- (void)flattenMap {
    RACSubject *subject = [RACSubject subject];
//    把源信号的值映射成一个新的信号
    RACSignal *signal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal return:value];
    }];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"flattenMap:%@",x);
    }];

    [subject sendNext:@123];
    [subject sendNext:@13];
}

//04-ReactiveCocoa核心操作方法bind
- (void)bind {
    //给RAC中的信号进行绑定，只要信号一发送数据，就能监听到，从而把发送数据改成自己想要的数据
    //在开发中很少使用bind方法，bind属于RAC中的底层方法，RAC已经封装了很多好用的其他方法，底层都是调用bind，用法比bind简单.
    RACSubject *subject = [RACSubject subject];
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal * _Nullable (NSString * _Nullable value, BOOL *stop) {
            NSLog(@"原信号的内容:%@",value);

            value = [value substringFromIndex:2];

            return [RACSignal return:value];
        };
    }];

    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"绑定信号处理完的内容:%@",x);
    }];

    [subject sendNext:@"zxg"];

    /**
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    RACSignal *signal = [subject bind:^RACSignalBindBlock _Nonnull{
        // block调用时刻:只要绑定信号被订阅就会调用
        return ^RACSignal *(id value, BOOL *stop) {
            // block调用:只要源信号发送数据,就会调用block
            // block作用:处理源信号内容
            // value:源信号发送的内容
            NSLog(@"原信号的内容:%@",value);

            value = [NSString stringWithFormat:@"xmg:%@",value];
            // 返回信号,不能传nil,返回空信号[RACSignal empty]
            return [RACSignal return:value];
        };
    }];

    // 2.订阅绑定信号
    [signal subscribeNext:^(id  _Nullable x) {
        // blcok:当处理完信号发送数据的时候,就会调用这个Block
        NSLog(@"绑定信号处理完的内容:%@",x);
    }];

    // 3.发送数据
    [subject sendNext:@"123"];
     */
}

//11-RAC开发中常见用法
- (void)RACMethods {

    //捕获按钮的事件
    @weakify(self);
    [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.leftTf.text = nil;
    }];

    //捕获文本框的事件
    [[_leftTf rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 0) {
            self.rightBtn.enabled = YES;
            [self.rightBtn setTitle:@"Clear" forState:UIControlStateNormal];
        }
        else {
            self.rightBtn.enabled = NO;
            [self.rightBtn setTitle:@"禁用" forState:UIControlStateNormal];
        }
    }];

    //KVO
    [[_leftTf rac_valuesAndChangesForKeyPath:@"text" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id key, NSDictionary *value) = x;

        if (value[@"new"] && [@"" isEqualToString:value[@"new"]]) {
            self.rightBtn.enabled = NO;
            [self.rightBtn setTitle:@"禁用" forState:UIControlStateNormal];
        }

    }];

    //通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x.name);
    }];


}

- (void)topBtnClick {
    //代理 1.RACSubject 2.rac_signalForSelector
    SecondViewController *ctrl = [[SecondViewController alloc] init];
    @weakify(self)
    [[ctrl rac_signalForSelector:@selector(backBtnClick)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:ctrl animated:YES];
}

//03-RACCommand
//RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。使用场景:监听按钮点击，网络请求
- (void)RACCommand {

    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

        NSLog(@"执行命令");
        /**
         RACCommand使用注意:
          1.signalBlock必须要返回一个信号，不能传nil.
          2.如果不想要传递信号，直接创建空的信号[RACSignal empty]
          3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
         */

        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];

            // 发送完成
            [subscriber sendCompleted];

            return nil;
        }];
    }];
    _command = command;

    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        [x subscribeNext:^(id x) {

            NSLog(@"%@",x);
        }];
    }];

    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) { // 当前正在执行
            NSLog(@"当前正在执行");
        }
        else{
            NSLog(@"执行完成/没有执行");
        }
    }];

    [command execute:@12345];
}

//02-RACMulticastConnection
//用于当一个信号，被多次订阅时，为了避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。
- (void)RACMulticastConnection {

    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送热门模块的请求");

        [subscriber sendNext:@"😝"];

        return nil;
    }];

//    RACMulticastConnection *connect = [signal publish];
    RACMulticastConnection *connect = [signal multicast:[RACSubject subject]];

    // 订阅连接类信号
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者1:%@",x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者2:%@",x);
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者3:%@",x);
    }];

    [connect connect];

    /**
    // 每订阅一次，就创建一个订阅者
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一%@",x);
    }];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二%@",x);
    }];
     */
}

//01-ReactiveCocoa常见宏
- (void)RACMacro {

    // 1.RAC 作用：把对象的某个属性和信号绑定在一起，信号发送的值自动赋值给该属性。
    RAC(_myLab, text) = _myTF.rac_textSignal;

    // 2.RACObserve 作用：监听对象的属性的值改变，略等于 KVO，返回的是信号
    // 3.weakify 和 strongify 作用：避免对象循环引用导致的内存泄漏
    @weakify(self)
    [RACObserve(_myLab, text) subscribeNext:^(id  _Nullable x) {
        @strongify(self)

        self.btmLab.text = x;
    }];
    
    // 4.RACTuplePack 作用：把数据类型封装成元组
    RACTuple *tuple = RACTuplePack(@"1",@123,@"3",@"4");
    NSLog(@"%@",tuple.last);

    // 5.RACTupleUnPack 作用：把元组解包为基本数据
    RACTupleUnpack(NSString *a, NSNumber *b, NSString *c, NSString *d) = tuple;
    NSLog(@"_%@_%@_%@_%@_", a, b, c, d);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
