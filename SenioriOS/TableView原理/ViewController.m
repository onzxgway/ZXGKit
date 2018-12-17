//
//  ViewController.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"
#import "SystemViewController.h"
#import "CustonViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)clicked:(UIButton *)btn {
    
    if (btn.tag == 1001) {
        CustonViewController *systemViewController = [[CustonViewController alloc] init];
        [self.navigationController pushViewController:systemViewController animated:YES];
    }
    else {
        SystemViewController *systemViewController = [[SystemViewController alloc] init];
        [self.navigationController pushViewController:systemViewController animated:YES];
    }
    
}


@end
