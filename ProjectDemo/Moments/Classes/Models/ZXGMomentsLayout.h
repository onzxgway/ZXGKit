//
//  ZXGMomentsLayout.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGMomentsConst.h"
#import "ZXGDynamicModel.h"

@interface ZXGMomentsLayout : NSObject <ZXGTableViewCellModelAble>

#pragma mark - ZXGTableViewCellModelAble

@property (nonatomic, copy) NSString *reuseIdentifier;  //cell重用标识符

@property (nonatomic) Class cellClass;                  //cell类

@property (nonatomic) CGFloat rowHeight;                // cell行高

/** model*/
@property (nonatomic, strong, readonly) ZXGDynamicModel *momentsModel;

- (instancetype)initWithMoments:(ZXGDynamicModel *)moments NS_DESIGNATED_INITIALIZER;

//---------->以下是布局结果<----------
// 名称
@property (nonatomic) CGFloat nameHeight; // 名称栏高度，0为没名称栏
@property (nonatomic, strong) YYTextLayout *nameTextLayout; // 名称栏

// 时间/来源
@property (nonatomic) CGFloat profileHeight; // 个人资料高度(包括留白)
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
//@property (nonatomic) WBStatusCardType retweetCardType;
@property (nonatomic, strong) YYTextLayout *retweetCardTextLayout; //被转发文本
@property (nonatomic) CGRect retweetCardTextRect;

// 卡片
@property (nonatomic) CGFloat cardHeight; //卡片高度，0为没卡片
//@property (nonatomic) WBStatusCardType cardType;
@property (nonatomic, strong) YYTextLayout *cardTextLayout; //卡片文本
@property (nonatomic) CGRect cardTextRect;

// Tag
@property (nonatomic) CGFloat tagHeight; //Tip高度，0为没tip
//@property (nonatomic) WBStatusTagType tagType;
@property (nonatomic, strong) YYTextLayout *tagTextLayout; //最下方tag

// 工具栏
@property (nonatomic) CGFloat toolbarHeight; // 工具栏
@property (nonatomic, strong) YYTextLayout *toolbarRepostTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarCommentTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarLikeTextLayout;
@property (nonatomic) CGFloat toolbarRepostTextWidth;
@property (nonatomic) CGFloat toolbarCommentTextWidth;
@property (nonatomic) CGFloat toolbarLikeTextWidth;

@end
