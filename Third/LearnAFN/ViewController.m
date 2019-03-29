//
//  ViewController.m
//  LearnAFN
//
//  Created by onzxgway on 2019/3/28.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "ViewController.h"
#import "BreakLoadImageController.h"
#import "TwoBreakLoadImageController.h"
#import "UploadFileController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    BreakLoadImageController *ctrl = [BreakLoadImageController new];
//    TwoBreakLoadImageController *ctrl = [TwoBreakLoadImageController new];
    UploadFileController *ctrl = [UploadFileController new];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
