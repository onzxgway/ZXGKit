//
//  WBStatusCell.m
//  SinaWeibo
//
//  Created by 朱献国 on 2018/4/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "WBStatusCell.h"
#import "ZXGPictureView.h"
#import "WBStatusHelper.h"

@implementation WBStatusTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREEN_WIDTH;
        frame.size.height = kWBCellTitleHeight;
    }
    self = [super initWithFrame:frame];
    
    _titleLabel = [[YYLabel alloc] init];
    _titleLabel.size = CGSizeMake(SCREEN_WIDTH - 100, self.height);
    _titleLabel.left = kWBCellPadding;
    _titleLabel.displaysAsynchronously = YES;
    _titleLabel.ignoreCommonProperties = YES;
    _titleLabel.fadeOnHighlight = NO;
    _titleLabel.fadeOnAsynchronouslyDisplay = NO;
    [self addSubview:_titleLabel];
    
    CALayer *btmline = [CALayer layer];
    btmline.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    btmline.bottom = self.height;
    btmline.backgroundColor = kWBCellLineColor.CGColor;
    [self.layer addSublayer:btmline];
    self.exclusiveTouch = YES;
    
    return self;
}

@end


@implementation WBStatusProfileView {
    BOOL _trackingTouch;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREEN_WIDTH;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    
    self.exclusiveTouch = YES;

    // 头像
    _avatarView = [UIImageView new];
    _avatarView.size = CGSizeMake(40, 40);
    _avatarView.origin = CGPointMake(kWBCellPadding, kWBCellPadding + 3);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatarView];
    
    CALayer *avatarBorder = [CALayer layer];
    avatarBorder.frame = _avatarView.bounds;
    avatarBorder.borderWidth = CGFloatFromPixel(1);
    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    avatarBorder.cornerRadius = _avatarView.height / 2;
    avatarBorder.shouldRasterize = YES;
    avatarBorder.rasterizationScale = kScreenScale;
    [_avatarView.layer addSublayer:avatarBorder];
    
    _avatarBadgeView = [UIImageView new];
    _avatarBadgeView.size = CGSizeMake(14, 14);
    _avatarBadgeView.center = CGPointMake(_avatarView.right - 6, _avatarView.bottom - 6);
    _avatarBadgeView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_avatarBadgeView];
    
    // 名称
    _nameLabel = [YYLabel new];
    _nameLabel.size = CGSizeMake(kWBCellNameWidth, 24);
    _nameLabel.left = _avatarView.right + kWBCellNamePaddingLeft;
    _nameLabel.centerY = 27;
    _nameLabel.displaysAsynchronously = YES;
    _nameLabel.ignoreCommonProperties = YES;
    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
    _nameLabel.fadeOnHighlight = NO;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:_nameLabel];
    
    //来源
    _sourceLabel = [YYLabel new];
    _sourceLabel.frame = _nameLabel.frame;
    _sourceLabel.centerY = 47;
    _sourceLabel.displaysAsynchronously = YES;
    _sourceLabel.ignoreCommonProperties = YES;
    _sourceLabel.fadeOnAsynchronouslyDisplay = NO;
    _sourceLabel.fadeOnHighlight = NO;
//    @weakify(self);
    _sourceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        if ([weak_self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
//            [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
//        }
    };
    [self addSubview:_sourceLabel];
    
    return self;
}

@end



@implementation WBStatusCardView {
    BOOL _isRetweet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0){
        frame.size.width = SCREEN_WIDTH;
        frame.origin.x = kWBCellPadding;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    //
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    //
    _badgeImageView = [UIImageView new];
    _badgeImageView.clipsToBounds = YES;
    _badgeImageView.contentMode = UIViewContentModeScaleAspectFit;
    //
    _label = [YYLabel new];
    _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _label.numberOfLines = 3;
    _label.ignoreCommonProperties = YES;
    _label.displaysAsynchronously = YES;
    _label.fadeOnAsynchronouslyDisplay = NO;
    _label.fadeOnHighlight = NO;
    //
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_imageView];
    [self addSubview:_badgeImageView];
    [self addSubview:_label];
    [self addSubview:_button];
    self.backgroundColor = kWBCellInnerViewColor;
    self.layer.borderWidth = CGFloatFromPixel(1);
    self.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.070].CGColor;
    
    return self;
}

