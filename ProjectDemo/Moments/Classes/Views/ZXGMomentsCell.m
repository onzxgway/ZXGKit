//
//  ZXGMomentsCell.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsCell.h"

// 评论
@implementation ZXGMomentsCommentView

@end


@implementation ZXGMomentsCardView

@end


@implementation ZXGMomentsView 

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0 ) {
        frame.size.width = SCREEN_WIDTH;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    self.backgroundColor = RGBA(255, 254, 255, 1.0);
    [self addSubview:self.iconImg];
    [self addSubview:self.nameLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.timeAndSourceLab];
}

//头像
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.backgroundColor = kRandomColor;
        _iconImg.userInteractionEnabled = YES;
//        [_iconImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImgClick)]];
    }
    return _iconImg;
}

//名称
- (YYLabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[YYLabel alloc] init];
    }
    return _nameLab;
}

//时间 和 来源
- (YYLabel *)timeAndSourceLab {
    if (!_timeAndSourceLab) {
        _timeAndSourceLab = [[YYLabel alloc] init];
    }
    return _timeAndSourceLab;
}

//内容
- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] init];
    }
    return _contentLab;
}

//卡片
- (ZXGMomentsCardView *)cardView {
    if (!_cardView) {
        _cardView = [[ZXGMomentsCardView alloc] init];
    }
    return _cardView;
}

//评论
- (ZXGMomentsCommentView *)commentView {
    if (!_commentView) {
        _commentView = [[ZXGMomentsCommentView alloc] init];
    }
    return _commentView;
}

//点赞 评论 按钮
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _moreBtn;
}

//配图
//@property (nonatomic, strong) NSArray<UIView *> *picViews;

@end



@interface ZXGMomentsCell ()
@property (nonatomic, strong) ZXGMomentsView *momentsView;
@end

@implementation ZXGMomentsCell

#pragma mark - Overwrite
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}

// 子类重写
- (void)settingModel:(id<ZXGTableViewCellModelAble>)model secModel:(ZXGBaseTableViewSectionModel *)secModel indexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Initial
- (void)createUI {
    
    self.contentView.backgroundColor = RGBA(255, 254, 255, 1.0);
    [self.contentView addSubview:self.momentsView];
    
}

#pragma mark - Lazy Load
- (ZXGMomentsView *)momentsView {
    if (!_momentsView) {
        _momentsView = [[ZXGMomentsView alloc] init];
    }
    return _momentsView;
}

@end
