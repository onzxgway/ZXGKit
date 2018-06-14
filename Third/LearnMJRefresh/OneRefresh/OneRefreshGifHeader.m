//
//  OneRefreshGifHeader.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/9.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshGifHeader.h"

@interface OneRefreshGifHeader () {
    UIImageView *_gifImage;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation OneRefreshGifHeader

- (void)prepare {
    [super prepare];
    
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.gifImage.constraints.count) return;
    
    self.gifImage.frame = self.bounds;
    
    CGFloat width = MAX(self.stateLabel.textWidth, self.timeLabel.textWidth);
    CGFloat gifImageW = (self.width - width) * 0.5 - self.labelLeftInset;
    
    self.gifImage.width = gifImageW;
}

- (void)setAlphaPercent:(CGFloat)alphaPercent {
    [super setAlphaPercent:alphaPercent];
    
    NSArray *images = self.stateImages[@(OneRefreshStatusNormal)];
    if (self.status != OneRefreshStatusNormal || images.count == 0) return;
    // 停止动画
    [self.gifImage stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * alphaPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifImage.image = images[index];
}


- (void)setStatus:(OneRefreshStatus)status {
    OneRefreshStatus oldState = self.status;
    if (status == oldState) return;
    [super setStatus:status];
    
    // 根据状态做事情
    if (status == OneRefreshStatusPulling || status == OneRefreshStatusRefreshing) {
        NSArray *images = self.stateImages[@(status)];
        if (images.count == 0) return;
        
        [self.gifImage stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifImage.image = [images lastObject];
        }
        else { // 多张图片
            self.gifImage.animationImages = images;
            self.gifImage.animationDuration = [self.stateDurations[@(status)] doubleValue];
            [self.gifImage startAnimating];
        }
    } else if (status == OneRefreshStatusNormal) {
        [self.gifImage stopAnimating];
    }
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(OneRefreshStatus)state {
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.height) {
        self.height = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(OneRefreshStatus)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

- (UIImageView *)gifImage {
    if (!_gifImage) {
        [self addSubview:_gifImage = [[UIImageView alloc] init]];
        _gifImage.contentMode = UIViewContentModeRight;
    }
    return _gifImage;
}

- (NSMutableDictionary *)stateImages {
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations {
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

@end