- (void)setWithLayout:(ZXGWBStatusLayout *)layout isRetweet:(BOOL)isRetweet {
    ZXGWBPageInfo *pageInfo = isRetweet ? layout.status.retweetedStatus.pageInfo : layout.status.pageInfo;
    if (!pageInfo) return;
    self.height = isRetweet ? layout.retweetCardHeight : layout.cardHeight;
    
    /*
     badge: 25,25 左上角 (42)
     image: 70,70 方形
     100, 70 矩形
     btn:  60,70
     
     lineheight 20
     padding 10
     */
    
    _isRetweet = isRetweet;
    switch (isRetweet ? layout.retweetCardType : layout.cardType) {
        case WBStatusCardTypeNone: {
            
        } break;
        case WBStatusCardTypeNormal: {
            self.width = kWBCellContentWidth;
            if (pageInfo.typeIcon) {
                _badgeImageView.hidden = NO;
                _badgeImageView.frame = CGRectMake(0, 0, 25, 25);
                [_badgeImageView setImageWithURL:pageInfo.typeIcon placeholder:nil];
            } else {
                _badgeImageView.hidden = YES;
            }
            if (pageInfo.pagePic) {
                _imageView.hidden = NO;
                if (pageInfo.typeIcon) {
                    _imageView.frame = CGRectMake(0, 0, 100, 70);
                } else {
                    _imageView.frame = CGRectMake(0, 0, 70, 70);
                }
                [_imageView setImageWithURL:pageInfo.pagePic placeholder:nil];
            } else {
                _imageView.hidden = YES;
            }
            _label.hidden = NO;
            _label.frame = isRetweet ? layout.retweetCardTextRect : layout.cardTextRect;
            _label.textLayout = isRetweet ? layout.retweetCardTextLayout : layout.cardTextLayout;
            WBButtonLink *button = pageInfo.buttons.firstObject;
            if (button.pic && button.name) {
                _button.hidden = NO;
                _button.size = CGSizeMake(60, 70);
                _button.top = 0;
                _button.right = self.width;
                [_button setTitle:button.name forState:UIControlStateNormal];
                [_button setImageWithURL:button.pic forState:UIControlStateNormal placeholder:nil];
            } else {
                _button.hidden = YES;
            }
        }break;
        case WBStatusCardTypeVideo: {
            self.width = self.height;
            _badgeImageView.hidden = YES;
            _label.hidden = YES;
            _imageView.frame = self.bounds;
            [_imageView setImageWithURL:pageInfo.pagePic options:kNilOptions];
            _button.hidden = NO;
            _button.frame = self.bounds;
            [_button setTitle:nil forState:UIControlStateNormal];
            [_button cancelImageRequestForState:UIControlStateNormal];
            [_button setImage:GET_IMAGE(@"multimedia_videocard_play") forState:UIControlStateNormal];
            
        } break;
        default: {
            
        } break;
    }
    
    self.backgroundColor = isRetweet ? [UIColor whiteColor] : kWBCellInnerViewColor;
}

@end


@implementation WBStatusTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    @weakify(self);
    //
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageWithColor:kWBCellBackgroundColor] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.000 alpha:0.200]] forState:UIControlStateHighlighted];
    [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickTag:)]) {
//            [weak_self.cell.delegate cellDidClickTag:weak_self.cell];
//        }
    }];
    _button.hidden = YES;
    [self addSubview:_button];
    
    //
    _label = [YYLabel new];
    _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _label.displaysAsynchronously = YES;
    _label.ignoreCommonProperties = YES;
    _label.fadeOnHighlight = NO;
    _label.fadeOnAsynchronouslyDisplay = NO;
    _label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        if ([weak_self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
//            [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
//        }
    };
    [self addSubview:_label];
    
    //
    _imageView = [UIImageView new];
    _imageView.size = CGSizeMake(kWBCellTagPlaceHeight, kWBCellTagPlaceHeight);
    _imageView.image = GET_IMAGE(@"timeline_icon_locate");
    _imageView.hidden = YES;
    [self addSubview:_imageView];
    
    _label.height = kWBCellTagPlaceHeight;
    _button.height = kWBCellTagPlaceHeight;
    self.height = kWBCellTagPlaceHeight;
    return self;
}

