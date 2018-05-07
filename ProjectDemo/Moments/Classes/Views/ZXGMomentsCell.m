//
//  ZXGMomentsCell.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsCell.h"
#import "ZXGPictureView.h"
#import "ZXGArrowTopLayer.h"

@implementation ZXGMomentsOperationMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0 && frame.size.width == 0) {
        frame.size.height = kZXGMomentsOperationMenuH;
        frame.size.width = 0;
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
    _likeButton.frame = CGRectMake(0, 0, kZXGMomentsOperationMenuW * 0.5, self.height);
    
    [self addSubview:_commentButton];
    _commentButton.frame = CGRectMake(kZXGMomentsOperationMenuW * 0.5, 0, kZXGMomentsOperationMenuW * 0.5, self.height);
    
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
    
    [UIView animateWithDuration:0.2f delay:0.f usingSpringWithDamping:0.8f initialSpringVelocity:0.f options:0 animations:^{
        if (!show) {
            self.frame = CGRectMake(self.frame.origin.x + kZXGMomentsOperationMenuW,
                                    self.frame.origin.y,
                                    0.f,
                                    kZXGMomentsOperationMenuH);
        }
        else {
            self.frame = CGRectMake(self.frame.origin.x - kZXGMomentsOperationMenuW,
                                    self.frame.origin.y,
                                    kZXGMomentsOperationMenuW,
                                    kZXGMomentsOperationMenuH);
        }
    } completion:^(BOOL finished) {
        if (!show) {
        }
        else {
        }

    }];
}


- (void)likeButtonClicked {
    
}

- (void)commentButtonClicked {
    
}

@end

// 评论
@implementation ZXGMomentsCommentView {
    NSMutableArray<YYLabel *> *_cacheLabels;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMomentsCardAndCommentColor;
        _cacheLabels = [NSMutableArray array];
        
        //🔼
        ZXGArrowTopLayer *layer = [ZXGArrowTopLayer layer];
        // 设置层的宽高
        layer.frame = CGRectMake(9, -6, 14, 6);
        // 开始绘制图层
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)setLayout:(ZXGMomentsLayout *)layout {
    _layout = layout;
    
    if (!layout.comTextLayouts || layout.comTextLayouts.count <= 0) return;
    
    for (YYLabel *lab in _cacheLabels) {
        lab.hidden = YES;
    }
    
    // 缓存Label的个数
    NSInteger cacheLabelsCount = _cacheLabels.count;
    // 需要新增的Label的个数
    NSInteger needsToAddCount = layout.comTextLayouts.count > cacheLabelsCount ? (layout.comTextLayouts.count - cacheLabelsCount) : 0;
    // 新增Label
    for (int i = 0; i < needsToAddCount; ++i) {
        YYLabel *label = [[YYLabel alloc] init];
        label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        label.displaysAsynchronously = YES;
        label.ignoreCommonProperties = YES;
        label.fadeOnHighlight = NO;
        label.fadeOnAsynchronouslyDisplay = NO;
        label.hidden = YES;
        [self addSubview:label];
        [_cacheLabels addObject:label];
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kMomentsContentWidth;
    for (NSInteger i = 0; i < layout.comTextLayouts.count; ++i) {
        YYTextLayout *textLayout = [layout.comTextLayouts objectAtIndex:i];
        YYLabel *label = [_cacheLabels objectAtIndex:i];
        label.hidden = NO;
        label.textLayout = textLayout;
        label.frame = CGRectMake(x, y, w, textLayout.textBoundingSize.height);
        y += textLayout.textBoundingSize.height;
        if (i == 0 && layout.momentsModel.likes && layout.momentsModel.likes.count > 0) {
            // 点赞分割线
            CALayer *bottomLine = [[CALayer alloc] init];
            bottomLine.backgroundColor = kMomentsLineColor.CGColor;
            bottomLine.width = kMomentsContentWidth;
            bottomLine.left = 0;
            bottomLine.height = ONE_PIXEL;
            bottomLine.top = label.layer.height - ONE_PIXEL;
            [label.layer addSublayer:bottomLine];
        }
    }
}

@end



@implementation ZXGMomentsCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0 && frame.size.width == 0) {
        frame.size.height = kMomentsCardH;
        frame.size.width = kMomentsContentWidth;
    }
    self = [super initWithFrame:frame];
    
    self.exclusiveTouch = YES;
    self.backgroundColor = kMomentsCardAndCommentColor;
    
    // 头像
    _avatarView = [[UIImageView alloc] init];
    _avatarView.backgroundColor = kWhiteColor;
    _avatarView.size = CGSizeMake(kAvaterSize, kAvaterSize);
    _avatarView.top = kCardHVMargin;
    _avatarView.left = kCardHVMargin;
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.clipsToBounds = YES;
    [self addSubview:_avatarView];
    
    // 简介
    _contentlab = [[YYLabel alloc] init];
    _contentlab.size = CGSizeMake(kMomentsContentWidth - kAvaterSize - 3 * kCardHVMargin, kAvaterSize);
    _contentlab.top = kCardHVMargin;
    _contentlab.left = kAvaterSize + 2 * kCardHVMargin;
    _contentlab.displaysAsynchronously = YES;
    _contentlab.ignoreCommonProperties = YES;
    _contentlab.fadeOnAsynchronouslyDisplay = NO;
    _contentlab.fadeOnHighlight = NO;
    _contentlab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:_contentlab];
    
    return self;
}

