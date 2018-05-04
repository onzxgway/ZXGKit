//
//  WBModel.h
//  YYKitExample
//
//  Created by ibireme on 15/9/4.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 认证方式
typedef NS_ENUM(NSUInteger, WBUserVerifyType){
    WBUserVerifyTypeNone = 0,     ///< 没有认证
    WBUserVerifyTypeStandard,     ///< 个人认证，黄V
    WBUserVerifyTypeOrganization, ///< 官方认证，蓝V
    WBUserVerifyTypeClub,         ///< 达人认证，红星
};


// 图片标记
typedef NS_ENUM(NSUInteger, WBPictureBadgeType) {
    WBPictureBadgeTypeNone = 0, // 正常图片
    WBPictureBadgeTypeLong,     // 长图
    WBPictureBadgeTypeGIF,      // GIF
};


/**
 一张图片的元数据
 */
@interface ZXGWBPictureMetadata : NSObject

@property (nonatomic, strong) NSURL *url; // Full image url
@property (nonatomic) NSInteger width;    // pixel width
@property (nonatomic) NSInteger height;   // pixel height
@property (nonatomic, copy  ) NSString *type; // "WEBP" "JPEG" "GIF"
@property (nonatomic) NSInteger cutType;  // Default:1
@property (nonatomic) WBPictureBadgeType badgeType;

@end


/**
 图片 
 */
@interface ZXGWBPicture : NSObject

@property (nonatomic, copy  ) NSString *picID;
@property (nonatomic, copy  ) NSString *objectID;
@property (nonatomic) int photoTag;
@property (nonatomic) BOOL keepSize; // YES:固定为方形 NO:原始宽高比
@property (nonatomic, strong) ZXGWBPictureMetadata *thumbnail;  ///< w:180
@property (nonatomic, strong) ZXGWBPictureMetadata *bmiddle;    ///< w:360 (列表中的缩略图)
@property (nonatomic, strong) ZXGWBPictureMetadata *middlePlus; ///< w:480
@property (nonatomic, strong) ZXGWBPictureMetadata *large;      ///< w:720 (放大查看)
@property (nonatomic, strong) ZXGWBPictureMetadata *largest;    ///<       (查看原图)
@property (nonatomic, strong) ZXGWBPictureMetadata *original;   ///<
@property (nonatomic) WBPictureBadgeType badgeType;

@end


/**
 链接
 */
@interface WBURL : NSObject
@property (nonatomic) BOOL result;
@property (nonatomic, strong) NSString *shortURL; ///< 短域名 (原文)
@property (nonatomic, strong) NSString *oriURL;   ///< 原始链接
@property (nonatomic, strong) NSString *urlTitle; ///< 显示文本，例如"网页链接"，可能需要裁剪(24)
@property (nonatomic, strong) NSString *urlTypePic; ///< 链接类型的图片URL
@property (nonatomic) int32_t urlType; ///< 0:一般链接 36地点 39视频/图片
@property (nonatomic, strong) NSString *log;
@property (nonatomic, strong) NSDictionary *actionLog;
@property (nonatomic, strong) NSString *pageID; ///< 对应着 WBPageInfo
@property (nonatomic, strong) NSString *storageType;
//如果是图片，则会有下面这些，可以直接点开看
@property (nonatomic, strong) NSArray<NSString *> *picIds;
@property (nonatomic, strong) NSDictionary<NSString *, ZXGWBPicture *> *picInfos;
@property (nonatomic, strong) NSArray<ZXGWBPicture *> *pics;
@end


/**
 话题
 */
@interface WBTopic : NSObject
@property (nonatomic, strong) NSString *topicTitle; ///< 话题标题
@property (nonatomic, strong) NSString *topicURL; ///< 话题链接 sinaweibo://
@end


/**
 标签
 */
@interface WBTag : NSObject
@property (nonatomic, strong) NSString *tagName; ///< 标签名字，例如"上海·上海文庙"
@property (nonatomic, strong) NSString *tagScheme; ///< 链接 sinaweibo://...
@property (nonatomic) int32_t tagType; ///< 1 地点 2其他
@property (nonatomic) int32_t tagHidden;
@property (nonatomic, strong) NSURL *urlTypePic; ///< 需要加 _default
@end


