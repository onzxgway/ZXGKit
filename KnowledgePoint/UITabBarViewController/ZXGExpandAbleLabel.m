//
//  ZXGExpandAbleLabel.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGExpandAbleLabel.h"
#import <CoreText/CoreText.h>

#define kExpandAbleLabelW (self.bounds.size.width)
#define kExpandAbleLabelH (self.bounds.size.height)
static NSUInteger const kIgnoreLength = 5;

@interface ZXGExpandAbleLabel () {
    UIButton *_expandBtn;    // 展开\折叠Button
}
@property (nonatomic, strong) NSArray<NSString *> *textArr;
//@property (nonatomic, copy  ) NSString *originalStr;
@end

@implementation ZXGExpandAbleLabel

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.foldLines = 2;
        self.numberOfLines = 0;
        self.expandBtn.titleLabel.font = self.font;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self createViews];
}

#pragma mark - createViews
- (void)createViews {
    if (self.text && self.text.length > 0) {
        
        _textArr = [self getSeparatedLinesFromLabel:self];
//        NSLog(@"+++%zd++", _textArr.count);
        if (_textArr && _textArr.count > 2 && !self.expandBtn.isSelected) {
            
            if (_textArr.count != _foldLines - 1) {
                NSMutableString *originalStr = [NSMutableString stringWithFormat:@"%@", _textArr[_foldLines - 2]];
                if (originalStr && originalStr.length > kIgnoreLength) {
                    [originalStr deleteCharactersInRange:NSMakeRange(originalStr.length - kIgnoreLength, kIgnoreLength)];
                    [originalStr appendString:@"..."];
                    NSString *resStr = @"";
                    for (NSUInteger i = 0; i < _foldLines - 2; ++i) {
                        resStr = [NSString stringWithFormat:@"%@%@", resStr, _textArr[i]];
                    }
                    self.text = [NSString stringWithFormat:@"%@%@", resStr, originalStr];
//                    NSLog(@"__%@__", self.text);
                }
            }
            
            CGRect contentStrRect = [self rectWithText:self.text];
            CGFloat y = (kExpandAbleLabelH - CGRectGetHeight(contentStrRect)) * 0.5 + CGRectGetHeight(contentStrRect) - self.font.pointSize;
            self.expandBtn.frame = CGRectMake(CGRectGetWidth(contentStrRect) - 36, y, 36, self.font.pointSize);
            [self bringSubviewToFront:self.expandBtn];
//            NSLog(@"__%@__%@__%lf__", NSStringFromCGRect(self.expandBtn.frame), NSStringFromCGRect(self.frame), y);
            
            // expandBtn坐标转换  -> 与self同一个坐标系
            CGRect expandBtnFrame = [self convertRect:self.expandBtn.frame toView:self.superview];
            CGRect interRect = CGRectIntersection(expandBtnFrame, self.frame);
            if (CGRectIsEmpty(interRect) || !CGRectEqualToRect(interRect, expandBtnFrame)) {
                self.expandBtn.hidden = YES;
            }
            else {
                self.expandBtn.hidden = NO;
            }
            
        }
        else {
            self.expandBtn.hidden = YES;
        }
    }
    
}


#pragma mark - private
- (CGRect)rectWithText:(NSString *)text {
    NSDictionary *attributes = @{NSFontAttributeName:self.font};
    return [text boundingRectWithSize:CGSizeMake(kExpandAbleLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
}

- (NSArray<NSString *> *)getSeparatedLinesFromLabel:(UILabel *)label {
    
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = label.frame;
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
}

#pragma mark - event
- (void)expandBtnClicked:(UIButton *)btn {
    NSLog(@"+++expandBtnClicked++");
    btn.selected = !btn.isSelected;
    
    self.text = @"2018年俄罗斯世界杯是国际足联世界杯足球赛举办的第21届赛事。比赛于2018年6月14日至7月15日在俄罗斯举行，这是世界杯首次在俄罗斯境内举行，亦是世界杯首次在东欧国家举行";
    [self setNeedsDisplay];
}

#pragma mark - setter
- (void)setFoldLines:(NSUInteger)foldLines {
    _foldLines = MAX(foldLines, 2) + 1;
}

- (void)setText:(NSString *)text {
    [super setText:text];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.expandBtn.titleLabel.font = font;
}

#pragma mark - lazyLoad
- (UIButton *)expandBtn {
    if (!_expandBtn) {
        [self addSubview:_expandBtn = [UIButton buttonWithType:UIButtonTypeCustom]];
        [_expandBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_expandBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_expandBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _expandBtn.hidden = YES;
        [_expandBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_expandBtn addTarget:self action:@selector(expandBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

@end
