//
//  ViewController.m
//  获取view所在的控制器
//
//  Created by 朱献国 on 10/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGView.h"

@interface ViewController ()
@property (nonatomic, strong) ZXGView *subView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.subView];
}

- (IBAction)weiboClicked:(id)sender {
}
- (IBAction)weiboClicked:(id)sender {
}

#pragma mark - lazy load
- (ZXGView *)subView {
    if (!_subView) {
        _subView = [[ZXGView alloc] initWithFrame:CGRectMake(50, 50, 220, 220)];
    }
    return _subView;
}


@end
