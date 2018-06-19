//
//  ViewController.m
//  UIWindow
//
//  Created by feizhu on 2018/3/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *alertBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clicked" style:UIBarButtonItemStylePlain target:self action:@selector(Clicked)];

    //
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    self.btn.frame = CGRectMake(50, 150, 60, 20);
    [self.btn setTitle:@"clicked" forState:UIControlStateNormal];

    //
    self.alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertBtn addTarget:self action:@selector(alertClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.alertBtn];
    self.alertBtn.frame = CGRectMake(50, 250, 60, 20);
    [self.alertBtn setTitle:@"alert" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self windonLevel];
}

- (void)Clicked {
    [self.navigationController pushViewController:[[BViewController alloc] init] animated:YES];
}

- (void)alertClick {
    
    UIAlertController *ctrl = [UIAlertController alertControllerWithTitle:@"window" message:@"Hello world!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", [UIApplication sharedApplication].keyWindow);
    }];
    
    [ctrl addAction:cancel];
    
    [self presentViewController:ctrl animated:YES completion:nil];
}

/**
 iOS系统对UIWindow的使用
 */
- (void)clicked {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"确定举报该条动态？"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, alertControllerStr.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(0, alertControllerStr.length)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];

    [alertController addAction:cancel];
    [alertController addAction:sure];

    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)windonLevel {
    NSLog(@"__%f__%f__%f__", UIWindowLevelNormal, UIWindowLevelStatusBar, UIWindowLevelAlert);
}

@end