- (void)setWithLayout:(ZXGMomentsLayout *)layout {
    
    NSInteger pageType = layout.momentsModel.pagetype;
    if (pageType == 0) return;
    
    self.height = layout.cardHeight;
    
    NSString *thumbUrl = layout.momentsModel.thumb;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:thumbUrl] placeholderImage:nil];
    
    _contentlab.textLayout = layout.cardTextLayout;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = kMomentsCardHighlightColor;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = kMomentsCardAndCommentColor;
    if ([_cell.delegate respondsToSelector:@selector(cellDidClickCard:)]) {
        [_cell.delegate cellDidClickCard:_cell];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = kMomentsCardAndCommentColor;
}

@end


@implementation ZXGMomentsView 

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREEN_WIDTH;
//        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

#pragma mark - init
- (void)createViews {
    
    self.backgroundColor = RGBA(255, 254, 255, 1.0);
    [self addSubview:self.avatarView];
    [self addSubview:self.nameLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.locLab];
    [self addSubview:self.timeAndSourceLab];
    [self addSubview:self.cardView];
    [self addSubview:self.commentView];
    [self addSubview:self.moreBtn];
    [self addSubview:self.delBtn];
    [self addSubview:self.operationMenu];
    
    // 配图
    NSMutableArray *picViews = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; i++) {
        // 配图
        ZXGPictureView *imageView = [[ZXGPictureView alloc] init];
        imageView.size = CGSizeMake(100, 100);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = kLightGrayColor;
        imageView.exclusiveTouch = YES;
        //            imageView.touchBlock = ^(YYControl *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event) {
        //                if (![weak_self.cell.delegate respondsToSelector:@selector(cell:didClickImageAtIndex:)]) return;
        //                if (state == YYGestureRecognizerStateEnded) {
        //                    UITouch *touch = touches.anyObject;
        //                    CGPoint p = [touch locationInView:view];
        //                    if (CGRectContainsPoint(view.bounds, p)) {
        //                        [weak_self.cell.delegate cell:weak_self.cell didClickImageAtIndex:i];
        //                    }
        //                }
        //            };
        
        [picViews addObject:imageView];
        [self addSubview:imageView];
    }
    _picViews = picViews;
    
    // 底部分割线
    CALayer *bottomLine = [[CALayer alloc] init];
    bottomLine.backgroundColor = kMomentsLineColor.CGColor;
    bottomLine.width = self.width;
    bottomLine.bottom = self.height;
    bottomLine.height = ONE_PIXEL;
    [self.layer addSublayer:bottomLine];
}

