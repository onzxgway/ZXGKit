//
//  RootViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/15.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
}

#pragma mark - CreateViews

#pragma mark - Private
- (void)push {
//    [self.navigationController pushViewController:[[ViewController alloc] initWithNibName:<#(nullable NSString *)#> bundle:nil] animated:YES];
}

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