/**
 按钮
 */
@interface WBButtonLink : NSObject
@property (nonatomic, strong) NSURL *pic;  ///< 按钮图片URL (需要加_default)
@property (nonatomic, strong) NSString *name; ///< 按钮文本，例如"点评"
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *params;
@end


/**
 卡片 (样式有多种，最常见的是下方这样)
 -----------------------------
          title
  pic     title        button
          tips
 -----------------------------
 */
@interface ZXGWBPageInfo : NSObject

@property (nonatomic, copy  ) NSString *pageTitle;  // 页面标题，例如"上海·上海文庙"
@property (nonatomic, copy  ) NSString *pageID;
@property (nonatomic, copy  ) NSString *pageDesc;   // 页面描述，例如"上海市黄浦区文庙路215号"
@property (nonatomic, copy  ) NSString *content1;
@property (nonatomic, copy  ) NSString *content2;
@property (nonatomic, copy  ) NSString *content3;
@property (nonatomic, copy  ) NSString *content4;
@property (nonatomic, copy  ) NSString *tips;       // 提示，例如"4222条微博"
@property (nonatomic, copy  ) NSString *objectType; // 类型，例如"place" "video"
@property (nonatomic, copy  ) NSString *objectID;
@property (nonatomic, copy  ) NSString *scheme;     // 真实链接，例如 http://v.qq.com/xxx
@property (nonatomic, strong) NSArray<WBButtonLink *> *buttons;

@property (nonatomic) NSInteger isAsyn;
@property (nonatomic) NSInteger type;
@property (nonatomic, copy  ) NSString *pageURL; // 链接 sinaweibo://...
@property (nonatomic, strong) NSURL *pagePic;    // 图片URL，不需要加(_default) 通常是左侧的方形图片
@property (nonatomic, strong) NSURL *typeIcon;   // Badge 图片URL，不需要加(_default) 通常放在最左上角角落里
@property (nonatomic) NSInteger actStatus;
@property (nonatomic, strong) NSDictionary *actionlog;
@property (nonatomic, strong) NSDictionary *mediaInfo;

@end

/**
 微博标题栏
 */
@interface ZXGWBStatusTitle : NSObject

@property (nonatomic) NSInteger baseColor;
@property (nonatomic, copy  ) NSString *text;       // 文本，例如"仅自己可见"
@property (nonatomic, copy  ) NSString *iconURL;    // 图标URL，需要加Default

@end

/**
 用户
 */
@interface WBUser : NSObject

@property (nonatomic) NSInteger userID;             // id (int)
@property (nonatomic, copy  ) NSString *idString;   // id (string)

@property (nonatomic) NSInteger gender;             // 0:none 1:男 2:女  "gender":"m",
@property (nonatomic, copy  ) NSString *genderString; // "m":男 "f":女 "n"未知

@property (nonatomic, copy  ) NSString *desc;       // 个人简介
@property (nonatomic, copy  ) NSString *domain;     // 个性域名

@property (nonatomic, copy  ) NSString *name;       // 昵称
@property (nonatomic, copy  ) NSString *screenName; // 友好昵称
@property (nonatomic, copy  ) NSString *remark;     // 备注

@property (nonatomic) NSInteger followersCount;     // 粉丝数
@property (nonatomic) NSInteger friendsCount;       // 关注数
@property (nonatomic) NSInteger biFollowersCount;   // 好友数 (双向关注)
@property (nonatomic) NSInteger favouritesCount;    // 收藏数
@property (nonatomic) NSInteger statusesCount;      // 微博数
@property (nonatomic) NSInteger topicsCount;        // 话题数
@property (nonatomic) NSInteger blockedCount;       // 屏蔽数
@property (nonatomic) NSInteger pagefriendsCount;
@property (nonatomic) BOOL followMe;
@property (nonatomic) BOOL following;