- (void)setLayout:(ZXGMomentsLayout *)layout {
    _layout = layout;
    
    ZXGMomentModel *model = layout.momentsModel;
    //
    self.height = layout.rowHeight;
    CGFloat top = kTopBtmMargin;
    
    // 头像
    NSString *urlStr = model.avatalUrl;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:GET_IMAGE(@"")];
    
    // 昵称
    _nameLab.textLayout = layout.nameTextLayout;
    _nameLab.size = layout.nameTextLayout.textBoundingSize;
    top += layout.nameHeight;
    top += kVMargin;
    
    // 内容
    _contentLab.textLayout = layout.textLayout;
    _contentLab.height = layout.textHeight;
    _contentLab.top = top;
    top += layout.textHeight;
    top += kVMargin;
    
    // 配图
    if (layout.picHeight == 0) {
        for (UIView *imageView in _picViews) {
            imageView.hidden = YES;
        }
    }
    if (layout.cardHeight == 0) {
        _cardView.hidden = YES;
    }
    
    if (layout.picHeight > 0) {
        [self setImageViewWithTop:top];
        top += layout.picHeight;
        top += kVMargin;
    }
    else if (layout.cardHeight > 0) {
        _cardView.top = top;
        _cardView.hidden = NO;
        [_cardView setWithLayout:layout];
        top += layout.cardHeight;
        top += kVMargin;
    }
    
    // 位置
    if (layout.locHeight > 0) {
        _locLab.hidden = NO;
        _locLab.size = layout.locTextLayout.textBoundingSize;
        _locLab.textLayout = layout.locTextLayout;
        _locLab.top = top;
        top += layout.locHeight;
        top += kVMargin;
    }
    else {
        _locLab.hidden = YES;
    }
    
    // 日期
    _timeAndSourceLab.height = layout.publichTimeHeight;
    _timeAndSourceLab.textLayout = layout.publichTimeTextLayout;
    _timeAndSourceLab.width = layout.publichTimeTextLayout.textBoundingSize.width;
    _timeAndSourceLab.top = top;
    
    CGFloat timeAndSourceLabCenterY = top + layout.publichTimeHeight * 0.5;
    // more按钮
    _moreBtn.centerY = timeAndSourceLabCenterY;
    //
    _operationMenu.centerY = _moreBtn.centerY;
    _operationMenu.right = _moreBtn.left;
    _operationMenu.width = 0;
    
    //删除按钮
    if (STRING_EQUAL(@"18539951882", layout.momentsModel.userId)) {
        _delBtn.hidden = NO;
        _delBtn.left = _timeAndSourceLab.right + kHMargin;
        _delBtn.centerY = timeAndSourceLabCenterY;
    }
    else {
        _delBtn.hidden = YES;
    }
    
    top += layout.publichTimeHeight;
    top += kVMargin;
    
    // 评论
    if (layout.comHeight > 0) {
        _commentView.hidden = NO;
        _commentView.height = layout.comHeight;
        _commentView.top = top;
        _commentView.layout = layout;
    }
    else {
        _commentView.hidden = YES;
    }
    
}

#pragma mark - private
- (void)setImageViewWithTop:(CGFloat)imageTop {
    CGSize picSize = _layout.picSize;
    NSArray *pics =  _layout.momentsModel.images;
    NSInteger picsCount = pics.count;
    
    for (NSInteger i = 0; i < 9; i++) {
        UIView *imageView = [_picViews objectAtIndex:i];
        if (i >= picsCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
//                    origin.x = kWBCellPadding;
//                    origin.y = imageTop;
                }
                    break;
                case 4: {
                    origin.x = kMomentsContentLeft + (i % 2) * (picSize.width + kMomentsCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kMomentsCellPaddingPic);
                }
                    break;
                default: {
                    origin.x = kMomentsContentLeft + (i % 3) * (picSize.width + kMomentsCellPaddingPic);
                    origin.y = imageTop + (int)(i / 3) * (picSize.height + kMomentsCellPaddingPic);
                }
                    break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            NSString *picUrl = [pics objectAtIndex:i];
            
            @weakify(imageView);
            [imageView.layer setImageWithURL:[NSURL URLWithString:picUrl]
                                 placeholder:nil
                                     options:YYWebImageOptionAvoidSetImage
                                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                      @strongify(imageView);
                                      if (!imageView) return;
                                      if (image && stage == YYWebImageStageFinished) {
                                          ((ZXGPictureView *)imageView).image = image;
                                          if (from != YYWebImageFromMemoryCacheFast) {
                                              CATransition *transition = [CATransition animation];
                                              transition.duration = 0.15;
                                              transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                                              transition.type = kCATransitionFade;
                                              [imageView.layer addAnimation:transition forKey:@"contents"];
                                          }
                                      }
                                  }];
        }
    }
}

#pragma mark - event
- (void)moreClick {
    _operationMenu.show = !_operationMenu.isShowing;
}

- (void)delClick {
    
}


