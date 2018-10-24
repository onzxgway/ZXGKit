//
//  UIView+HitTest.h
//  Event
//
//  Created by 朱献国 on 2018/10/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HitTest)
    
- (UIView *)hitTest:(CGPoint)point event:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
