//
//  ViewController.m
//  京东商品详情
//
//  Created by 朱献国 on 2018/11/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "JDDetailController.h"

@interface ViewController ()

@property(nonatomic, strong)UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - event response
- (void)btnAction:(UIButton *)btn {
    
    JDDetailController *productDetailViewCtrl = [[JDDetailController alloc] init];
    [self.navigationController pushViewController:productDetailViewCtrl animated:YES];
    
}

#pragma mark - getter方法
- (UIButton *)btn {
    
    if (!_btn) {
        
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100.f, 100.f, 200.f, 100.f)];
        _btn.backgroundColor = [UIColor lightGrayColor];
        
        [_btn setTitle:@"进入商品详情" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        
    }
    
    return _btn;
    
}

@end
