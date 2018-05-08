//
//  ZXGMomentsConst.h
//  Moments
//
//  Created by 朱献国 on 2018/5/2.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

//--------------间距--------------
UIKIT_EXTERN CGFloat const kTopBtmMargin;           // 顶部和底部间距
UIKIT_EXTERN CGFloat const kLeftRightMargin;        // 最左边和右边距离屏幕边缘的间距
UIKIT_EXTERN CGFloat const kHMargin;                // 控件之间水平间距
UIKIT_EXTERN CGFloat const kVMargin;                // 控件之间垂直间距
UIKIT_EXTERN CGFloat const kCardHVMargin;           // 卡片间距
UIKIT_EXTERN CGFloat const kMomentsCellPaddingPic;  // cell 多张图片中间留白
UIKIT_EXTERN CGFloat const kMomentsCellPaddingCom;  // cell 多条评论中间留白
UIKIT_EXTERN CGFloat const kMomentsCellPaddingComH; // cell 多条评论中间留白 水平

UIKIT_EXTERN CGFloat const kMomentsCellPaddingText; // cell 文本与其他元素间留白

//--------------点赞评论view--------------
#define kZXGMomentsOperationMenuBGColor RGBA(68, 72, 78, 1) //背景颜色
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuH;       //高度
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuW;       //宽度


//--------------字体大小--------------
#define kMomentsNameColor RGB(84, 95, 141)  // name字体颜色
UIKIT_EXTERN CGFloat const kNameFontSize;   // name字体大小
UIKIT_EXTERN CGFloat const kAvaterSize;     // 头像尺寸
UIKIT_EXTERN CGFloat const kContentFontSize;// 文本字体大小
UIKIT_EXTERN CGFloat const kLoctionFontSize;// 位置字体大小
UIKIT_EXTERN CGFloat const kTimeFontSize;   // 日期字体大小
UIKIT_EXTERN CGFloat const kComFontSize;    // 评论字体大小

//--------------内容--------------
#define kMomentsLineColor RGB(228, 224, 228)                                                // 分割线颜色
#define kMomentsCardAndCommentColor RGB(242, 242, 245)                                      // 卡片,评论背景颜色
#define kMomentsContentWidth (SCREEN_WIDTH - kHMargin - 2 * kLeftRightMargin - kAvaterSize) // cell 内容宽度
#define kMomentsContentLeft (SCREEN_WIDTH - kMomentsContentWidth - kLeftRightMargin)        // cell 内容的左边
#define kMomentsCardH (kCardHVMargin * 2 + kAvaterSize)                                     // 卡片高度
#define kMomentsCardHighlightColor  RGB(212, 212, 212)                                      // 卡片高亮时灰色
#define kMomentsTextHighlightBackgroundColor kLightGrayColor
