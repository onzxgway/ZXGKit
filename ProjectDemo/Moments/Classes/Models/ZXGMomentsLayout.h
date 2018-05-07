//
//  ZXGMomentsLayout.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGMomentsConst.h"
#import "ZXGMomentModel.h"

@interface ZXGMomentsLayout : NSObject <ZXGTableViewCellModelAble>

#pragma mark - ZXGTableViewCellModelAble

@property (nonatomic, copy) NSString *reuseIdentifier;  //cell重用标识符

@property (nonatomic) Class cellClass;                  //cell类

@property (nonatomic) CGFloat rowHeight;                // cell行高

@property (nonatomic, strong, readonly) ZXGMomentModel *momentsModel; // model

- (instancetype)initWithMoments:(ZXGMomentModel *)moments NS_DESIGNATED_INITIALIZER;

//              ---------->以下是布局结果<----------
// 名称
@property (nonatomic) CGFloat nameHeight; // 名称栏高度，0为没名称栏
@property (nonatomic, strong) YYTextLayout *nameTextLayout; // 名称栏

// 时间
@property (nonatomic) CGFloat publichTimeHeight;
@property (nonatomic, strong) YYTextLayout *publichTimeTextLayout; //时间/来源

// 文本
@property (nonatomic) CGFloat textHeight; // 文本高度(包括下方留白)
@property (nonatomic, strong) YYTextLayout *textLayout; //文本

// 配图
@property (nonatomic) CGFloat picHeight;    // 配图高度，0为没配图
@property (nonatomic) CGSize picSize;       // 单张图片的尺寸

// 卡片
@property (nonatomic) CGFloat cardHeight; // 卡片高度，0为没卡片
//@property (nonatomic) WBStatusCardType cardType;
@property (nonatomic, strong) YYTextLayout *cardTextLayout; //卡片文本
@property (nonatomic) CGRect cardTextRect;

// 位置
@property (nonatomic) CGFloat locHeight; // 位置高度，0为没位置
@property (nonatomic, strong) YYTextLayout *locTextLayout; //位置文本

// 评论
@property (nonatomic) CGFloat comHeight; // 评论高度，0为没评论
@property (nonatomic, strong) NSMutableArray *comTextLayouts;//评论和点赞文本

@end


/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface ZXGMomentsTextLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font;         // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic) CGFloat paddingTop;           // 文本顶部留白
@property (nonatomic) CGFloat paddingBottom;        // 文本底部留白
@property (nonatomic) CGFloat lineHeightMultiple;   // 行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end





