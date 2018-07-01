//
//  RootViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/15.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) UILabel *titleLab; // <#备注#>
@end

@implementation RootViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    
//    [self.view addSubview:self.titleLab];
//
//
//    CGFloat margin = 144;
//    NSLayoutConstraint *x = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18];
//
//    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
//
//    NSLayoutConstraint *maxW = [NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
//
//    [self.view addConstraints:@[x, y, maxW]];
    
    
    // 数组
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < 10000; ++i) {
        [arr addObject:@(i)];
    }
    
    // 集合
    NSMutableSet *set = [NSMutableSet set];
    for (int i = 0; i < 10000; ++i) {
        [set addObject:@(i)];
    }
    
    
    CFTimeInterval startTime = CACurrentMediaTime();
    NSLog(@"%@", [NSString stringWithFormat:@"****** %@ started ******", NSStringFromSelector(_cmd)]);
    
    for (NSNumber *num in arr) {
        
    }
    
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    NSLog(@"%@", [NSString stringWithFormat:@"****** %@ ended: %g seconds ******", NSStringFromSelector(_cmd),elapsedTime]);
    
    for (int i = 0; i < 10000; ++i) {
        [arr objectAtIndex:i];
    }
    
    
    for (NSNumber *num in set) { }
    
}

#pragma mark - CreateViews

#pragma mark - Private
- (void)push {

}

- (void)tapEvent {
   
}
#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16.f];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.text = @"春暖花开";
        _titleLab.numberOfLines = 0;
        _titleLab.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLab.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [_titleLab addGestureRecognizer:tap];
        _titleLab.userInteractionEnabled = YES;
    }
    return _titleLab;
}


@end
