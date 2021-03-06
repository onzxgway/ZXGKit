//
//  ZXGCustomTextView.h
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGTextView : UITextView

@property (nonatomic, copy  ) NSString *placeholder;        // 占位文字

@property (nonatomic, strong) UIColor *placeholderColor;    // 占位文字的颜色

@property (nonatomic) CGPoint placePoint;                   // 占位符的文字位置

@end




typedef void(^TextHeightChangeBlock)(CGFloat);

@interface ZXGCustomTextView : UIView

@property (nonatomic) CGFloat v_margin;                 //竖直方向上下间距 默认为10
@property (nonatomic) CGFloat h_margin;                 //水平方向上下间距 默认为0
@property (nonatomic) NSInteger initLine;               //初始需要展示的行数 默认为1
@property (nonatomic) NSInteger maxLine;                //最大行数 默认为无穷大
@property (nonatomic, copy  ) NSString *placeholder;    //占位文字
@property (nonatomic, strong) UIFont *font;             //默认为17
@property (nonatomic) CGPoint placePoint;               //设置占位符的位置，竖直方向设置v_margin即可  CGPointMake(5, 0);//占位文字的起始位置

@property (nonatomic, copy  ) TextHeightChangeBlock textHeightChangeBlock;

@end
