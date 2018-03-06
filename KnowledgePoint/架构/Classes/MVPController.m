//
//  MVPController.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVPController.h"
#import "MVPPresenter.h"
#import "MVPView.h"

@interface MVPController ()
@property (nonatomic, strong) MVPView  *mVCView;
@property (nonatomic, strong) MVPPresenter *presenter;
@end

@implementation MVPController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    _mVCView = [MVPView new];
    [self.view addSubview:_mVCView];
    _mVCView.frame = CGRectMake(80, 80, 80, 80);

    _presenter = [[MVPPresenter alloc] init];
    _presenter.mVPView = _mVCView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
