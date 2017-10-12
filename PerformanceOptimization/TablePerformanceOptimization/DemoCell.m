//
//  DemoCell.m
//  TablePerformanceOptimization
//
//  Created by 朱献国 on 12/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "DemoCell.h"
#import "YYWebImage.h"

@implementation DemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 利用 KVC 修改 imageView 的类型
        [self setValue:[[YYAnimatedImageView alloc] init] forKey:@"imageView"];
        
        // 1. 栅格化，美工的术语：将 cell 中的所有内容，生成一张独立的图像
        // 在屏幕滚动时，只显示图像
        self.layer.shouldRasterize = YES;
        // 栅格化，必须指定分辨率，否则默认使用 * 1，生成图像！
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // 2. 异步绘制！如果 cell 比较复杂，可以使用！
        self.layer.drawsAsynchronously = YES;
    }
    
    return self;
}

@end
