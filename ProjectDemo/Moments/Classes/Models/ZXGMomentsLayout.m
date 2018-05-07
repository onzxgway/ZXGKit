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

#pragma mark - Private
- (void)layoutName {
    _nameHeight = 0;
    _nameTextLayout = nil;
    
    NSString *nickName = _momentsModel.nickName;
    if (!nickName || nickName.length == 0) return;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:nickName];
    text.color = kMomentsNameColor;
    text.font = BOLDSYSTEMFONT(kNameFontSize);
    
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
    
    _textHeight = _textLayout.textBoundingSize.height;
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
            /**
            ZXGWBPicture *pic = _momentsModel.images.firstObject;
            ZXGWBPictureMetadata *bmiddle = pic.bmiddle;
            if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
                CGFloat maxLen = kWBCellContentWidth / 2.0;
                maxLen = CGFloatPixelRound(maxLen);
                picSize = CGSizeMake(maxLen, maxLen);
                picHeight = maxLen;
            } else {
                CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
                if (bmiddle.width < bmiddle.height) {
                    picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxLen;
                    picSize.height = maxLen;
                } else {
                    picSize.width = maxLen;
                    picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxLen;
                }
                picSize = CGSizePixelRound(picSize);
                picHeight = picSize.height;
            }
             */
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
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:time];
    text.font = SYSTEMFONT(kTimeFontSize);
    text.color = kGrayColor;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth * 0.5, HUGE)];
    container.maximumNumberOfRows = 1;
    
    _publichTimeTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _publichTimeHeight = _publichTimeTextLayout.textBoundingSize.height;
}

- (void)layoutComment {
    _comHeight = 0.f;
    NSArray *comments = _momentsModel.comments;
    NSArray *likes = _momentsModel.likes;
    
    _comTextLayouts = [NSMutableArray array];
    
    NSMutableString *tempStr = @"".mutableCopy;
    if (likes.count > 0) {
        
        for (ZXGMomentsLikeModel *model in likes) {
            [tempStr appendFormat:@", %@", model.memberName];
        }
        if ([tempStr hasPrefix:@", "]) {
            [tempStr deleteCharactersInRange:NSMakeRange(0, 2)];
        }
        NSMutableAttributedString *likeString = [[NSMutableAttributedString alloc] initWithString:tempStr];
        [likeString setFont:SYSTEMFONT(kComFontSize)];
        YYTextContainer *likeContain = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, HUGE) insets:UIEdgeInsetsMake(kMomentsCellPaddingCom, kMomentsCellPaddingComH, kMomentsCellPaddingCom, kMomentsCellPaddingComH)];
        YYTextLayout *likeTextLayout = [YYTextLayout layoutWithContainer:likeContain text:likeString];
        [_comTextLayouts addObject:likeTextLayout];
        _comHeight += likeTextLayout.textBoundingSize.height;
    }
    
    if (comments.count > 0) {
        
        for (ZXGMomentsCommentModel *model in comments) {
            NSMutableAttributedString *text = nil;
            // 标记名称文字
            if (model.replyMemberName && model.replyMemberName.length > 0) {
                
                NSString *comment = [NSString stringWithFormat:@"%@回复%@:%@", model.memberName, model.replyMemberName, model.content];
                text = [[NSMutableAttributedString alloc] initWithString:comment];
                [text setFont:SYSTEMFONT(kComFontSize)];
                NSRange range = [comment rangeOfString:model.memberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:range];
                [text setColor:kMomentsNameColor range:range];
                
                NSRange replyRange = [comment rangeOfString:model.replyMemberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:replyRange];
                [text setColor:kMomentsNameColor range:replyRange];
            }
            else {
                
                NSString *comment = [NSString stringWithFormat:@"%@:%@", model.memberName, model.content];
                text = [[NSMutableAttributedString alloc] initWithString:comment];
                [text setFont:SYSTEMFONT(kComFontSize)];
                NSRange range = [comment rangeOfString:model.memberName];
                [text setFont:BOLDSYSTEMFONT(kComFontSize) range:range];
                [text setColor:kMomentsNameColor range:range];
            }
                        
            YYTextContainer *contain = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, HUGE) insets:UIEdgeInsetsMake(kMomentsCellPaddingCom, kMomentsCellPaddingComH, kMomentsCellPaddingCom, kMomentsCellPaddingComH)];
            YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:contain text:text];
            [_comTextLayouts addObject:textLayout];
            _comHeight += textLayout.textBoundingSize.height;
        }
    }
    
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


