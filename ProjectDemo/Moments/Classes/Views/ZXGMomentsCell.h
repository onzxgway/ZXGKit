//
//  ZXGMomentsCell.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGMomentsConst.h"

// 评论
@interface ZXGMomentsCommentView : UIView


@end

// 卡片
@interface ZXGMomentsCardView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *label;

@end

@interface ZXGMomentsView : UIView

@property (nonatomic, strong) UIImageView *iconImg;  //头像
@property (nonatomic, strong) YYLabel *nameLab;      //名称
@property (nonatomic, strong) YYLabel *contentLab;   //内容
@property (nonatomic, strong) ZXGMomentsCardView *cardView;         //卡片
@property (nonatomic, strong) NSArray<UIView *> *picViews;          //配图
@property (nonatomic, strong) YYLabel *timeAndSourceLab;            //时间 和 来源
@property (nonatomic, strong) UIButton *moreBtn;                    //点赞 评论 按钮
@property (nonatomic, strong) ZXGMomentsCommentView *commentView;   //评论

@end

@interface ZXGMomentsCell : UITableViewCell <ZXGTableViewCellAble>

@end
