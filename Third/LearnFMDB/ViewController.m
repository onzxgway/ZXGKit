//
//  ViewController.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "ZXGPerson.h"
#import "ZXGUseage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ZXGUseage createDataBaseTable];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ZXGPerson *p = [[ZXGPerson alloc] init];
    p.currentAccount = @"1001";
    p.name = @"kobe";
    p.age = 38;
    p.homeAdress = @"LA";
    p.studyNo = nil;
    
    [ZXGUseage insertinto:p];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZXGUseage queryDataBaseTableWithAccountParams:nil withSuccessBlock:^(NSArray *dataArray) {
        ZXGPerson *p = [dataArray firstObject];
        NSLog(@"%@__%@", p.name, p.homeAdress);
    } withFaileBlock:^(NSString *errorStr) {
        NSLog(@"%@", errorStr);
    }];
}


@end
