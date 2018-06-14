//
//  OneRefreshStateNormal.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/7.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshStateNormal.h"

@interface OneRefreshStateNormal () {
    UIImageView *_arrowImage;
}
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@end

@implementation OneRefreshStateNormal

- (void)prepare {
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews {
    [super placeSubviews];
    //***********设置箭头和圆圈的frame*************
    
    CGFloat width = MAX(self.stateLabel.textWidth, self.timeLabel.textWidth);
    CGFloat arrowCenterX = (self.width - width) * 0.5 - self.labelLeftInset;
    
//    if (self.arrowImage.constraints == 0) {
        self.arrowImage.center = CGPointMake(arrowCenterX, self.height * 0.5);
//    }
    
//    if (self.loadingView.constraints == 0) {
        self.loadingView.center = CGPointMake(arrowCenterX, self.height * 0.5);
//    }
    
    self.arrowImage.tintColor = self.stateLabel.textColor;
}

- (void)setStatus:(OneRefreshStatus)status {
    OneRefreshStatus oldState = self.status;
    if (status == oldState) return;
    [super setStatus:status];
    
    if (status == OneRefreshStatusNormal) {
        if (oldState == OneRefreshStatusPulling) {
            [self.loadingView stopAnimating];
            self.arrowImage.hidden = NO;
            [UIView animateWithDuration:OneRefreshFastDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
        else if (oldState == OneRefreshStatusRefreshing) {
            self.arrowImage.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:OneRefreshSlowDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowImage.hidden = NO;
            }];
        }
    }
    else if (status == OneRefreshStatusPulling) {
        [self.loadingView stopAnimating];
        self.arrowImage.hidden = NO;
        [UIView animateWithDuration:OneRefreshFastDuration animations:^{
            self.arrowImage.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (status == OneRefreshStatusRefreshing) {
        [self.loadingView startAnimating];
        self.arrowImage.hidden = YES;
    }
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        [self addSubview:_arrowImage = [[UIImageView alloc] initWithImage:[NSBundle arrowImage]]];
    }
    return _arrowImage;
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        [self addSubview:_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle]];
        _loadingView.hidesWhenStopped = YES;
    }
    return _loadingView;
}

@end
