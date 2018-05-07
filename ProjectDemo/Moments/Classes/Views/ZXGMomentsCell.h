//
//  ZXGMomentsCell.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGMomentsLayout.h"
@class ZXGMomentsCell;

// 操作
@interface ZXGMomentsOperationMenu : UIView

@property (nonatomic, getter = isShowing) BOOL show;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, weak  ) ZXGMomentsCell *cell;

@end

// 点赞 和 评论
@interface ZXGMomentsCommentView : UIView

@property (nonatomic, strong) ZXGMomentsLayout *layout;
@property (nonatomic, weak  ) ZXGMomentsCell *cell;

@end

// 卡片
@interface ZXGMomentsCardView : UIView

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) YYLabel *contentlab;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak  ) ZXGMomentsCell *cell;
- (void)setWithLayout:(ZXGMomentsLayout *)layout;

@end

// 
@interface ZXGMomentsView : UIView

@property (nonatomic, strong) UIImageView *avatarView;                  //头像
@property (nonatomic, strong) YYLabel *nameLab;                         //名称
@property (nonatomic, strong) YYLabel *contentLab;                      //内容
@property (nonatomic, strong) NSArray<UIView *> *picViews;              //配图
@property (nonatomic, strong) ZXGMomentsCardView *cardView;             //卡片
@property (nonatomic, strong) YYLabel *locLab;                          //位置
@property (nonatomic, strong) YYLabel *timeAndSourceLab;                //时间 和 来源
@property (nonatomic, strong) UIButton *moreBtn;                        //点赞 评论 按钮
@property (nonatomic, strong) UIButton *delBtn;                         //删除 按钮
@property (nonatomic, strong) ZXGMomentsCommentView *commentView;       //评论
@property (nonatomic, strong) ZXGMomentsOperationMenu *operationMenu;   //点赞 和 评论

@property (nonatomic, strong) ZXGMomentsLayout *layout;
@property (nonatomic, weak  ) ZXGMomentsCell *cell;

@end


@protocol ZXGMomentsCellDelegate <ZXGTableViewCellDelegate>
@optional
// 点击了 Cell
- (void)cellDidClick:(ZXGMomentsCell *)cell;
// 点击了 Card
- (void)cellDidClickCard:(ZXGMomentsCell *)cell;
///// 点击了转发内容
//- (void)cellDidClickRetweet:(ZXGMomentsCell *)cell;
///// 点击了Cell菜单
//- (void)cellDidClickMenu:(ZXGMomentsCell *)cell;
///// 点击了关注
//- (void)cellDidClickFollow:(ZXGMomentsCell *)cell;
///// 点击了转发
//- (void)cellDidClickRepost:(ZXGMomentsCell *)cell;
///// 点击了下方 Tag
//- (void)cellDidClickTag:(ZXGMomentsCell *)cell;
///// 点击了评论
//- (void)cellDidClickComment:(ZXGMomentsCell *)cell;
///// 点击了赞
//- (void)cellDidClickLike:(ZXGMomentsCell *)cell;
///// 点击了用户
//- (void)cell:(ZXGMomentsCell *)cell didClickUser:(WBUser *)user;
///// 点击了图片
//- (void)cell:(ZXGMomentsCell *)cell didClickImageAtIndex:(NSUInteger)index;
///// 点击了 Label 的链接
//- (void)cell:(ZXGMomentsCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange;
@end

@interface ZXGMomentsCell : UITableViewCell <ZXGTableViewCellAble>
@property (nonatomic, strong) ZXGMomentsView *momentsView;
@property (nonatomic, weak  ) id<ZXGMomentsCellDelegate> delegate;
@end
