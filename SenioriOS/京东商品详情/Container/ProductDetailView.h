//
//  ProductDetailView.h
//  京东商品详情
//
//  Created by 朱献国 on 2018/11/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailView : UIView

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic) BOOL showTextLabel;

@end

NS_ASSUME_NONNULL_END
