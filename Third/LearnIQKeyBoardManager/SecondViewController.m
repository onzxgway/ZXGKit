//
//  SecondViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/20.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "SecondViewController.h"
#import "TKeyBoardManager.h"

@interface SecondViewController ()
@property (nonatomic, strong) UITextField *tf; // <#备注#>
@end

@implementation SecondViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tf.frame = CGRectMake(88, 323, 168, 66);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[TKeyBoardManager sharedKeyBoardManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[TKeyBoardManager sharedKeyBoardManager] setEnable:YES];
}

#pragma mark - CreateViews

#pragma mark - Private

#pragma mark - Public

#pragma mark - LazyLoad
- (UITextField *)tf {
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        [self.view addSubview:_tf];
        _tf.placeholder = @"请您输入...";
    }
    return _tf;
}

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
