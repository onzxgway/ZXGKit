//
//  ZXGMomentsConst.h
//  Moments
//
//  Created by 朱献国 on 2018/5/2.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kTimeFontSize;           //时间字体大小
UIKIT_EXTERN CGFloat const maxContentLabelHeight;   // 根据具体font而定

//--------------间距--------------
UIKIT_EXTERN CGFloat const kTopBtmMargin;    //顶部和底部间距
UIKIT_EXTERN CGFloat const kLeftRightMargin; //左边和右边间距
UIKIT_EXTERN CGFloat const kHMargin;         //水平间距
UIKIT_EXTERN CGFloat const kVMargin;         //垂直间距
//卡片间距
UIKIT_EXTERN CGFloat const kCardHVMargin;    //间距


//--------------点赞评论view--------------
#define kZXGMomentsOperationMenuBGColor RGBA(68, 72, 78, 1) //背景颜色
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuH;//高度
UIKIT_EXTERN CGFloat const kZXGMomentsOperationMenuW;//宽度


//--------------字体大小--------------
UIKIT_EXTERN CGFloat const kNameFontSize;   // name字体大小
UIKIT_EXTERN CGFloat const kAvaterSize;     // 头像大小
UIKIT_EXTERN CGFloat const kContentFontSize;// 文本字体大小


//--------------宽度限制--------------
#define kNameWidth (SCREEN_WIDTH - kHMargin - 2 * kLeftRightMargin - kAvaterSize) // cell 名字最宽限制
#define kNameLeft (SCREEN_WIDTH - kNameWidth - kLeftRightMargin) // cell 名字最宽限制
