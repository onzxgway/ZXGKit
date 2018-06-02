//
//  ViewController.m
//  string
//
//  Created by 朱献国 on 2018/5/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo];
}


- (void)demo {
    NSString *nameStr = [NSString stringWithFormat:@"%ld",(long)2011];
    NSString *errorStr = NSLocalizedStringFromTable(nameStr, @"UMErrorCode", nil);
    NSLog(@"errorStr:%@", errorStr);
}


@end
