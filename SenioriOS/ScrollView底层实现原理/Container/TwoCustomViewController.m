
//
//  TwoCustomViewController.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TwoCustomViewController.h"
#import "ScrollViewThree.h"
#import "ScrollViewTwo.h"
#import "ScrollViewOne.h"

@interface TwoCustomViewController ()

@end

@implementation TwoCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ScrollViewOne *scrollViewOne = [[ScrollViewOne alloc] initWithFrame:CGRectMake(0.f, 100.f, self.view.frame.size.width, 300.f)];
    scrollViewOne.contentSize = CGSizeMake(self.view.frame.size.width * 2, 300.f);
    scrollViewOne.backgroundColor = [UIColor redColor];
    
    ScrollViewTwo *scrollViewTwo = [[ScrollViewTwo alloc] initWithFrame:scrollViewOne.bounds];
    scrollViewTwo.contentSize = CGSizeMake(self.view.frame.size.width * 2, 300.f);
    scrollViewTwo.backgroundColor = [UIColor blueColor];

    ScrollViewThree *scrollViewThree = [[ScrollViewThree alloc] initWithFrame:scrollViewTwo.bounds];
    scrollViewThree.contentSize = CGSizeMake(self.view.frame.size.width * 2, 300.f);
    scrollViewThree.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:scrollViewOne];
    [scrollViewOne addSubview:scrollViewTwo];
    [scrollViewTwo addSubview:scrollViewThree];
    
}


@end
