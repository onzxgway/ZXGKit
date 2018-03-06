//
//  MVVMController.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVVMController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"
#import "MVVMModel.h"

@interface MVVMController ()
@property (nonatomic, strong) MVVMView  *mView;
@property (nonatomic, strong) MVVMViewModel *viewModel;
@property (nonatomic, strong) MVVMModel *mModel;
@end

@implementation MVVMController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    

    _mView = [MVVMView new];
    [self.view addSubview:_mView];
    _mView.frame = CGRectMake(80, 80, 80, 80);

    _viewModel = [MVVMViewModel new];
    _mView.viewModel = _viewModel;
    _viewModel.mVVMModel = [MVVMModel new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
