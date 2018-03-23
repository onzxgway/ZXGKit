//
//  ViewController.m
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "WBStatusController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _myBtn.target = self;
    _myBtn.action = @selector(weiboClicked);
    
}


- (void)weiboClicked {
    [self.navigationController pushViewController:[WBStatusController new] animated:YES];
}


@end
