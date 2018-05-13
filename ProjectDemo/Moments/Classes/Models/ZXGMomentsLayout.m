//
//  ZXGMomentsLayout.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsLayout.h"

@implementation ZXGMomentsLayout

- (instancetype)init {
    return [self initWithMoments:nil];
}

- (instancetype)initWithMoments:(ZXGMomentModel *)moments {
    self = [super init];
    if (self) {
        _momentsModel = moments;
        [self layout];
    }
    return self;
}

#pragma mark - Init
- (void)layout {
    // 文本排版，计算布局
    
    [self layoutName];
    [self layoutContent];
    [self layoutAllBtn];
    [self layoutPics]; // 配图优先级高于卡片
    if (_picHeight == 0) {
        [self layoutCard];
    }
    [self layoutLoction];
    [self layoutTime];
    [self layoutComment];
    
    // 计算高度
    _rowHeight = 0;
    _rowHeight += kTopBtmMargin;
    _rowHeight += _nameHeight;
    _rowHeight += kVMargin;
    _rowHeight += _textHeight;
    _rowHeight += kVMargin;
    if (_allHeight > 0) {
        _rowHeight += _allHeight;
        _rowHeight += kVMargin;
    }
    if (_picHeight > 0) {
        _rowHeight += _picHeight;
        _rowHeight += kVMargin;
    } else if (_cardHeight > 0) {
        _rowHeight += _cardHeight;
        _rowHeight += kVMargin;
    }
    
    if (_locHeight > 0) {
        _rowHeight += _locHeight;
        _rowHeight += kVMargin;
    }
    
    _rowHeight += _publichTimeHeight;
    _rowHeight += kVMargin;
    
    if (_comHeight > 0) {
        _rowHeight += _comHeight;
    }
    
    _rowHeight += kTopBtmMargin;
    if (_rowHeight < 2 * kTopBtmMargin + kAvaterSize) {
        _rowHeight = 2 * kTopBtmMargin + kAvaterSize;
    }
    
}

- (void)resetLayout {
    _rowHeight = _rowHeight - _textHeight;
    if (_momentsModel.isExpand) {
        _textHeight = _textLayout.textBoundingSize.height / _textLayout.lines.count * 6;
    }
    else {
       _textHeight = _textHeight / 6 * _textLayout.lines.count;
    }
    _rowHeight = _rowHeight + _textHeight;
}

#pragma mark - Private
- (void)layoutName {
    _nameHeight = 0;
    _nameTextLayout = nil;
    
    NSString *nickName = _momentsModel.nickName;
    if (!nickName || nickName.length == 0) return;
    
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:nickName];
    text.color = kMomentsNameColor;
    text.font = BOLDSYSTEMFONT(kNameFontSize);
    //高亮背景
    YYTextBorder *border = [[YYTextBorder alloc] init];
    [border setInsets:UIEdgeInsetsMake(0, -2, 0, -2)];
    [border setFillColor:kLightGrayColor];
    //高亮
    YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
    [highlight setBackgroundBorder:border];
    [text setTextHighlight:highlight range:NSMakeRange(0, text.length)];
    
    ZXGMomentsTextLinePositionModifier *linePositionModifier = [[ZXGMomentsTextLinePositionModifier alloc] init];
    linePositionModifier.font = FONT(@"Heiti SC", kNameFontSize);
    linePositionModifier.paddingTop = kMomentsCellPaddingText;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, CGFLOAT_MAX)];
    container.maximumNumberOfRows = 1;
    container.truncationType = YYTextTruncationTypeEnd;
    container.linePositionModifier = linePositionModifier;
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _nameHeight = _nameTextLayout.textBoundingSize.height;
}

