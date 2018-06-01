//
//  ViewController.m
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "ZXGViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRandomColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
}

- (void)clicked {
    [self.navigationController pushViewController:[ZXGViewController new] animated:YES];
}

@end
