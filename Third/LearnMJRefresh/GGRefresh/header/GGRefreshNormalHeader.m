//
//  GGRefreshNormalHeader.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshNormalHeader.h"

@interface GGRefreshNormalHeader (){
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation GGRefreshNormalHeader

- (void)placeSubviews {
    [super placeSubviews];
    
    CGFloat w = MAX(self.stateLab.textWidth, self.timeLab.textWidth);
    
    CGPoint point = CGPointMake((self.gg_width - w) * 0.5 * 0.5, self.gg_height * 0.5);
    
    self.arrowView.center = point;
    self.arrowView.size = self.arrowView.image.size;
    
    self.loadingView.center = point;
    self.loadingView.size = self.arrowView.image.size;
}

- (void)setState:(GGRefreshState)state {
    GGRefreshState oldState = self.state;
    if (oldState == state) return;
    [super setState:state];
    
    // 根据状态做事情
    if (state == GGRefreshStateIdle) {
        if (oldState == GGRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != GGRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    else if (state == GGRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    }
    else if (state == GGRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

#pragma mark - 懒加载子控件

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}


@end