// 文本
- (void)layoutContent {
    _textHeight = 0;
    _textLayout = nil;
    
    NSString *content = _momentsModel.content;
    if (!content || content.length == 0) return;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:content];
    if (text.length == 0) return;
    text.color = kBlackColor;
    text.font = SYSTEMFONT(kContentFontSize);
    
    ZXGMomentsTextLinePositionModifier *modifier = [[ZXGMomentsTextLinePositionModifier alloc] init];
    modifier.font = FONT(@"Heiti SC", kContentFontSize);
    
    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.size = CGSizeMake(kMomentsContentWidth, HUGE);
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    
    // 判断是否显示 '全文'/'收起'
    // 字数大于等于100 且 行数大于等于6行 显示
    if (content && content.length >= 100 && _textLayout && _textLayout.lines.count >= 6 && !_momentsModel.isExpand) {
        // 判断是 折叠 / 全文 状态
        _textHeight = _textLayout.textBoundingSize.height / _textLayout.lines.count * 6;
    }
    else {        
        _textHeight = _textLayout.textBoundingSize.height;
    }
    
}

// 全文
- (void)layoutAllBtn {
    _allHeight = 0;
    _allLayout = nil;
    
    // 字数大于等于100 且 行数大于等于6行 显示
    NSString *content = _momentsModel.content;
    if (content && content.length >= 100 && _textLayout && _textLayout.lines.count >= 6) {
        // 判断是 折叠 / 全文 状态
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
        if (_momentsModel.isExpand) {
            text = [[NSMutableAttributedString alloc] initWithString:@"收起"];
        }
        else {
            text = [[NSMutableAttributedString alloc] initWithString:@"全文"];
        }
        // 高亮状态的背景
        YYTextBorder *highlightBorder = [[YYTextBorder alloc] init];
        highlightBorder.insets = UIEdgeInsetsZero;
        highlightBorder.fillColor = kMomentsTextHighlightBackgroundColor;
        
        // 高亮状态
        YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
        [highlight setBackgroundBorder:highlightBorder];
//        highlight.userInfo = @{kWBLinkURLName : wburl}; // 数据信息，用于稍后用户点击
        [text setTextHighlight:highlight range:NSMakeRange(0, text.length)];
        
        text.font = SYSTEMFONT(kContentFontSize);
        text.color = kMomentsNameColor;
        YYTextContainer *container = [[YYTextContainer alloc] init];
        container.size = CGSizeMake(HUGE, HUGE);
        _allLayout = [YYTextLayout layoutWithContainer:container text:text];
        _allHeight = _allLayout.textBoundingSize.height;
    }
}

- (void)layoutPics {
    _picHeight = 0;
    _picSize = CGSizeZero;
    
    if (_momentsModel.images.count == 0) return;
    
    CGFloat picHeight = 0;
    CGSize picSize = CGSizeZero;
    //每张图片的宽度
    CGFloat len1_3 = (kMomentsContentWidth + kMomentsCellPaddingPic) / 3 - kMomentsCellPaddingPic;
    len1_3 = CGFloatPixelRound(len1_3);
    switch (_momentsModel.images.count) {
        case 1: {
        
            CGSize singleImgSize = CGSizeZero;
            
            CGFloat maxW = kMomentsContentWidth * 0.7;
            CGFloat maxH = SCREEN_HEIGHT * 0.25;
            
            CGFloat singleW = [_momentsModel.picWidth floatValue];
            CGFloat singleH = [_momentsModel.picHeight floatValue];
            
            if (singleW > singleH) { //以宽为准  横图
                if (singleW >= maxW) {
                    singleImgSize = CGSizeMake(maxW, maxW * (singleH / singleW));
//                    NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
                }
                else if (singleW < maxW) {
                    singleImgSize = CGSizeMake(singleW, singleH);
//                    NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
                }
            }
            else if (singleW < singleH) { //以高为准 竖图
                if (singleH >= maxH) {
                    singleImgSize = CGSizeMake(maxH * (singleW / singleH), maxH);
//                    NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
                }
                else if (singleH < maxH) {
                    singleImgSize = CGSizeMake(singleW, singleH);
//                    NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
                }
            }
            else if (singleW == singleH) { //宽=高 正方形图片
                if (maxW > maxH) {
                    
                    if (maxH >= singleH) {
                        singleImgSize = CGSizeMake(singleW, singleH);
                    }
                    else if (maxH < singleH) {
                        singleImgSize = CGSizeMake(maxH, maxH);
                    }
                }
                else if (maxW < maxH) {
                    singleImgSize = CGSizeMake(maxW, maxW);
                    
                    if (maxW >= singleH) {
                        singleImgSize = CGSizeMake(singleW, singleH);
                    }
                    else if (maxW < singleH) {
                        singleImgSize = CGSizeMake(maxW, maxW);
                    }
                }
                else if (maxW == maxH) {
                    if (maxH >= singleH) {
                        singleImgSize = CGSizeMake(singleW, singleH);
                    }
                    else if (maxH < singleH) {
                        singleImgSize = CGSizeMake(maxH, maxH );
                    }
                }
            }
            
            picSize = singleImgSize;
            picHeight = singleImgSize.height;
        }
            break;
        case 2: case 3: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        }
            break;
        case 4: case 5: case 6: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kMomentsCellPaddingPic;
        }
            break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 3 + kMomentsCellPaddingPic * 2;
        }
            break;
    }
    
    _picSize = picSize;
    _picHeight = picHeight;
}

