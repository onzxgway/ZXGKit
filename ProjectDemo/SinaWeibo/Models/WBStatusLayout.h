//
//  WBStatusLayout.h
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBModel.h"

/// 风格
typedef NS_ENUM(NSUInteger, WBLayoutStyle) {
    WBLayoutStyleTimeline = 0, ///< 时间线 (目前只支持这一种)
    WBLayoutStyleDetail,       ///< 详情页
};

#define kWBCellBackgroundColor HEXCOLOR(0xf2f2f2)    // Cell背景灰色

/**
 一个 Cell 的布局模型。
 布局排版应该在后台线程完成。
 */
@interface WBStatusLayout : NSObject

- (instancetype)initWithStatus:(WBStatus *)status style:(WBLayoutStyle)style;

// 以下是数据
@property (nonatomic, strong) WBStatus *status;
@property (nonatomic, assign) WBLayoutStyle style;

//以下是布局结果

// 顶部留白
@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

// 标题栏
@property (nonatomic, assign) CGFloat titleHeight; //标题栏高度，0为没标题栏
@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏

@end