- (void)setWithLayout:(ZXGWBStatusLayout *)layout {
    if (layout.tagType == WBStatusTagTypePlace) {
        _label.height = kWBCellTagPlaceHeight;
        _imageView.hidden = NO;
        _button.hidden = NO;
        
        _label.left = _imageView.right + 6;
        _label.width = layout.tagTextLayout.textBoundingRect.size.width + 6;
        _label.textLayout = layout.tagTextLayout;
        _label.userInteractionEnabled = NO;
        
        self.width = _label.right;
        _label.width = self.width;
        _button.width = self.width;
    } else if (layout.tagType == WBStatusTagTypeNormal) {
        _imageView.hidden = YES;
        _button.hidden = YES;
        
        _label.left = 0;
        _label.width = layout.tagTextLayout.textBoundingRect.size.width + 1;
        _label.userInteractionEnabled = YES;
        _label.textLayout = layout.tagTextLayout;
    }
}

@end


@implementation WBStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREEN_WIDTH;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        self.exclusiveTouch = YES;
//        @weakify(self);
        
        // 容器视图
        _contentView = [[UIView alloc] init];
        _contentView.width = SCREEN_WIDTH;
        _contentView.height = 1;
        _contentView.backgroundColor = kRedColor;
        [self addSubview:_contentView];
        
        static UIImage *topLineBG, *bottomLineBG;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
                CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
                CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
                CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
                CGContextFillPath(context);
            }];
            bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
                CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
                CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
                CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
                CGContextFillPath(context);
            }];
        });
        
        // 顶部分割线
        UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
        topLine.width = _contentView.width;
        topLine.bottom = 0;
        topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_contentView addSubview:topLine];
        
        // 底部分割线
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
        bottomLine.width = _contentView.width;
        bottomLine.top = _contentView.height;
        bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_contentView addSubview:bottomLine];
        
        // 标题栏
        _titleView = [[WBStatusTitleView alloc] init];
        _titleView.hidden = YES;
        _titleView.backgroundColor = kRandomColor;
        [_contentView addSubview:_titleView];
        
        // 用户资料
        _profileView = [[WBStatusProfileView alloc] init];
        _profileView.backgroundColor = kRandomColor;
        [_contentView addSubview:_profileView];
        
        // vip图片
        _vipBackgroundView = [[UIImageView alloc] init];
        _vipBackgroundView.size = CGSizeMake(SCREEN_WIDTH, 14.0);
        _vipBackgroundView.top = -2;
        _vipBackgroundView.contentMode = UIViewContentModeTopRight;
        [_contentView addSubview:_vipBackgroundView];
        
        // 更多按钮
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuButton.size = CGSizeMake(30, 30);
        [_menuButton setImage:GET_IMAGE(@"timeline_icon_more") forState:UIControlStateNormal];
        [_menuButton setImage:GET_IMAGE(@"timeline_icon_more_highlighted") forState:UIControlStateHighlighted];
        _menuButton.centerX = self.width - 20;
        _menuButton.centerY = 18;
        [_menuButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//            if ([weak_self.cell.delegate respondsToSelector:@selector(cellDidClickMenu:)]) {
//                [weak_self.cell.delegate cellDidClickMenu:weak_self.cell];
//            }
        }];
        [_contentView addSubview:_menuButton];
        
        // 转发容器
        _retweetBackgroundView = [[UIView alloc] init];
        _retweetBackgroundView.backgroundColor = UIColorHex(f7f7f7);
        _retweetBackgroundView.width = SCREEN_WIDTH;
        [_contentView addSubview:_retweetBackgroundView];
        
        // 原创文本
        _textLabel = [[YYLabel alloc] init];
        _textLabel.left = kWBCellPadding;
        _textLabel.width = kWBCellContentWidth;
        _textLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _textLabel.displaysAsynchronously = YES;
        _textLabel.ignoreCommonProperties = YES;
        _textLabel.fadeOnAsynchronouslyDisplay = NO;
        _textLabel.fadeOnHighlight = NO;
        _textLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            if ([weak_self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
//                [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
//            }
        };
        _textLabel.backgroundColor = kRandomColor;
        [_contentView addSubview:_textLabel];
        
        // 转发文本
        _retweetTextLabel = [YYLabel new];
        _retweetTextLabel.left = kWBCellPadding;
        _retweetTextLabel.width = kWBCellContentWidth;
        _retweetTextLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _retweetTextLabel.displaysAsynchronously = YES;
        _retweetTextLabel.ignoreCommonProperties = YES;
        _retweetTextLabel.fadeOnAsynchronouslyDisplay = NO;
        _retweetTextLabel.fadeOnHighlight = NO;
        _retweetTextLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            if ([weak_self.cell.delegate respondsToSelector:@selector(cell:didClickInLabel:textRange:)]) {
//                [weak_self.cell.delegate cell:weak_self.cell didClickInLabel:(YYLabel *)containerView textRange:range];
//            }
        };
        [_contentView addSubview:_retweetTextLabel];
        
        // 配图
        NSMutableArray *picViews = [NSMutableArray arrayWithCapacity:9];
        for (int i = 0; i < 9; i++) {
            // 配图
            ZXGPictureView *imageView = [[ZXGPictureView alloc] init];
            imageView.size = CGSizeMake(100, 100);
            imageView.hidden = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = kWBCellHighlightColor;
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
            
            // 角标
            UIView *badge = [[UIImageView alloc] init];
            badge.userInteractionEnabled = NO;
            badge.contentMode = UIViewContentModeScaleAspectFit;
            badge.size = CGSizeMake(56 / 2, 36 / 2);
            badge.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
            badge.right = imageView.width;
            badge.bottom = imageView.height;
            badge.hidden = YES;
            [imageView addSubview:badge];
            
            [picViews addObject:imageView];
            [_contentView addSubview:imageView];
        }
        _picViews = picViews;
        
        // 链接卡片
        _cardView = [WBStatusCardView new];
        _cardView.hidden = YES;
        [_contentView addSubview:_cardView];
        
        //
        _tagView = [WBStatusTagView new];
        _tagView.left = kWBCellPadding;
        _tagView.hidden = YES;
        [_contentView addSubview:_tagView];
        
        // 底部 转发评论赞 工具条
        _toolbarView = [[WBStatusToolbarView alloc] init];
        [_contentView addSubview:_toolbarView];
    }
    return self;
}

