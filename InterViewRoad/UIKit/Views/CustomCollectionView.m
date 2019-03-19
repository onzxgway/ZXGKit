//
//  CustomCollectionView.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CustomCollectionView.h"
#import "ArmbandDecorationReusableView.h"

@implementation CustomCollectionView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 手动调整卡片视图和cell的层级关系
    NSMutableArray *sectionCardViews = [NSMutableArray array];
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:ArmbandDecorationReusableView.class]) {
            [sectionCardViews addObject:subview];
        }
    }
    
    for (UIView *subview in sectionCardViews) {
        [self bringSubviewToFront:subview];
    }

}

@end
