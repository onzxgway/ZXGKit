//
//  ZXGPictureView.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/5/4.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGPictureView.h"

@interface ZXGPictureView () {
    UIImage *_image;
}

@end

@implementation ZXGPictureView

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

@end