- (void)setLayout:(ZXGWBStatusLayout *)layout {
    _layout = layout;
    //
    self.height = layout.rowHeight;
    
    //
    _contentView.top = layout.marginTop;
    _contentView.height = layout.rowHeight - layout.marginTop - layout.marginBottom;
    
    // 标题栏
    CGFloat top = 0;
    if (layout.titleHeight > 0) {
        _titleView.hidden = NO;
        _titleView.height = layout.titleHeight;
        _titleView.titleLabel.textLayout = layout.titleTextLayout;
        top = layout.titleHeight;
    }
    else {
        _titleView.hidden = YES;
    }
    
    // 个人资料
    [_profileView.avatarView setImageWithURL:layout.status.user.avatarLarge //profileImageURL
                                 placeholder:nil
                                     options:kNilOptions
                                     manager:[WBStatusHelper avatarImageManager] // 圆角头像manager，内置圆角处理
                                    progress:nil
                                   transform:nil
                                  completion:nil];
    _profileView.nameLabel.textLayout = layout.nameTextLayout;
    _profileView.sourceLabel.textLayout = layout.sourceTextLayout;
//    _profileView.verifyType = layout.status.user.userVerifyType;
    _profileView.height = layout.profileHeight;
    _profileView.top = top;
    top += layout.profileHeight;
    
    // vip自定义图片
    NSURL *picBg = [WBStatusHelper defaultURLForImageURL:layout.status.picBg];
    __weak typeof(_vipBackgroundView) vipBackgroundView = _vipBackgroundView;
    [_vipBackgroundView setImageWithURL:picBg placeholder:nil options:YYWebImageOptionAvoidSetImage completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (image) {
            image = [UIImage imageWithCGImage:image.CGImage scale:2.0 orientation:image.imageOrientation];
            vipBackgroundView.image = image;
        }
    }];
    
    //
    _textLabel.top = top;
    _textLabel.height = layout.textHeight;
    _textLabel.textLayout = layout.textLayout;
    top += layout.textHeight;
    
    //
    _retweetBackgroundView.hidden = YES;
    _retweetTextLabel.hidden = YES;
    _cardView.hidden = YES;
    if (layout.picHeight == 0 && layout.retweetPicHeight == 0) {
        [self _hideImageViews];
    }
    
    
    // 优先级是 转发->图片->卡片
    if (layout.retweetHeight > 0) {
        _retweetBackgroundView.top = top;
        _retweetBackgroundView.height = layout.retweetHeight;
        _retweetBackgroundView.hidden = NO;
        
        _retweetTextLabel.top = top;
        _retweetTextLabel.height = layout.retweetTextHeight;
        _retweetTextLabel.textLayout = layout.retweetTextLayout;
        _retweetTextLabel.hidden = NO;
        
        if (layout.retweetPicHeight > 0) {
            [self _setImageViewWithTop:_retweetTextLabel.bottom isRetweet:YES];
        }
        else {
            [self _hideImageViews];
            if (layout.retweetCardHeight > 0) {
                _cardView.top = _retweetTextLabel.bottom;
                _cardView.hidden = NO;
                [_cardView setWithLayout:layout isRetweet:YES];
            }
        }
    }
    else if (layout.picHeight > 0) {
        [self _setImageViewWithTop:top isRetweet:NO];
    }
    else if (layout.cardHeight > 0) {
        _cardView.top = top;
        _cardView.hidden = NO;
        [_cardView setWithLayout:layout isRetweet:NO];
    }
    
    //
    if (layout.tagHeight > 0) {
        _tagView.hidden = NO;
        [_tagView setWithLayout:layout];
        _tagView.centerY = _contentView.height - kWBCellToolbarHeight - layout.tagHeight / 2;
    }
    else {
        _tagView.hidden = YES;
    }
    
    //
    _toolbarView.bottom = _contentView.height;
    [_toolbarView setWithLayout:layout];
}

