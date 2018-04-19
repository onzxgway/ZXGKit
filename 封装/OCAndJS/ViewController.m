//
//  ViewController.m
//  OCAndJS
//
//  Created by 朱献国 on 2018/4/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGWebViewController.h"
#import "ZXGOCCallJSViewController.h"
#import "ZXGCommonKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRandomColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"JSCallOC" style:UIBarButtonItemStyleDone target:self action:@selector(rightClicked)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OCCallJS" style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
}

- (void)rightClicked {
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"JSCallOC.html"];
    
    ZXGWebViewController *ctrl = [[ZXGWebViewController alloc] init];
    ZXGBaseWebViewModel *contentModel = [[ZXGBaseWebViewModel alloc] init];
    contentModel.pageTitle = @"小e头条";
    contentModel.type = ZXGWebPageDisplayTypeShare;
    contentModel.articleLinkStr = path;
    ctrl.contentModel = contentModel;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)leftClicked {
    
    ZXGOCCallJSViewController *ctrl = [[ZXGOCCallJSViewController alloc] init];
    ZXGBaseWebViewModel *contentModel = [[ZXGBaseWebViewModel alloc] init];
    contentModel.pageTitle = @"小e头条";
    contentModel.type = ZXGWebPageDisplayTypeShare;
    ctrl.contentModel = contentModel;
    [self.navigationController pushViewController:ctrl animated:YES];
}


@end
