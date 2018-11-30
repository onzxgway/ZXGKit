
//
//  ProductDetailView.m
//  京东商品详情
//
//  Created by 朱献国 on 2018/11/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ProductDetailView.h"

@interface ProductDetailView ()

@end

@implementation ProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        //        CGFloat bottomInset = self.isIphoneX?34.f:0.f;
        //        _webView.scrollView.contentInset = UIEdgeInsetsMake(0.f, 0.f, bottomInset, 0.f);
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
        [self addSubview:_webView];
        
    }
    return self;
}

- (void)setShowTextLabel:(BOOL)showTextLabel {
    _showTextLabel = showTextLabel;
    
    if (_showTextLabel) {  // 显示下拉回到商品主页／释放回到商品主页 文字
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 30.f, self.frame.size.width, 44.f)];
        _textLabel.text = @"下拉回到商品主页";
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor whiteColor];
        [_webView insertSubview:_textLabel atIndex:0];
    }
}

@end
