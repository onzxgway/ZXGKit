//
//  ViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/10.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "MJRefreshNormalHeader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJRefreshNormalHeader *com = [[MJRefreshNormalHeader alloc] init];
    [self.myScrollView insertSubview:com atIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
