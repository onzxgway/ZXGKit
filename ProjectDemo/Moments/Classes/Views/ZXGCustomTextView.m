//
//  ZXGCustomTextView.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "ZXGCustomTextView.h"

#define NotificationCenter [NSNotificationCenter defaultCenter]

@implementation ZXGTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self initilize];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ?: [UIColor grayColor];
    
    // 画文字
    CGFloat x = _placePoint.x;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = _placePoint.y;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [_placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}

//初始化
- (void)initilize {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    // 通知
    // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
    [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    self.placePoint = CGPointMake(5, 0);
}

/**
 * 监听文字改变
 */
- (void)textDidChange {
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setPlacePoint:(CGPoint)placePoint {
    _placePoint = placePoint;
    [self setNeedsDisplay];
}


- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

@end



@interface ZXGCustomTextView() <UITextViewDelegate>
@property (nonatomic, strong) ZXGTextView *textView;
@end

@implementation ZXGCustomTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.width = self.frame.size.width - 2 * _h_margin;
}

//初始化
- (void)initilize {
    
    self.h_margin  = 0;
    self.v_margin = 10;
    
    self.initLine = 1;
    self.maxLine = INT_MAX;
    
    self.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:self.textView];
    
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = UIColorHex(cecece).CGColor;

}

- (void)textViewDidChange:(UITextView *)textView {
    
    //内容高度
    CGFloat contentSizeH = self.textView.contentSize.height;
    
    //最大高度
    CGFloat maxHeight = ceil(_font.lineHeight * _maxLine);
    
    //初始高度
    CGFloat initiTextViewHeight = ceilf(_initLine * _font.lineHeight);
    if (contentSizeH <= maxHeight) {
        
        if (contentSizeH <= initiTextViewHeight) {
            self.textView.height = initiTextViewHeight;
        }
        else {
            self.textView.height = contentSizeH;
        }
        
    }
    else {
        self.textView.height = maxHeight;
    }
    
    self.height = self.textView.height + 2 * _v_margin;
    
    if (self.textHeightChangeBlock) {
        self.textHeightChangeBlock(self.height);
    }
    
    [textView scrollRangeToVisible:NSMakeRange(textView.selectedRange.location, 1)];
}

#pragma mark - setter
- (void)setMaxLine:(NSInteger)maxLine {
    _maxLine = maxLine;
}

- (void)setH_margin:(CGFloat)h_margin {
    _h_margin = h_margin;
    [self updateTextViewFrame];
}

- (void)setV_margin:(CGFloat)v_margin {
    _v_margin = v_margin;
    [self updateTextViewFrame];
}

- (void)setInitLine:(NSInteger)initLine {
    _initLine = initLine;
    [self updateTextViewFrame];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textView.font = font;
    [self updateTextViewFrame];
}


-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
}

- (void)setPlacePoint:(CGPoint)placePoint {
    _placePoint = placePoint;
    self.textView.placePoint = placePoint;
}

- (void)updateTextViewFrame {
    self.textView.frame =  CGRectMake(_h_margin, _v_margin, self.frame.size.width - 2 * _h_margin, ceilf(_initLine * _font.lineHeight));
    self.height = _v_margin * 2 + ceilf(_initLine * _font.lineHeight);
}


#pragma mark - lazy load
- (ZXGTextView *)textView {
    if (!_textView) {
        _textView = [[ZXGTextView alloc] initWithFrame:CGRectMake(_h_margin, _v_margin, self.frame.size.width - 2 * _h_margin,  _initLine * _font.lineHeight)];
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.delegate = self;
        _textView.placeholder = @"请输入";
    }
    return _textView;
}

@end
