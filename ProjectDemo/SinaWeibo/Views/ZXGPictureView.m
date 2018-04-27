//
//  ZXGPictureView.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/4/26.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGPictureView.h"

@interface ZXGPictureView ()

@end

@implementation ZXGPictureView {
    UIImage *_image;
    CGPoint _point;
    NSTimer *_timer;
    BOOL _longPressDetected;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.layer.contents = (id)image.CGImage;
}

- (UIImage *)image {
    id content = self.layer.contents;
    if (content != (id)_image.CGImage) {
        CGImageRef ref = (__bridge CGImageRef)(content);
        if (ref && CFGetTypeID(ref) == CGImageGetTypeID()) {
            _image = [UIImage imageWithCGImage:ref scale:self.layer.contentsScale orientation:UIImageOrientationUp];
        } else {
            _image = nil;
        }
    }
    return _image;
}

- (void)dealloc {
    [self endTimer];
}

- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timerFire) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerFire {
    [self touchesCancelled:[NSSet set] withEvent:nil];
    _longPressDetected = YES;
    if (_longPressBlock) _longPressBlock(self, _point);
    [self endTimer];
}

@end
