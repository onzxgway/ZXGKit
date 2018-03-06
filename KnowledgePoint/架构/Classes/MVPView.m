//
//  MVPView.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MVPView.h"

@interface MVPView ()
@property (nonatomic, strong) UILabel *contentLab;
@end

@implementation MVPView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];

        _contentLab = [[UILabel alloc] init];
        _contentLab.userInteractionEnabled = YES;
        [self addSubview:_contentLab];
        _contentLab.frame = CGRectMake(0, 0, 80, 80);
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.font = [UIFont systemFontOfSize:14.f];
        _contentLab.textColor = [UIColor redColor];
        _contentLab.text = @"初始化";

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [_contentLab addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapEvent {
    if (_delegate && [_delegate respondsToSelector:@selector(mVCViewTapEvent:)]) {
        [_delegate mVCViewTapEvent:self];
    }
}

- (void)setContentStr:(NSString *)contentStr {
    _contentLab.text = contentStr;
}

@end
