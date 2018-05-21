//
//  ViewController.m
//  ZXGCustomView
//
//  Created by 朱献国 on 2018/5/19.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self show];
}

- (void)show {
    CGFloat margin = 20;
    CGFloat buttonWidth = (CGRectGetWidth(self.view.frame) - 20 * 3) * 0.5;
    CGFloat buttonHeight = buttonWidth;
    
    [self addButton: [self generateButtonWithStyle:ZXGLayoutButtonTypeImageTopTitleBottom]
          withFrame:CGRectMake(margin, 64 + margin, buttonWidth, buttonHeight)];
    
    [self addButton: [self generateButtonWithStyle:ZXGLayoutButtonTypeImageBottomTitleTop]
          withFrame:CGRectMake(margin + buttonWidth + margin, 64 + margin, buttonWidth, buttonHeight)];
    
    [self addButton: [self generateButtonWithStyle:ZXGLayoutButtonTypeImageLeftTitleRight]
          withFrame:CGRectMake(margin, 64 + margin + buttonHeight + margin, buttonWidth, buttonHeight)];
    
    [self addButton: [self generateButtonWithStyle:ZXGLayoutButtonTypeImageRightTitleLeft]
          withFrame:CGRectMake(margin + buttonWidth + margin, 64 + margin + buttonHeight + margin, buttonWidth, buttonHeight)];
}

- (void)addButton:(ZXGLayoutButton *)button withFrame:(CGRect)frame {
    button.frame = frame;
    [self.view addSubview:button];
}

- (ZXGLayoutButton *)generateButtonWithStyle:(ZXGLayoutButtonType)style {
    
    ZXGLayoutButton *button = [ZXGLayoutButton buttonWithType:UIButtonTypeCustom];
    [button setImage:GET_IMAGE(@"Monkey") forState:UIControlStateNormal];
    [button setTitle:@"BigMonkey" forState:UIControlStateNormal];
    [button setTitleColor:kLightGrayColor forState:UIControlStateNormal];
    button.layoutType = style;
    
    button.layer.borderWidth = ONE_PIXEL;
    button.layer.borderColor = kMagentaColor.CGColor;
    
    return button;
}

@end
