//
//  ZXGDatePickerView.h
//  eStudy(comprehensive)
//
//  Created by 朱献国 on 2018/5/14.
//  Copyright © 2018年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGPickerViewComponent : UIView

@property (nonatomic) NSTimeInterval duration;                      // pickView从底部动画出现的时间
@property (nonatomic) CGFloat coverAlpha;                           // 遮罩的透明度
@property (nonatomic, strong) UIColor *coverColor;                  // 遮罩的颜色
@property (nonatomic, strong) UIColor *pickerViewBackgroundColor;   // pickerView的背景颜色
/**
 *  pickerView的高度占屏幕的百分比 值为 0 -> 1 ,0是没有高度,1是和屏幕高度一致
 */
@property (assign, nonatomic) CGFloat  screenHeightPercent;

@property (nonatomic, copy  ) void(^pickViewSelectedDateCallback)(NSString *date);

- (void)show;

- (void)hide;

@end