@property (nonatomic, copy  ) NSString *province;   // 省
@property (nonatomic, copy  ) NSString *city;       // 市

@property (nonatomic, copy  ) NSString *url;        // 博客地址
@property (nonatomic, strong) NSURL *profileImageURL; // 头像 50x50 (FeedList)
@property (nonatomic, strong) NSURL *avatarLarge;     // 头像 180*180
@property (nonatomic, strong) NSURL *avatarHD;        // 头像 原图
@property (nonatomic, strong) NSURL *coverImage;      // 封面图 920x300
@property (nonatomic, strong) NSURL *coverImagePhone;

@property (nonatomic, copy  ) NSString *profileURL;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger ptype;
@property (nonatomic) NSInteger mbtype;
@property (nonatomic) NSInteger urank; ///< 微博等级 (LV)
@property (nonatomic) NSInteger uclass;
@property (nonatomic) NSInteger ulevel;
@property (nonatomic) NSInteger mbrank; ///< 会员等级 (橙名 VIP)
@property (nonatomic) NSInteger star;
@property (nonatomic) NSInteger level;
@property (nonatomic, strong) NSDate *createdAt; ///< 注册时间
@property (nonatomic) BOOL allowAllActMsg;
@property (nonatomic) BOOL allowAllComment;
@property (nonatomic) BOOL geoEnabled;
@property (nonatomic) NSInteger onlineStatus;
@property (nonatomic, copy  ) NSString *location; ///< 所在地
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *icons;
@property (nonatomic, copy  ) NSString *weihao;
@property (nonatomic, copy  ) NSString *badgeTop;
@property (nonatomic) NSInteger blockWord;
@property (nonatomic) NSInteger blockApp;
@property (nonatomic) NSInteger hasAbilityTag;
@property (nonatomic) NSInteger creditScore; // 信用积分
@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *badge; // 勋章
@property (nonatomic, copy  ) NSString *lang;
@property (nonatomic) NSInteger userAbility;
@property (nonatomic, strong) NSDictionary *extend;

@property (nonatomic) BOOL verified; // 微博认证 (大V)
@property (nonatomic) NSInteger verifiedType;
@property (nonatomic) NSInteger verifiedLevel;
@property (nonatomic) NSInteger verifiedState;
@property (nonatomic, copy  ) NSString *verifiedContactEmail;
@property (nonatomic, copy  ) NSString *verifiedContactMobile;
@property (nonatomic, copy  ) NSString *verifiedTrade;
@property (nonatomic, copy  ) NSString *verifiedContactName;
@property (nonatomic, copy  ) NSString *verifiedSource;
@property (nonatomic, copy  ) NSString *verifiedSourceURL;
@property (nonatomic, copy  ) NSString *verifiedReason; // 微博认证描述
@property (nonatomic, copy  ) NSString *verifiedReasonURL;
@property (nonatomic, copy  ) NSString *verifiedReasonModified;

@property (nonatomic) WBUserVerifyType userVerifyType;

@end


/**
 一条微博 Model
 */
@interface ZXGWBStatus : NSObject

@property (nonatomic) NSInteger statusID; // 唯一标示
@property (nonatomic, copy  ) NSString *idstr; //唯一标示 字符串类型
@property (nonatomic, copy  ) NSString *mid;
@property (nonatomic, copy  ) NSString *rid;


@property (nonatomic, strong) NSDate *createdAt; // 发布时间
@property (nonatomic, strong) WBUser *user;
@property (nonatomic) NSInteger userType;

@property (nonatomic, strong) ZXGWBStatusTitle *title; // 标题栏(通常为nil)
@property (nonatomic, copy  ) NSString *picBg;         // 微博VIP背景图，需要替换 "os7"
@property (nonatomic, copy  ) NSString *text;          // 正文
@property (nonatomic, strong) NSURL *thumbnailPic;     // 缩略图
@property (nonatomic, strong) NSURL *bmiddlePic;       // 中图
@property (nonatomic, strong) NSURL *originalPic;      // 大图

