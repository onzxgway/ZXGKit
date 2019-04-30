//
//  ZXGFillModeView.m
//  Quartz2D_CALayer_CAAnimation_HitTest
//
//  Created by san_xu on 2017/4/18.
//  Copyright © 2017年 com.zxg. All rights reserved.
//

#import "ZXGFillModeView.h"

@implementation ZXGFillModeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat one = self.progress * 100;
    CGFloat two = 100 - one;
    
    [self drawPieChart:@[@(one), @(two)] colors:@[[UIColor lightGrayColor], [UIColor blueColor]]];
}

- (void)drawPieChart:(nonnull NSArray *)percents colors:(nonnull NSArray<UIColor *>*)colors {
    
    CGFloat centerX = self.bounds.size.width * 0.5;
    CGFloat centerY = self.bounds.size.height * 0.5;
    CGFloat aBorder = CGRectGetWidth(self.bounds);
    CGFloat bBorder = CGRectGetHeight(self.bounds);
    
    CGFloat result = hypotf(aBorder, bBorder);
    
    CGFloat radius = result * 0.5;
    int clockwise = 0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat startAngle = 1.5 * M_PI;
    CGFloat endAngle = startAngle;
    for (int i = 0; i < percents.count; ++i) {
        startAngle = endAngle;
        endAngle = startAngle + [percents[i] floatValue]/100 * M_PI * 2;
        
        CGContextAddArc(ctx, centerX, centerY, radius, startAngle , endAngle, clockwise);
        CGContextAddLineToPoint(ctx, centerX, centerY);
        [colors[i] set];
        CGContextDrawPath(ctx, kCGPathFill);
    }
}


- (void)setProgress:(CGFloat)progress {
    
    if (_progress != progress) {
        _progress = MAX(0.0, MIN(1.0, progress));
        [self setNeedsDisplay];
    }
    
}

@end
