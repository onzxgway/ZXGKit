//
//  ViewController.m
//  Chain-Programming
//
//  Created by 朱献国 on 2018/11/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Chain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Chain programming
    UILabel.new._zbackgroundColor([UIColor lightGrayColor])._text(@"哈哈哈哈").moveTo(self.view);
}


@end