@property (nonatomic, strong) ZXGWBStatus *retweetedStatus; // 转发微博

@property (nonatomic, strong) NSArray<NSString *> *picIds;
@property (nonatomic, strong) NSDictionary<NSString *, ZXGWBPicture *> *picInfos;

@property (nonatomic, strong) ZXGWBPageInfo *pageInfo;
@property (nonatomic, strong) NSArray<ZXGWBPicture *> *pics;
@property (nonatomic, strong) NSArray<WBURL *> *urlStruct;
@property (nonatomic, strong) NSArray<WBTopic *> *topicStruct;
@property (nonatomic, strong) NSArray<WBTag *> *tagStruct;

@property (nonatomic) BOOL favorited;  // 是否收藏
@property (nonatomic) BOOL truncated;  // 是否截断
@property (nonatomic) NSInteger repostsCount;    // 转发数
@property (nonatomic) NSInteger commentsCount;   // 评论数
@property (nonatomic) NSInteger attitudesCount;  // 赞数
@property (nonatomic) NSInteger attitudesStatus; // 是否已赞 0:没有
@property (nonatomic) NSInteger recomState;

@property (nonatomic, copy  ) NSString *inReplyToScreenName;
@property (nonatomic, copy  ) NSString *inReplyToStatusId;
@property (nonatomic, copy  ) NSString *inReplyToUserId;

@property (nonatomic, copy  ) NSString *source;   // 来自 XXX
@property (nonatomic) NSInteger sourceType;
@property (nonatomic) NSInteger sourceAllowClick; // 来源是否允许点击

@property (nonatomic, strong) NSDictionary *geo;
@property (nonatomic, strong) NSArray *annotations; // 地理位置
@property (nonatomic) NSInteger bizFeature;
@property (nonatomic) NSInteger mlevel;
@property (nonatomic, copy  ) NSString *mblogid;
@property (nonatomic, copy  ) NSString *mblogTypeName;
@property (nonatomic, copy  ) NSString *scheme;
@property (nonatomic, strong) NSDictionary *visible;
@property (nonatomic, strong) NSArray *darwinTags;

@end


/**
 一次API请求的 最外层Model
 */
@interface ZXGWBTimelineItem : NSObject

@property (nonatomic, strong) NSArray *ad;
@property (nonatomic, strong) NSArray *advertises;
@property (nonatomic, strong) NSArray<ZXGWBStatus *> *statuses;
@property (nonatomic) NSInteger interval;
@property (nonatomic) NSInteger uveBlank;
@property (nonatomic) NSInteger hasUnread;
@property (nonatomic) NSInteger totalNumber;
@property (nonatomic, copy  ) NSString *gsid;
@property (nonatomic, copy  ) NSString *sinceID;
@property (nonatomic, copy  ) NSString *maxID;
@property (nonatomic, copy  ) NSString *previousCursor;
@property (nonatomic, copy  ) NSString *nextCursor;
//    "hasvisible":false,
//    "trends":Array[1],
@end


@class WBEmoticonGroup;

typedef NS_ENUM(NSUInteger, WBEmoticonType) {
    WBEmoticonTypeImage = 0, ///< 图片表情
    WBEmoticonTypeEmoji = 1, ///< Emoji表情
};

@interface WBEmoticon : NSObject
@property (nonatomic, strong) NSString *chs;  ///< 例如 [吃惊]
@property (nonatomic, strong) NSString *cht;  ///< 例如 [吃驚]
@property (nonatomic, strong) NSString *gif;  ///< 例如 d_chijing.gif
@property (nonatomic, strong) NSString *png;  ///< 例如 d_chijing.png
@property (nonatomic, strong) NSString *code; ///< 例如 0x1f60d
@property (nonatomic) WBEmoticonType type;
@property (nonatomic, weak) WBEmoticonGroup *group;
@end


@interface WBEmoticonGroup : NSObject
@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic) NSInteger version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic) NSInteger displayOnly;
@property (nonatomic) NSInteger groupType;
@property (nonatomic, strong) NSArray<WBEmoticon *> *emoticons;
@end
