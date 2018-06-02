//
//  ViewController.m
//  UICollectionView
//
//  Created by 朱献国 on 2018/5/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
}

- (void)clicked {
    [self.navigationController pushViewController:[[ZXGCollectionViewController alloc] init] animated:YES];
}


@end
