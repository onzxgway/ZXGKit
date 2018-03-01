//
//  SecondViewModel.m
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "SecondViewModel.h"

@implementation SecondViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {

    @weakify(self)
    _loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id _Nonnull{
        @strongify(self);
        
        return @(self.account.length > 0 && self.pwd.length > 0);
    }];

    _loginSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

        NSLog(@"发送登录请求");

        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                // 发送数据
                [subscriber sendNext:@"登录的数据"];
                [subscriber sendCompleted];
            });

            return nil;
        }];
    }];

    // 3.处理登录请求返回的结果
    [[_loginSignal.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

    [_loginSignal.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行 显示蒙版
            NSLog(@"正在执行");
        }
        else {
            // 执行完成 隐藏蒙版
            NSLog(@"执行完成");
        }
    }];

    _reqSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

            // 创建请求管理者
            AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            }];

            /**
            // 1.创建一个网络路径
            NSString *str = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@", [@"美女" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            NSURL *url = [NSURL URLWithString:str];
            // 2.创建一个网络请求
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            // 3.获得会话对象
            NSURLSession *session = [NSURLSession sharedSession];
            // 4.根据会话对象，创建一个Task任务：
            NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                NSLog(@"从服务器获取到数据:%@",data);

                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }];
            // 5.最后一步，执行任务（resume也是继续执行）
            [sessionDataTask resume];
            */

            return nil;
        }];
    }];
}

@end
