//
//  ZXGItemOneController.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGItemOneController.h"
#import "ZXGOnePushController.h"

@interface ZXGItemOneController ()

@end

@implementation ZXGItemOneController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"One";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(pushClicked)];
    
}

#pragma mark - CreateViews

#pragma mark - Private
- (void)pushClicked {
    [self.navigationController pushViewController:[ZXGOnePushController new] animated:YES];
}

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
