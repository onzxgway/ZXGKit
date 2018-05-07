//
//  ZXGArrowTopLayer.m
//  Moments
//
//  Created by 朱献国 on 2018/5/7.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGArrowTopLayer.h"

@implementation ZXGArrowTopLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, RGB(242, 242, 245).CGColor);
    // 设置起点
    CGContextMoveToPoint(ctx, self.width * 0.5, 0);
    // 从(50, 0)连线到(0, 100)
    CGContextAddLineToPoint(ctx, 0, self.height);
    // 从(0, 100)连线到(100, 100)
    CGContextAddLineToPoint(ctx, self.width, self.height);
    // 合并路径，连接起点和终点
    CGContextClosePath(ctx);
    // 绘制路径
    CGContextFillPath(ctx);
}

@end
