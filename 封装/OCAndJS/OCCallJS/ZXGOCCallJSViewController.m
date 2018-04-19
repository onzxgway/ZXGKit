//
//  ZXGOCCallJSViewController.m
//  KnowledgePointDemo
//
//  Created by 朱献国 on 2018/4/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGOCCallJSViewController.h"

@interface ZXGOCCallJSViewController ()
@property (strong, nonatomic) JSContext *context;
@end

@implementation ZXGOCCallJSViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"test"]];
    
    _webView.userInteractionEnabled = NO;
    
    UILabel *show = [[UILabel alloc] init];
    show.textAlignment = NSTextAlignmentCenter;
    show.userInteractionEnabled = YES;
    show.backgroundColor = [UIColor blackColor];
    [self.view addSubview:show];
    show.frame = CGRectMake(100, 100, 80, 30);
    show.textColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendToJS:)];
    [show addGestureRecognizer:tap];
}

#pragma mark - CreateViews

#pragma mark - Private
- (NSString *)loadJsFile:(NSString*)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}

- (void)sendToJS:(UITapGestureRecognizer *)reg {
    
    NSNumber *inputNumber = [NSNumber numberWithInteger:arc4random_uniform(255)];
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue *result = [function callWithArguments:@[inputNumber]];
    UILabel *lab = (UILabel *)reg.view;
    lab.text = [NSString stringWithFormat:@"%@", [result toNumber]];
}

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
