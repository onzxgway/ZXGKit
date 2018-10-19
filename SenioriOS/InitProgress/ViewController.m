//
//  ViewController.m
//  InitProgress
//
//  Created by 朱献国 on 2018/10/17.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "TestBViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
}

- (void)clicked {
//    TestViewController *testViewController = [[TestViewController alloc] init];
    TestBViewController *testViewController = [[TestBViewController alloc] init];
    [self.navigationController pushViewController:testViewController animated:YES];
}

@end
