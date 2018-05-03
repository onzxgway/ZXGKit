//
//  ZXGMomentsCell.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsCell.h"
#import "ZXGMomentsLayout.h"

@implementation ZXGMomentsOperationMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0 && frame.size.width == 0) {
        frame.size.height = kZXGMomentsOperationMenuH;
        frame.size.width = kZXGMomentsOperationMenuW;
    }
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.backgroundColor = kZXGMomentsOperationMenuBGColor;
    [self setLayerCornerRadius:5.f andBorder:nil width:0];
    
    _likeButton = [self createButtonWithTitle:@"赞" image:GET_IMAGE(@"AlbumLike") selImage:GET_IMAGE(@"AlbumLikeHL") target:self selector:@selector(likeButtonClicked)];
    _commentButton = [self createButtonWithTitle:@"评论" image:GET_IMAGE(@"AlbumCommentSingleA") selImage:GET_IMAGE(@"AlbumCommentSingleAHL") target:self selector:@selector(commentButtonClicked)];
    
    [self addSubview:_likeButton];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.width * 0.5);
    }];
    
    [self addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(_likeButton);
    }];
    
    // 中间分割线
    CALayer *centerLine = [[CALayer alloc] init];
    centerLine.backgroundColor = RGB(48, 53, 58).CGColor;
    [self.layer addSublayer:centerLine];
    centerLine.size = CGSizeMake(ONE_PIXEL, kZXGMomentsOperationMenuH - 18);
    centerLine.origin = CGPointMake(kZXGMomentsOperationMenuW * 0.5, (kZXGMomentsOperationMenuH - centerLine.size.height) * 0.5);
}

- (UIButton *)createButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [btn setBackgroundImage:[UIImage imageWithColor:RGB(48, 53, 58)] forState:UIControlStateHighlighted];
    return btn;
}

- (void)setShow:(BOOL)show {
    _show = show;
    
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.15 animations:^{
        if (!show) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        }
        else {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kZXGMomentsOperationMenuW);
            }];
        }

        [self.superview layoutIfNeeded];
    }];
}


- (void)likeButtonClicked {
    
}

- (void)commentButtonClicked {
    
}

@end

// 评论
@implementation ZXGMomentsCommentView

@end


@implementation ZXGMomentsCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0 && frame.size.width == 0) {
        frame.size.height = kAvaterSize + 2 * kCardHVMargin;
    }
    self = [super initWithFrame:frame];
    
    self.exclusiveTouch = YES;
    self.backgroundColor = RGB(242, 242, 245);
    
    // 头像
    _avatarView = [[UIImageView alloc] init];
    _avatarView.size = CGSizeMake(kAvaterSize, kAvaterSize);
    _avatarView.top = kCardHVMargin;
    _avatarView.left = kCardHVMargin;
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatarView];
    
    // 名称
    _contentlab = [[YYLabel alloc] init];
//    _contentlab.size = CGSizeMake(kWBCellNameWidth, 24);
//    _contentlab.left = _avatarView.right + kWBCellNamePaddingLeft;
//    _contentlab.centerY = 27;
//    _nameLabel.displaysAsynchronously = YES;
//    _nameLabel.ignoreCommonProperties = YES;
//    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
//    _nameLabel.fadeOnHighlight = NO;
//    _nameLabel.lineBreakMode = NSLineBreakByClipping;
//    _nameLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:_contentlab];
    
    return self;
}

@end


@implementation ZXGMomentsView 

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
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
    [self addSubview:self.avatarView];
    [self addSubview:self.nameLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.timeAndSourceLab];
    [self addSubview:self.cardView];
    [self addSubview:self.commentView];
    [self addSubview:self.moreBtn];
    
    // 底部分割线
    CALayer *bottomLine = [[CALayer alloc] init];
    bottomLine.backgroundColor = RGB(228, 224, 228).CGColor;
    bottomLine.width = self.width;
    bottomLine.bottom = self.height;
    bottomLine.height = ONE_PIXEL;
    [self.layer addSublayer:bottomLine];
}

- (void)setLayout:(ZXGMomentsLayout *)layout {
    _layout = layout;
    
    ZXGDynamicModel *model = layout.momentsModel;
    //
    self.height = layout.rowHeight;
    CGFloat top = kTopBtmMargin;
    
    // 头像
    NSString *urlStr = model.avatalUrl;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:GET_IMAGE(@"")];
    
    // 昵称
    _nameLab.textLayout = layout.nameTextLayout;
    _nameLab.height = layout.nameHeight;
    top += layout.nameHeight;
    top += kVMargin;
    
    // 内容
    _contentLab.textLayout = layout.textLayout;
    _contentLab.height = layout.textHeight;
    _contentLab.top = top;
    
}

// 头像
- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.backgroundColor = kRandomColor;
        _avatarView.userInteractionEnabled = YES;
        _avatarView.size = CGSizeMake(kAvaterSize, kAvaterSize);
        _avatarView.top = kTopBtmMargin;
        _avatarView.left = kLeftRightMargin;
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
//        [_iconImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImgClick)]];
    }
    return _avatarView;
}

// 名称
- (YYLabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[YYLabel alloc] init];
        _nameLab.top = kTopBtmMargin;
        _nameLab.left = kNameLeft;
        _nameLab.width = kNameWidth;
        _nameLab.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _nameLab.displaysAsynchronously = YES;
        _nameLab.ignoreCommonProperties = YES;
        _nameLab.fadeOnAsynchronouslyDisplay = NO;
        _nameLab.fadeOnHighlight = NO;
    }
    return _nameLab;
}

//时间 和 来源
- (YYLabel *)timeAndSourceLab {
    if (!_timeAndSourceLab) {
        _timeAndSourceLab = [[YYLabel alloc] init];
        _timeAndSourceLab.left = self.avatarView.right + kHMargin;
    }
    return _timeAndSourceLab;
}

//内容
- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] init];
        _contentLab.left = kNameLeft;
        _contentLab.width = kNameWidth;
        _contentLab.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _contentLab.displaysAsynchronously = YES;
        _contentLab.ignoreCommonProperties = YES;
        _contentLab.fadeOnAsynchronouslyDisplay = NO;
        _contentLab.fadeOnHighlight = NO;
    }
    return _contentLab;
}

//卡片
- (ZXGMomentsCardView *)cardView {
    if (!_cardView) {
        _cardView = [[ZXGMomentsCardView alloc] init];
        _cardView.left = self.avatarView.right + kHMargin;
    }
    return _cardView;
}

//评论
- (ZXGMomentsCommentView *)commentView {
    if (!_commentView) {
        _commentView = [[ZXGMomentsCommentView alloc] init];
        _commentView.left = self.avatarView.right + kHMargin;
        _commentView.right = SCREEN_WIDTH - kLeftRightMargin;
    }
    return _commentView;
}

//点赞 评论 按钮
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:GET_IMAGE(@"AlbumOperateMore") forState:UIControlStateNormal];
        [_moreBtn setImage:GET_IMAGE(@"AlbumOperateMoreHL") forState:UIControlStateHighlighted];
        _moreBtn.right = SCREEN_WIDTH - kLeftRightMargin;
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
    ZXGMomentsLayout *layout = (ZXGMomentsLayout *)model;
    self.contentView.height = layout.rowHeight;
    self.momentsView.layout = layout;
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
