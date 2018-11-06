//
//  ButtonController.m
//  Event
//
//  Created by 朱献国 on 2018/11/6.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ButtonController.h"
#import "PracticeButton.h"

@interface ButtonController ()

@end

@implementation ButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    PracticeButton *customBtn = [PracticeButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
    customBtn.backgroundColor = [UIColor redColor];
    [customBtn setTitle:@"面朝大海" forState:UIControlStateHighlighted];
    /**
     按钮的时间的种类：
     UIControlEventTouchUpInside等等，是通过内部的touch事件来区分的。
     */
    [customBtn addTarget:self action:@selector(btnAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [customBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:customBtn];
}

- (void)btnAction:(PracticeButton *)btn withEvent:(UIEvent *)event {
    NSLog(@"面朝大海");
}

@end
