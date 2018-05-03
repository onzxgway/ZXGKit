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
    
    // 计算高度
    _rowHeight = 0;
    _rowHeight += kTopBtmMargin;
    _rowHeight += _nameHeight;
    _rowHeight += kVMargin;
    _rowHeight += _textHeight;

    _rowHeight += kTopBtmMargin;
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
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kNameWidth, CGFLOAT_MAX)];
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
    container.size = CGSizeMake(kNameWidth, HUGE);
//    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    
    _textHeight = _textLayout.textBoundingSize.height;
}

@end