#pragma mark - lazyLoad
// 头像
- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.backgroundColor = kWhiteColor;
        _avatarView.userInteractionEnabled = YES;
        _avatarView.size = CGSizeMake(kAvaterSize, kAvaterSize);
        _avatarView.top = kTopBtmMargin;
        _avatarView.left = kLeftRightMargin;
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarView.clipsToBounds = YES;
//        [_iconImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImgClick)]];
    }
    return _avatarView;
}

// 名称
- (YYLabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[YYLabel alloc] init];
        _nameLab.top = kTopBtmMargin;
        _nameLab.left = kMomentsContentLeft;
        _nameLab.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _nameLab.displaysAsynchronously = YES;
        _nameLab.ignoreCommonProperties = YES;
        _nameLab.fadeOnAsynchronouslyDisplay = NO;
        _nameLab.fadeOnHighlight = NO;
    }
    return _nameLab;
}

- (YYLabel *)locLab {
    if (!_locLab) {
        _locLab = [[YYLabel alloc] init];
        _locLab.hidden = YES;
        _locLab.displaysAsynchronously = YES;
        _locLab.ignoreCommonProperties = YES;
        _locLab.fadeOnAsynchronouslyDisplay = NO;
        _locLab.fadeOnHighlight = NO;
        _locLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _locLab.left = kMomentsContentLeft;
    }
    return _locLab;
}

//时间 和 来源
- (YYLabel *)timeAndSourceLab {
    if (!_timeAndSourceLab) {
        _timeAndSourceLab = [[YYLabel alloc] init];
        _timeAndSourceLab.left = kMomentsContentLeft;
        _timeAndSourceLab.ignoreCommonProperties = YES;
        _timeAndSourceLab.displaysAsynchronously = YES;
        _timeAndSourceLab.fadeOnHighlight = NO;
        _timeAndSourceLab.fadeOnAsynchronouslyDisplay = NO;
        _timeAndSourceLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _timeAndSourceLab;
}

//内容
- (YYLabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[YYLabel alloc] init];
        _contentLab.left = kMomentsContentLeft;
        _contentLab.width = kMomentsContentWidth;
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
        _cardView.left = kMomentsContentLeft;
        _cardView.width = kMomentsContentWidth;
        _cardView.height = kMomentsCardH;
        _cardView.hidden = YES;
    }
    return _cardView;
}

//评论
- (ZXGMomentsCommentView *)commentView {
    if (!_commentView) {
        _commentView = [[ZXGMomentsCommentView alloc] init];
        _commentView.left = kMomentsContentLeft;
        _commentView.width = kMomentsContentWidth;
    }
    return _commentView;
}

//点赞 评论 按钮
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:GET_IMAGE(@"AlbumOperateMore") forState:UIControlStateNormal];
        [_moreBtn setImage:GET_IMAGE(@"AlbumOperateMoreHL") forState:UIControlStateHighlighted];
        [_moreBtn setImageEdgeInsets:UIEdgeInsetsZero];
        [_moreBtn sizeToFit];
        _moreBtn.left = SCREEN_WIDTH - kLeftRightMargin - _moreBtn.width;
        [_moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

//删除 按钮
- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setTitleColor:RGB(84, 95, 141) forState:UIControlStateNormal];
        [_delBtn sizeToFit];
        _delBtn.titleLabel.font = SYSTEMFONT(12);
        _delBtn.hidden = YES;
        [_delBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

//
- (ZXGMomentsOperationMenu *)operationMenu {
    if (!_operationMenu) {
        _operationMenu = [[ZXGMomentsOperationMenu alloc] init];
    }
    return _operationMenu;
}

@end



@implementation ZXGMomentsCell

#pragma mark - Overwrite
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGBA(255, 254, 255, 1.0);
        _momentsView = [[ZXGMomentsView alloc] init];
        [self.contentView addSubview:_momentsView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - ZXGTableViewCellAble
- (void)settingModel:(id<ZXGTableViewCellModelAble>)model secModel:(ZXGBaseTableViewSectionModel *)secModel indexPath:(NSIndexPath *)indexPath {
    ZXGMomentsLayout *layout = (ZXGMomentsLayout *)model;
    self.contentView.height = layout.rowHeight;
    _momentsView.cell = self;
    _momentsView.cardView.cell = self;
    _momentsView.layout = layout;
}

@end
