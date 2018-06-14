//
//  ViewController.m
//  ScrollView 键盘回收
//
//  Created by 朱献国 on 2018/6/14.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

/**
 
 //0.设置ScrollView的keyboardDismissMode属性(前提是ScrollView可以滚动)
 self.ScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
 
 //1.自定义ScrollView类，在内部重写touchesBegan等方法。
 
 //2.加蒙版
 
 //3.ScrollView加手势,设置cancelsTouchesInView = NO;
 
 */

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView; // <#备注#>

@property (nonatomic, strong) UIButton *resign; // <#备注#>

@property (nonatomic, strong) UIButton *test; // <#备注#>

@property (nonatomic, strong) UITextField *tf; // <#备注#>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}


- (void)createView {
    self.view.backgroundColor = [UIColor greenColor];
    self.scrollView.frame = self.view.bounds;
    
    self.resign.frame = CGRectMake(66, 66, 66, 22);
    self.test.frame = CGRectMake(156, 66, 66, 22);
    
    self.tf.frame = CGRectMake(66, 188, 260, 22);
    
    // 增加tap手势，点击使退出键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoardTap)];
    tapGesture.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapGesture];
}

- (void)dismissKeyBoardTap {
    NSLog(@"dismissKeyBoardTap");
    
    [_tf resignFirstResponder];
}

- (void)dismissKeyBoardBtn {
    NSLog(@"dismissKeyBoardBtn");
    
//    [_tf resignFirstResponder];
}

- (void)testBtn {
    NSLog(@"testBtnClicked");
}

- (void)testTap {
    NSLog(@"testTap");
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        [self.view addSubview:_scrollView = [[UIScrollView alloc] init]];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _scrollView.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height * 2);
    }
    return _scrollView;
}

- (UIButton *)resign {
    if (!_resign) {
        _resign = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:_resign];
        _resign.titleLabel.font = [UIFont systemFontOfSize:11];
        [_resign setTitle:@"辞退键盘" forState:UIControlStateNormal];
        [_resign addTarget:self action:@selector(dismissKeyBoardBtn) forControlEvents:UIControlEventTouchUpInside];
        [_resign setBackgroundColor:[UIColor blueColor]];
    }
    return _resign;
}

- (UIButton *)test {
    if (!_test) {
        _test = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:_test];
        _test.titleLabel.font = [UIFont systemFontOfSize:11];
        [_test setTitle:@"事件响应" forState:UIControlStateNormal];
        [_test addTarget:self action:@selector(testBtn) forControlEvents:UIControlEventTouchUpInside];
        [_test setBackgroundColor:[UIColor blueColor]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testTap)];
        tapGesture.cancelsTouchesInView = NO;
        [_test addGestureRecognizer:tapGesture];
    }
    return _test;
}

- (UITextField *)tf {
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        [self.view addSubview:_tf];
        _tf.placeholder = @"请输入";
    }
    return _tf;
}

@end
