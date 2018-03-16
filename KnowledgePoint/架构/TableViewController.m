//
//  ViewController.m
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TableViewController.h"
#import "DecoupleController.h"
#import "MVCController.h"
#import "MVPController.h"
#import "MVVMController.h"

@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myBtn;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.myBtn addTarget:self action:@selector(basic) forControlEvents:UIControlEventTouchUpInside];
}


- (void)basic {

//    DecoupleController *decoupleController = [[DecoupleController alloc] init];

//    MVCController *c = [[MVCController alloc] init];
//    MVPController *c = [[MVPController alloc] init];
    MVVMController *c = [[MVVMController alloc] init];
    [self presentViewController:c animated:YES completion:nil];
}


@end
