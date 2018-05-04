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

- (instancetype)initWithMoments:(ZXGDynamicModel *)moments {
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
    text.color = RGB(84, 95, 141);
    text.font = BOLDSYSTEMFONT(kNameFontSize);
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kMomentsContentWidth, CGFLOAT_MAX)];
    container.maximumNumberOfRows = 1;
    container.truncationType = YYTextTruncationTypeEnd;
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
    
//    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
//    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellTextFontSize];
//    modifier.paddingTop = kWBCellPaddingText;
//    modifier.paddingBottom = kWBCellPaddingText;
    
    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.size = CGSizeMake(kMomentsContentWidth, HUGE);
//    container.linePositionModifier = modifier;
    
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
    text.color = RGB(84, 95, 141);
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

@end
