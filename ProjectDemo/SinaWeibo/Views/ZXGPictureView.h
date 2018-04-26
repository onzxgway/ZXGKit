//
//  ZXGPictureView.h
//  SinaWeibo
//
//  Created by 朱献国 on 2018/4/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGPictureView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy  ) void (^touchBlock)(ZXGPictureView *, YYGestureRecognizerState state, NSSet *touches, UIEvent *);
@property (nonatomic, copy  ) void (^longPressBlock)(ZXGPictureView *, CGPoint);

@end