- (void)layoutCard {
//    _cardType = WBStatusCardTypeNone;
    _cardHeight = 0;
    _cardTextLayout = nil;
    _cardTextRect = CGRectZero;
    
    NSInteger pagetype = _momentsModel.pagetype;
    if (pagetype == 0) return;
    
//    WBStatusCardType cardType = WBStatusCardTypeNone;
    _cardHeight = kCardHVMargin * 2 + kAvaterSize;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_momentsModel.title];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth - 3 * kCardHVMargin - kAvaterSize, kAvaterSize)];
    container.maximumNumberOfRows = 0;
    container.truncationType = YYTextTruncationTypeEnd;
    _cardTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    
}

- (void)layoutLoction {
    _locHeight = 0;
    _locTextLayout = nil;
    
    if (!_momentsModel.locaionMsg || !_momentsModel.locaionMsg.name || _momentsModel.locaionMsg.name.length == 0) {
        return;
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_momentsModel.locaionMsg.name];
    text.font = SYSTEMFONT(kLoctionFontSize);
    text.color = kMomentsNameColor;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, HUGE)];
    container.maximumNumberOfRows = 1;
    
    _locTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _locHeight = _locTextLayout.textBoundingSize.height;
}

- (void)layoutTime {
    _publichTimeHeight = 0;
    _publichTimeTextLayout = nil;
    
    NSString *time = [_momentsModel.createTime stringValue];
    NSRange range = NSMakeRange(0, 0);
    if (STRING_EQUAL(@"18539951882", _momentsModel.userId)) {
        time = [NSString stringWithFormat:@"%@\t\t\t\t\t\t\t\t%@", time, @"删除"];
        range = [time rangeOfString:@"删除"];
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:time];
    text.font = SYSTEMFONT(kTimeFontSize);
    text.color = kGrayColor;
    [text setColor:kMomentsNameColor range:range];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth * 0.7, HUGE)];
    container.maximumNumberOfRows = 1;
    
    _publichTimeTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _publichTimeHeight = _publichTimeTextLayout.textBoundingSize.height;
}

