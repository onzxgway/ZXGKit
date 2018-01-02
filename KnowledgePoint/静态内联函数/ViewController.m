//
//  ViewController.m
//  静态内联函数
//
//  Created by feizhu on 2017/10/26.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    setUserId(@88);
    [self demo];
}

- (void)demo {
    NSLog(@"%@", getUserId());
}


@end
