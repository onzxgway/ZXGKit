//
//  NewRefreshNormalHeader.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshNormalHeader.h"

@interface NewRefreshNormalHeader ()

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation NewRefreshNormalHeader


- (void)addSubViews {
    [super addSubViews];
    
    [self addSubview:self.headerImg];
    [self addSubview:self.indicatorView];
}

- (void)placeSubViews {
    [super placeSubViews];
    
    CGFloat w = MAX(self.stateLab.textWidth, self.timeLab.textWidth);
    
    CGPoint point = CGPointMake((self.nr_w - w) * 0.5 * 0.5, self.nr_h * 0.5);
    
    self.headerImg.center = point;
    self.headerImg.size = self.headerImg.image.size;
    
    self.indicatorView.center = point;
    self.indicatorView.size = self.headerImg.image.size;
    
}

- (void)setState:(NRRefreshState)state {
    [super setState:state];
    
    if (state == NRRefreshStateIdle) {
        
        [self.indicatorView stopAnimating];
        self.indicatorView.hidden = YES;
        self.headerImg.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.1 animations:^{
            self.headerImg.hidden = NO;
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (state == NRRefreshStateRefreshing) {
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
        [UIView animateWithDuration:0.1 animations:^{
            
        } completion:^(BOOL finished) {
            self.headerImg.hidden = YES;
        }];
    }
    else if (state == NRRefreshStatePulling) {
        self.headerImg.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.headerImg.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = YES;
        }];
    }
    
}

- (UIImageView *)headerImg {
    if (!_headerImg) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        img.clipsToBounds = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        
        _headerImg = img;
    }
    return _headerImg;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

@end
