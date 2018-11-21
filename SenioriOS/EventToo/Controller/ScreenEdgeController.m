//
//  ScreenEdgeController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ScreenEdgeController.h"

@interface ScreenEdgeController ()

@end

@implementation ScreenEdgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
    ges.edges = UIRectEdgeRight;
    
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor greenColor];
    [self.view addSubview:v];
    [v addGestureRecognizer:ges];
    v.frame = CGRectMake(30, 108, 320, 88);
    
}

- (void)pan {
    NSLog(@"pan");
}

@end
