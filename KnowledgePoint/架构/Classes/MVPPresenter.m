//
//  MVPPresenter.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVPPresenter.h"
#import "MVPModel.h"

@interface MVPPresenter ()<MVPViewDelegate>
@property (nonatomic, strong) MVPModel *mVCModel;
@end

@implementation MVPPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)netReq {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mVCModel = [MVPModel new];
        _mVCModel.contentStr = @"hahahaha";

        _mVPView.contentStr = _mVCModel.contentStr;
    });

}

- (void)setMVPView:(MVPView *)mVPView {
    _mVPView = mVPView;
    _mVPView.delegate = self;
}

- (void)mVCViewTapEvent:(UIView *)mVPView {
    [self netReq];
}

@end
