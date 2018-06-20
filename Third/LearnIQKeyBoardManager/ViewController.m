//
//  ViewController.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/14.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "TKeyBoardManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollVIEW;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@property (weak, nonatomic) IBOutlet UIButton *disabled;
@property (weak, nonatomic) IBOutlet UIButton *abled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.myScrollVIEW.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height * 2);
    [self.myScrollVIEW scrollsToTop];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    [self.disabled addTarget:self action:@selector(disabledEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.abled addTarget:self action:@selector(abledEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)disabledEvent {
    [[TKeyBoardManager sharedKeyBoardManager] setEnable:NO];
}

- (void)abledEvent {
    [[TKeyBoardManager sharedKeyBoardManager] setEnable:YES];
}

- (void)push {
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
