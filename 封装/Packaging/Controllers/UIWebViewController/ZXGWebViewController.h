//
//  ZXGWebViewController.h
//  Packaging
//
//  Created by 朱献国 on 2018/4/18.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGWebViewModel.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface ZXGWebViewController : UIViewController 

/** model*/
@property (nonatomic, strong) ZXGWebViewModel *contentModel;

@end
