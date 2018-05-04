//
//  ZXGMomentsConst.h
//  Moments
//
//  Created by 朱献国 on 2018/5/2.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const maxContentLabelHeight;   // 根据具体font而定

//--------------间距--------------
UIKIT_EXTERN CGFloat const kTopBtmMargin;           // 顶部和底部间距
UIKIT_EXTERN CGFloat const kLeftRightMargin;        // 最左边和右边距离屏幕边缘的间距
UIKIT_EXTERN CGFloat const kHMargin;                // 控件之间水平间距
UIKIT_EXTERN CGFloat const kVMargin;                // 控件之间垂直间距

UIKIT_EXTERN CGFloat const kCardHVMargin;           // 卡片间距

UIKIT_EXTERN CGFloat const kMomentsCellPaddingPic;  // cell 多张图片中间留白

//--------------点赞评论view--------------
#define kZXGMomentsOperationMenuBGColor RGBA(68, 72, 78, 1) //背景颜色
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuH;//高度
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuW;//宽度


//--------------字体大小--------------
UIKIT_EXTERN CGFloat const kNameFontSize;   // name字体大小
UIKIT_EXTERN CGFloat const kAvaterSize;     // 头像尺寸
UIKIT_EXTERN CGFloat const kContentFontSize;// 文本字体大小
UIKIT_EXTERN CGFloat const kLoctionFontSize;// 位置字体大小
UIKIT_EXTERN CGFloat const kTimeFontSize;   // 日期字体大小

//--------------内容--------------
#define kMomentsContentWidth (SCREEN_WIDTH - kHMargin - 2 * kLeftRightMargin - kAvaterSize) // cell 内容宽度
#define kMomentsContentLeft (SCREEN_WIDTH - kMomentsContentWidth - kLeftRightMargin)        // cell 内容的左边
#define kMomentsCardH (kCardHVMargin * 2 + kAvaterSize)                                     // 卡片高度
