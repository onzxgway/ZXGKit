//
//  ViewController.m
//  LearnYYKit
//
//  Created by 朱献国 on 10/04/2018.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"
#import "ZXGCommonKit.h"

#define kString @"《共产党宣言》全篇译文不足两万字，但陈望道花费了平时译书的五倍功夫。1920年4月底，陈望道完成了《共产党宣言》的翻译。他将译稿带到上海，交给陈独秀等人校对。\n 1920年8月，第一版《共产党宣言》在上海正式公开出版。初版时印了1000本，很快销售一空。到1926年5月，陈望道翻译的《共产党宣言》重印达17版之多。\n《共产党宣言》奠定共产党人坚定理想信念、坚守精神家园的理论基础\n陈望道翻译的《共产党宣言》，是中国共产党成立前后在中国传播最早、影响最大的一本马克思主义著作。它为中国共产党的创立和发展奠定了坚实的思想理论基础。"
#define kToolbarHeight (35 + 46)

@interface ViewController ()
@property (nonatomic, strong) YYTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self learnYYTextView];
}

- (void)learnYYTextView {
    
    if (_textView) return;
    _textView = [[YYTextView alloc] init];
    _textView.backgroundColor = [UIColor redColor];
    _textView.size = CGSizeMake(SCREEN_WIDTH, 128);
//    _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
//    _textView.contentInset = UIEdgeInsetsMake(64, 0, kToolbarHeight, 0);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = kToolbarHeight;
    _textView.showsVerticalScrollIndicator = YES;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:17];
//    _textView.textParser = [WBStatusComposeTextParser new];
//    _textView.delegate = self;
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

- (void)learnYYText {
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:kString];
    
    YYLabel *label = [YYLabel new];
//    label.attributedText = text;
    
//    label.width = self.view.width;
//    label.height = 260;
//    label.top = 64;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.backgroundColor = kOrangeColor;
    
    [self.view addSubview:label];
    
    label.displaysAsynchronously = YES;
    label.ignoreCommonProperties = YES;
    label.origin = CGPointMake(100, 100);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Create attributed string.
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:kString];
        
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(200, CGFLOAT_MAX);
        container.maximumNumberOfRows = 0;
        
        // Generate a text layout.
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 1. 只有当空间的Size改变的时候才能调用display
            // 2. 只有当Label有Size的时候调用排版就会调用Display方法  进行渲染
            label.size = layout.textBoundingSize;
            label.textLayout = layout;
            
        });
    });

}


@end
