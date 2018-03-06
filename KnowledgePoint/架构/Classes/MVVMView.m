//
//  MVVMView.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVVMView.h"

@interface MVVMView ()
@property (nonatomic, strong) UILabel *contentLab;
@end

@implementation MVVMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];

        _contentLab = [[UILabel alloc] init];
        _contentLab.userInteractionEnabled = YES;
        [self addSubview:_contentLab];
        _contentLab.frame = CGRectMake(0, 0, 80, 80);
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = [UIFont systemFontOfSize:14.f];
        _contentLab.textColor = [UIColor redColor];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [_contentLab addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapEvent {
    [_viewModel clickEvent];
}

- (void)setViewModel:(MVVMViewModel *)viewModel {
    _viewModel = viewModel;

    [self.KVOController observe:viewModel keyPath:@"contentStr" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSString *str = change[NSKeyValueChangeNewKey];
        _contentLab.text = str;
    }];
}

- (void)labChanged {

}

@end
