//
//  ZXGMomentsCell.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGMomentsConst.h"
@class ZXGMomentsLayout;

//点赞 和 评论
@interface ZXGMomentsOperationMenu : UIView

@property (nonatomic, getter = isShowing) BOOL show;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;

@end

// 评论
@interface ZXGMomentsCommentView : UIView


@end

// 卡片
@interface ZXGMomentsCardView : UIView

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) YYLabel *contentlab;
@property (nonatomic, strong) UIButton *button;

- (void)setWithLayout:(ZXGMomentsLayout *)layout;

@end


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

@end


@interface ZXGMomentsCell : UITableViewCell <ZXGTableViewCellAble>
@property (nonatomic, strong) ZXGMomentsView *momentsView;
@end