- (void)_hideImageViews {
    for (UIImageView *imageView in _picViews) {
        imageView.hidden = YES;
    }
}

- (void)_setImageViewWithTop:(CGFloat)imageTop isRetweet:(BOOL)isRetweet {
    CGSize picSize = isRetweet ? _layout.retweetPicSize : _layout.picSize;
    NSArray *pics = isRetweet ? _layout.status.retweetedStatus.pics : _layout.status.pics;
    int picsCount = (int)pics.count;
    
    for (int i = 0; i < 9; i++) {
        UIView *imageView = _picViews[i];
        if (i >= picsCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = kWBCellPadding;
                    origin.y = imageTop;
                } break;
                case 4: {
                    origin.x = kWBCellPadding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                } break;
                default: {
                    origin.x = kWBCellPadding + (i % 3) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            ZXGWBPicture *pic = pics[i];
            
            UIView *badge = imageView.subviews.firstObject;
            switch (pic.largest.badgeType) {
                case WBPictureBadgeTypeNone: {
                    if (badge.layer.contents) {
                        badge.layer.contents = nil;
                        badge.hidden = YES;
                    }
                } break;
                case WBPictureBadgeTypeLong: {
                    badge.layer.contents = (__bridge id)(GET_IMAGE(@"timeline_image_longimage").CGImage);
                    badge.hidden = NO;
                } break;
                case WBPictureBadgeTypeGIF: {
                    badge.layer.contents = (__bridge id)(GET_IMAGE(@"timeline_image_gif").CGImage);
                    badge.hidden = NO;
                } break;
            }
            
            @weakify(imageView);
            [imageView.layer setImageWithURL:pic.bmiddle.url
                                 placeholder:nil
                                     options:YYWebImageOptionAvoidSetImage
                                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                      @strongify(imageView);
                                      if (!imageView) return;
                                      if (image && stage == YYWebImageStageFinished) {
                                          int width = pic.bmiddle.width;
                                          int height = pic.bmiddle.height;
                                          CGFloat scale = (height / width) / (imageView.height / imageView.width);
                                          if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                                              imageView.contentMode = UIViewContentModeScaleAspectFill;
                                              imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                                          } else { // 高图只保留顶部
                                              imageView.contentMode = UIViewContentModeScaleToFill;
                                              imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                                          }
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

@end


@implementation WBStatusToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREEN_WIDTH;
        frame.size.height = kWBCellToolbarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    
    //
    _repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _repostButton.exclusiveTouch = YES;
    _repostButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    [_repostButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    //
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.exclusiveTouch = YES;
    _commentButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    _commentButton.left = CGFloatPixelRound(self.width / 3.0);
    [_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    //
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.exclusiveTouch = YES;
    _likeButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    _likeButton.left = CGFloatPixelRound(self.width / 3.0 * 2.0);
    [_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    
    _repostImageView = [[UIImageView alloc] initWithImage:GET_IMAGE(@"timeline_icon_retweet")];
    _repostImageView.centerY = self.height / 2;
    [_repostButton addSubview:_repostImageView];
    _commentImageView = [[UIImageView alloc] initWithImage:GET_IMAGE(@"timeline_icon_comment")];
    _commentImageView.centerY = self.height / 2;
    [_commentButton addSubview:_commentImageView];
    _likeImageView = [[UIImageView alloc] initWithImage:GET_IMAGE(@"timeline_icon_unlike")];
    _likeImageView.centerY = self.height / 2;
    [_likeButton addSubview:_likeImageView];
    
    //
    _repostLabel = [YYLabel new];
    _repostLabel.userInteractionEnabled = NO;
    _repostLabel.height = self.height;
    _repostLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _repostLabel.displaysAsynchronously = YES;
    _repostLabel.ignoreCommonProperties = YES;
    _repostLabel.fadeOnHighlight = NO;
    _repostLabel.fadeOnAsynchronouslyDisplay = NO;
    [_repostButton addSubview:_repostLabel];
    
    //
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.height = self.height;
    _commentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _commentLabel.displaysAsynchronously = YES;
    _commentLabel.ignoreCommonProperties = YES;
    _commentLabel.fadeOnHighlight = NO;
    _commentLabel.fadeOnAsynchronouslyDisplay = NO;
    [_commentButton addSubview:_commentLabel];
    
    //
    _likeLabel = [YYLabel new];
    _likeLabel.userInteractionEnabled = NO;
    _likeLabel.height = self.height;
    _likeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _likeLabel.displaysAsynchronously = YES;
    _likeLabel.ignoreCommonProperties = YES;
    _likeLabel.fadeOnHighlight = NO;
    _likeLabel.fadeOnAsynchronouslyDisplay = NO;
    [_likeButton addSubview:_likeLabel];
    
    UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
    UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
    NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
    NSArray *locations = @[@0.2, @0.5, @0.8];
    
    //
    _line1 = [CAGradientLayer layer];
    _line1.colors = colors;
    _line1.locations = locations;
    _line1.startPoint = CGPointMake(0, 0);
    _line1.endPoint = CGPointMake(0, 1);
    _line1.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line1.left = _repostButton.right;
    
    //
    _line2 = [CAGradientLayer layer];
    _line2.colors = colors;
    _line2.locations = locations;
    _line2.startPoint = CGPointMake(0, 0);
    _line2.endPoint = CGPointMake(0, 1);
    _line2.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line2.left = _commentButton.right;
    
    //
    _topLine = [CALayer layer];
    _topLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    _topLine.backgroundColor = kWBCellLineColor.CGColor;
    
    //
    _bottomLine = [CALayer layer];
    _bottomLine.size = _topLine.size;
    _bottomLine.bottom = self.height;
    _bottomLine.backgroundColor = UIColorHex(e8e8e8).CGColor;
    
    [self addSubview:_repostButton];
    [self addSubview:_commentButton];
    [self addSubview:_likeButton];
    [self.layer addSublayer:_line1];
    [self.layer addSublayer:_line2];
    [self.layer addSublayer:_topLine];
    [self.layer addSublayer:_bottomLine];
    
//    @weakify(self);
    [_repostButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        WBStatusCell *cell = weak_self.cell;
//        if ([cell.delegate respondsToSelector:@selector(cellDidClickRepost:)]) {
//            [cell.delegate cellDidClickRepost:cell];
//        }
    }];
    
    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        WBStatusCell *cell = weak_self.cell;
//        if ([cell.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
//            [cell.delegate cellDidClickComment:cell];
//        }
    }];
    
    [_likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        WBStatusCell *cell = weak_self.cell;
//        if ([cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
//            [cell.delegate cellDidClickLike:cell];
//        }
    }];
    return self;
}

- (void)setWithLayout:(ZXGWBStatusLayout *)layout {
    _repostLabel.width = layout.toolbarRepostTextWidth;
    _commentLabel.width = layout.toolbarCommentTextWidth;
    _likeLabel.width = layout.toolbarLikeTextWidth;
    
    _repostLabel.textLayout = layout.toolbarRepostTextLayout;
    _commentLabel.textLayout = layout.toolbarCommentTextLayout;
    _likeLabel.textLayout = layout.toolbarLikeTextLayout;
    
    [self adjustImage:_repostImageView label:_repostLabel inButton:_repostButton];
    [self adjustImage:_commentImageView label:_commentLabel inButton:_commentButton];
    [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
    
    _likeImageView.image = layout.status.attitudesStatus ? [self likeImage] : [self unlikeImage];
}

- (UIImage *)likeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = GET_IMAGE(@"timeline_icon_like");
    });
    return img;
}

