//
//  MVCController.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVCController.h"
#import "MVCView.h"
#import "MVCModel.h"

@interface MVCController () <MVCViewDelegate>
@property (nonatomic, strong) MVCView  *mVCView;
@property (nonatomic, strong) MVCModel *mVCModel;
@end

@implementation MVCController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mVCView = [MVCView new];
    [self.view addSubview:_mVCView];
    _mVCView.delegate = self;
    _mVCView.frame = CGRectMake(80, 80, 80, 80);

}

- (void)netReq {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mVCModel = [MVCModel new];
        _mVCModel.contentStr = @"hahahaha";

        _mVCView.mVCModel = _mVCModel;
    });
}

- (void)mVCViewTapEvent:(UIView *)mVCView {
    [self netReq];
}

@end
