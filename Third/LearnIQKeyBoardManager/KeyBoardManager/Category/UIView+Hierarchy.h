//
//  UIView+Hierarchy.h
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/20.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Hierarchy)

- (UIViewController *)topMostController;

- (UIViewController *)viewContainingController;

- (UIScrollView*)superScrollView;

@end