- (UIImage *)unlikeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = GET_IMAGE(@"timeline_icon_unlike");
    });
    return img;
}

- (void)adjustImage:(UIImageView *)image label:(YYLabel *)label inButton:(UIButton *)button {
    CGFloat imageWidth = image.bounds.size.width;
    CGFloat labelWidth = label.width;
    CGFloat paddingMid = 5;
    CGFloat paddingSide = (button.width - imageWidth - labelWidth - paddingMid) / 2.0;
    image.centerX = CGFloatPixelRound(paddingSide + imageWidth / 2);
    label.right = CGFloatPixelRound(button.width - paddingSide);
}

@end



@implementation WBStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf {
    self.backgroundView.backgroundColor = kBlackColor;
    self.contentView.backgroundColor = kRandomColor;
    self.backgroundColor = kBlackColor;
    
    _statusView = [[WBStatusView alloc] init];
    _statusView.backgroundColor = kRandomColor;
    _statusView.cell = self;
    _statusView.titleView.cell = self;
    _statusView.profileView.cell = self;
    _statusView.cardView.cell = self;
    _statusView.toolbarView.cell = self;
    _statusView.tagView.cell = self;
    [self.contentView addSubview:_statusView];
}

- (void)settingModel:(id<ZXGTableViewCellModelAble>)model secModel:(ZXGBaseTableViewSectionModel *)secModel indexPath:(NSIndexPath *)indexPath {
    ZXGWBStatusLayout *layout = (ZXGWBStatusLayout *)model;
    self.height = layout.rowHeight;
    self.contentView.height = layout.rowHeight;
    _statusView.layout = layout;
}

@end
