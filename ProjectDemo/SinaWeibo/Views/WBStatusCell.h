//
//  WBStatusCell.h
//  SinaWeibo
//
//  Created by 朱献国 on 2018/4/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGRootTableViewCell.h"
#import "ZXGWBStatusLayout.h"
@class WBStatusCell;

// 标题栏
@interface WBStatusTitleView : UIView

@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, weak  ) WBStatusCell *cell;

@end

// 用户资料
@interface WBStatusProfileView : UIView

@property (nonatomic, strong) UIImageView *avatarView; // 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; // 徽章
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *sourceLabel;
//@property (nonatomic, assign) WBUserVerifyType verifyType;
@property (nonatomic, weak  ) WBStatusCell *cell;

@end

// 卡片
@interface WBStatusCardView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak  ) WBStatusCell *cell;

@end


@interface WBStatusTagView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak  ) WBStatusCell *cell;

@end


@interface WBStatusToolbarView : UIView

@property (nonatomic, strong) UIButton *repostButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIImageView *repostImageView;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) YYLabel *repostLabel;
@property (nonatomic, strong) YYLabel *commentLabel;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak  ) WBStatusCell *cell;

- (void)setWithLayout:(ZXGWBStatusLayout *)layout;
// set both "liked" and "likeCount"
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;
@end

@interface WBStatusView : UIView

@property (nonatomic, strong) UIView *contentView;              // 容器
@property (nonatomic, strong) WBStatusTitleView *titleView;     // 标题栏
@property (nonatomic, strong) WBStatusProfileView *profileView; // 用户资料
@property (nonatomic, strong) YYLabel *textLabel;               // 文本
@property (nonatomic, strong) NSArray<UIView *> *picViews;      // 配图
@property (nonatomic, strong) UIView *retweetBackgroundView;    // 转发容器
@property (nonatomic, strong) YYLabel *retweetTextLabel;        // 转发文本
@property (nonatomic, strong) WBStatusCardView *cardView;       // 卡片
@property (nonatomic, strong) WBStatusTagView *tagView;         // 下方Tag
@property (nonatomic, strong) WBStatusToolbarView *toolbarView; // 工具栏
@property (nonatomic, strong) UIImageView *vipBackgroundView;   // VIP 自定义背景
@property (nonatomic, strong) UIButton *menuButton;             // 菜单按钮
@property (nonatomic, strong) UIButton *followButton;           // 关注按钮

@property (nonatomic, strong) ZXGWBStatusLayout *layout;
@property (nonatomic, weak  ) WBStatusCell *cell;

@end


@interface WBStatusCell : ZXGRootTableViewCell <ZXGTableViewCellAble>

@property (nonatomic, strong) WBStatusView *statusView;

@end
