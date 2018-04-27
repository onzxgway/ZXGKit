//
//  WBStatusLayout.h
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBModel.h"
#import "ZXGTableViewCellModelAble.h"
// 风格
typedef NS_ENUM(NSUInteger, WBLayoutStyle) {
    WBLayoutStyleTimeline = 0, // 时间线 (目前只支持这一种)
    WBLayoutStyleDetail,       // 详情页
};

// 宽高
static CGFloat const kWBCellTopMargin = 8;      // cell 顶部灰色留白
static CGFloat const kWBCellTitleHeight = 36;   // cell 标题高度 (例如"仅自己可见")
static CGFloat const kWBCellProfileHeight = 56; // cell 用户资料高度

static CGFloat const kWBCellPadding = 12;       // cell 内边距
static CGFloat const kWBCellPaddingText = 10;   // cell 文本与其他元素间留白
static CGFloat const kWBCellPaddingPic = 4;    // cell 多张图片中间留白
static CGFloat const kWBCellCardHeight = 70;    // cell card 视图高度
static CGFloat const kWBCellNamePaddingLeft = 14; // cell 名字和 avatar 之间留白
#define kWBCellContentWidth (kScreenWidth - 2 * kWBCellPadding) // cell 内容宽度
#define kWBCellNameWidth (kScreenWidth - 110) // cell 名字最宽限制

static CGFloat const kWBCellTagPadding = 8;         // tag 上下留白
static CGFloat const kWBCellTagNormalHeight = 16;   // 一般 tag 高度
static CGFloat const kWBCellTagPlaceHeight = 24;    // 地理位置 tag 高度

static CGFloat const kWBCellToolbarHeight = 35;        // cell 下方工具栏高度
static CGFloat const kWBCellToolbarBottomMargin = 2;   // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
static CGFloat const kWBCellNameFontSize = 16;      // 名字字体大小
static CGFloat const kWBCellSourceFontSize = 12;    // 来源字体大小
static CGFloat const kWBCellTextFontSize = 17;      // 文本字体大小
static CGFloat const kWBCellTextFontRetweetSize = 16; // 转发字体大小
static CGFloat const kWBCellCardTitleFontSize = 16; // 卡片标题文本字体大小
static CGFloat const kWBCellCardDescFontSize = 12; // 卡片描述文本字体大小
static CGFloat const kWBCellTitlebarFontSize = 14; // 标题栏字体大小
static CGFloat const kWBCellToolbarFontSize = 14; // 工具栏字体大小

// 颜色
#define kWBCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kWBCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kWBCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kWBCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kWBCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kWBCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kWBCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kWBCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kWBCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kWBLinkHrefName @"href" //NSString
#define kWBLinkURLName @"url" //WBURL
#define kWBLinkTagName @"tag" //WBTag
#define kWBLinkTopicName @"topic" //WBTopic
#define kWBLinkAtName @"at" //NSString

/// 卡片类型 (这里随便写的，只适配了微博中常见的类型)
typedef NS_ENUM(NSUInteger, WBStatusCardType) {
    WBStatusCardTypeNone = 0, ///< 没卡片
    WBStatusCardTypeNormal,   ///< 一般卡片布局
    WBStatusCardTypeVideo,    ///< 视频
};

/// 最下方Tag类型，也是随便写的，微博可能有更多类型同时存在等情况
typedef NS_ENUM(NSUInteger, WBStatusTagType) {
    WBStatusTagTypeNone = 0, ///< 没Tag
    WBStatusTagTypeNormal,   ///< 文本
    WBStatusTagTypePlace,    ///< 地点
};

NS_ASSUME_NONNULL_BEGIN

/**
 一个 Cell 的布局模型。
 布局排版应该在后台线程完成。
 */
@interface ZXGWBStatusLayout : ZXGRootModel <ZXGTableViewCellModelAble>

- (instancetype)initWithStatus:(ZXGWBStatus *)status style:(WBLayoutStyle)style;

//协议
@property (nonatomic, copy) NSString *reuseIdentifier;  //cell重用标识符

@property (nonatomic) Class cellClass; //cell类

@property (nonatomic) CGFloat rowHeight; // cell行高 

//---------->以下是数据<----------
@property (nonatomic, strong) ZXGWBStatus *status;
@property (nonatomic) WBLayoutStyle style;


//---------->以下是布局结果<----------
// 顶部灰色留白
@property (nonatomic) CGFloat marginTop;

// 标题栏
@property (nonatomic) CGFloat titleHeight; // 标题栏高度，0为没标题栏
@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏

// 个人资料
@property (nonatomic) CGFloat profileHeight; // 个人资料高度(包括留白)
@property (nonatomic, strong) YYTextLayout *nameTextLayout; // 名字
@property (nonatomic, strong) YYTextLayout *sourceTextLayout; //时间/来源

// 文本
@property (nonatomic) CGFloat textHeight; // 文本高度(包括下方留白)
@property (nonatomic, strong) YYTextLayout *textLayout; //文本

// 图片
@property (nonatomic) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic) CGSize picSize;

// 转发
@property (nonatomic) CGFloat retweetHeight; //转发高度，0为没转发
@property (nonatomic) CGFloat retweetTextHeight;
@property (nonatomic, strong) YYTextLayout *retweetTextLayout; //被转发文本
@property (nonatomic) CGFloat retweetPicHeight;
@property (nonatomic) CGSize retweetPicSize;
@property (nonatomic) CGFloat retweetCardHeight;
@property (nonatomic) WBStatusCardType retweetCardType;
@property (nonatomic, strong) YYTextLayout *retweetCardTextLayout; //被转发文本
@property (nonatomic) CGRect retweetCardTextRect;

// 卡片
@property (nonatomic) CGFloat cardHeight; //卡片高度，0为没卡片
@property (nonatomic) WBStatusCardType cardType;
@property (nonatomic, strong) YYTextLayout *cardTextLayout; //卡片文本
@property (nonatomic) CGRect cardTextRect;

// Tag
@property (nonatomic) CGFloat tagHeight; //Tip高度，0为没tip
@property (nonatomic) WBStatusTagType tagType;
@property (nonatomic, strong) YYTextLayout *tagTextLayout; //最下方tag

// 工具栏
@property (nonatomic) CGFloat toolbarHeight; // 工具栏
@property (nonatomic, strong) YYTextLayout *toolbarRepostTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarCommentTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarLikeTextLayout;
@property (nonatomic) CGFloat toolbarRepostTextWidth;
@property (nonatomic) CGFloat toolbarCommentTextWidth;
@property (nonatomic) CGFloat toolbarLikeTextWidth;

// 底部留白
@property (nonatomic) CGFloat marginBottom; // 底部留白

@end

/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end

NS_ASSUME_NONNULL_END

