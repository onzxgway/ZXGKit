//
//  ZXGWebViewController.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/4/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGWebViewController.h"
#import "ZXGJSAndOCCallObject.h"

@interface ZXGWebViewController ()<ZXGServiceDelegate>
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) ZXGJSAndOCCallObject *callObject;
@end

@implementation ZXGWebViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Private
- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number {
    NSInteger i = [number integerValue];
    if (i < 0) {
        return [NSNumber numberWithInteger:0];
    }
    if (i == 0) {
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
    return [NSNumber numberWithInteger:r];
}

#pragma mark - Public

#pragma mark - LazyLoad
- (ZXGJSAndOCCallObject *)callObject {
    if (!_callObject) {
        _callObject = [[ZXGJSAndOCCallObject alloc] init];
        _callObject.delegate = self;
    }
    return _callObject;
}

#pragma mark - UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // JS主动调用OC
    
    // 方式一: 以 JSExport 协议关联 native(自定义的名称) 的方法
    self.context[@"native"] = self.callObject;
    
    // 方式二: 以 block 形式关联 JavaScript function
    self.context[@"log"] = ^(NSString *str) {
        NSLog(@"%@", str);
    };
    
    self.context[@"alert"] = ^(NSString *str) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"msg from js" message:str delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    };
    
    __block typeof(self) weakSelf = self;
    self.context[@"addSubView"] = ^(NSString *viewname) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(110, 50, 100, 100)];
        view.backgroundColor = [UIColor redColor];
        [weakSelf.view addSubview:view];
    };
    
    //多参数
    self.context[@"mutiParams"] = ^(NSString *a,NSString *b,NSString *c) {
        NSLog(@"%@ %@ %@",a,b,c);
    };
}

#pragma mark - ZXGServiceDelegate
//计算结果传递给JS
- (void)calculateWithNumber:(NSNumber *)number {
    NSLog(@"%@", number);
    
//    NSNumber *result = [self calculateFactorialOfNumber:number];
    NSInteger res = [number integerValue];
    NSNumber *result = @(++res);
    
    NSLog(@"%@", result);
    
    [self.context[@"showResult"] callWithArguments:@[result]];
}

- (void)pushViewController:(NSString *)view title:(NSString *)title {
    Class second = NSClassFromString(view);
    id secondVC = [[second alloc] init];
    ((UIViewController *)secondVC).title = title;
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
