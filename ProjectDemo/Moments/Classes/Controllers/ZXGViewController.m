//
//  ZXGViewController.m
//  Moments
//
//  Created by 朱献国 on 2018/5/13.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import "ZXGViewController.h"

#define kToolbarHeight (35 + 46)

@interface ZXGViewController ()<YYTextViewDelegate>
@property (nonatomic, strong) YYTextView *textView;
@end

@implementation ZXGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kRandomColor];
    [self learnYYTextView];
}

- (void)learnYYTextView {
    
    if (_textView) return;
    _textView = [[YYTextView alloc] init];
    _textView.backgroundColor = [UIColor redColor];
    _textView.size = CGSizeMake(SCREEN_WIDTH, 68);
    _textView.origin = CGPointMake(0, 138);
    _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
//    _textView.contentInset = UIEdgeInsetsMake(26, 0, 26, 0);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = kToolbarHeight;
    _textView.showsVerticalScrollIndicator = YES;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:17];
//    _textView.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    //    _textView.textParser = [WBStatusComposeTextParser new];
    _textView.delegate = self;
    _textView.inputAccessoryView = [[UIView alloc] init];
    
    //    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    //    modifier.font = [UIFont fontWithName:@"Heiti SC" size:17];
    //    modifier.paddingTop = 12;
    //    modifier.paddingBottom = 12;
    //    modifier.lineHeightMultiple = 1.5;
    //    _textView.linePositionModifier = modifier;
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:@"写评论..."];
    atr.color = UIColorHex(b4b4b4);
    atr.font = [UIFont systemFontOfSize:17];
    _textView.placeholderAttributedText = atr;
    
    [self.view addSubview:_textView];
}

- (void)textViewDidChange:(YYTextView *)textView {
    NSLog(@"__%@__", NSStringFromCGSize(textView.contentSize));
}

@end