- (void)layoutComment {
    _comHeight = 0.f;
    NSArray *comments = _momentsModel.comments;
    NSArray *likes = _momentsModel.likes;
    
    _comTextLayouts = [NSMutableArray array];
    
    // 点赞语句
    NSMutableString *tempStr = @"".mutableCopy;
    if (likes.count > 0) {
        for (ZXGMomentsLikeModel *model in likes) {
            [tempStr appendFormat:@"，%@", model.memberName];
        }
        if ([tempStr hasPrefix:@"，"]) {
            [tempStr deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        
        
        UIImage *likeImage = [UIImage imageNamed:@"AlbumCommentLike"];
        NSAttributedString *likeText = [self attachmentWithFontSize:kComFontSize image:likeImage shrink:NO];

        NSMutableAttributedString *likeString = [[NSMutableAttributedString alloc] initWithString:tempStr];
        [likeString insertAttributedString:likeText atIndex:0];
        [likeString setFont:SYSTEMFONT(kComFontSize)];
        
        for (ZXGMomentsLikeModel *model in likes) {
            NSRange range = [tempStr rangeOfString:model.memberName];
            range = NSMakeRange(range.location + 1, range.length);
            
            [likeString setFont:BOLDSYSTEMFONT(kComFontSize) range:range];
            [likeString setColor:kMomentsNameColor range:range];
            //高亮
            YYTextBorder *border = [[YYTextBorder alloc] init];
            border.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            border.fillColor = kLightGrayColor;
            YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
            [highlight setBackgroundBorder:border];
            [likeString setTextHighlight:highlight range:range];
        }
        
        YYTextContainer *likeContain = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, HUGE) insets:UIEdgeInsetsMake(kMomentsCellPaddingCom, kMomentsCellPaddingComH, kMomentsCellPaddingCom, kMomentsCellPaddingComH)];
        YYTextLayout *likeTextLayout = [YYTextLayout layoutWithContainer:likeContain text:likeString];
        [_comTextLayouts addObject:likeTextLayout];
        _comHeight += likeTextLayout.textBoundingSize.height;
        
    }
    
    // 评论语句
    if (comments.count > 0) {
        
        for (ZXGMomentsCommentModel *model in comments) {
            NSMutableAttributedString *text = nil;
            // 标记名称文字
            if (model.replyMemberName && model.replyMemberName.length > 0) {
                
                NSString *comment = [NSString stringWithFormat:@"%@回复%@: %@", model.memberName, model.replyMemberName, model.content];
                text = [[NSMutableAttributedString alloc] initWithString:comment];
                [text setFont:SYSTEMFONT(kComFontSize)];
                NSRange range = [comment rangeOfString:model.memberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:range];
                [text setColor:kMomentsNameColor range:range];
                
                NSRange replyRange = [comment rangeOfString:model.replyMemberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:replyRange];
                [text setColor:kMomentsNameColor range:replyRange];
                
                //高亮
                YYTextBorder *border = [[YYTextBorder alloc] init];
                border.insets = UIEdgeInsetsMake(0, 0, 0, 0);
                border.fillColor = kLightGrayColor;
                YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
                [highlight setBackgroundBorder:border];
                [text setTextHighlight:highlight range:range];
                [text setTextHighlight:highlight range:replyRange];
            }
            else {
                
                NSString *comment = [NSString stringWithFormat:@"%@: %@", model.memberName, model.content];
                text = [[NSMutableAttributedString alloc] initWithString:comment];
                
                [text setFont:SYSTEMFONT(kComFontSize)];
                NSRange range = [comment rangeOfString:model.memberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:range];
                [text setColor:kMomentsNameColor range:range];
                //高亮
                YYTextBorder *border = [[YYTextBorder alloc] init];
                border.insets = UIEdgeInsetsMake(0, 0, 0, 0);
                border.fillColor = kLightGrayColor;
                YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
                [highlight setBackgroundBorder:border];
                [text setTextHighlight:highlight range:range];
            }
                        
            YYTextContainer *contain = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, HUGE) insets:UIEdgeInsetsMake(kMomentsCellPaddingCom, kMomentsCellPaddingComH, kMomentsCellPaddingCom, kMomentsCellPaddingComH)];
            YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:contain text:text];
            [_comTextLayouts addObject:textLayout];
            _comHeight += textLayout.textBoundingSize.height;
        }
    }
    
}

- (NSAttributedString *)attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {
    
    //    CGFloat ascent = YYEmojiGetAscentWithFontSize(fontSize);
    //    CGFloat descent = YYEmojiGetDescentWithFontSize(fontSize);
    //    CGRect bounding = YYEmojiGetGlyphBoundingRectWithFontSize(fontSize);
    
    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

@end

/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@implementation ZXGMomentsTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    ZXGMomentsTextLinePositionModifier *one = [[self.class allocWithZone:zone] init];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end


