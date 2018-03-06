//
//  MVVMViewModel.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVVMViewModel.h"

@implementation MVVMViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contentStr = @"";
    }
    return self;
}

- (void)clickEvent {
    [self netReq];
}

- (void)netReq {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mVVMModel.contentStr = @"哇哇哇";
    });

}

- (void)setMVVMModel:(MVVMModel *)mVVMModel {
    _mVVMModel = mVVMModel;

    [self.KVOController observe:_mVVMModel keyPath:@"contentStr" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSString *str = change[NSKeyValueChangeNewKey];
        if (str && ![str isKindOfClass:[NSNull class]]) {
            self.contentStr = str;
        }
    }];
}

@end
