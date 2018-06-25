//
//  ZXGExpandAbleLabel.h
//  UITabBarViewController
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGExpandAbleLabel : UILabel

@property (nonatomic) NSUInteger foldLines;                     // 折叠行数, 默认2
@property (nonatomic, weak  , readonly) UIButton *expandBtn;    // 展开\折叠Button, 可设置一些属性

@end
