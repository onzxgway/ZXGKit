//
//  ViewController.m
//  Event
//
//  Created by 朱献国 on 2018/10/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "GrayView.h"
#import "YellowView.h"
#import "RedView.h"
#import "BlueView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
    
@property (nonatomic, strong) GrayView *grayView;
@property (nonatomic, strong) YellowView *yellowView;
@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) BlueView *blueView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
    
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
    
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
    
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
    
- (void)layoutSubView {
    // autoLayout
    [self.view addSubview:self.grayView];
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *grayTop = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:108.f];
    NSLayoutConstraint *grayCenterX = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *grayW = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.f constant:-88.f];
    NSLayoutConstraint *grayH = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0.f constant:188.f];
    [self.view addConstraints:@[grayTop, grayCenterX, grayW, grayH]];
    
    [self.grayView addSubview:self.redView];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
    NSLayoutConstraint *redLeft = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0.f];
    NSLayoutConstraint *redW = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-38.f];
    NSLayoutConstraint *redH = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeHeight multiplier:0.5f constant:-18.f];
    [self.grayView addConstraints:@[redTop, redLeft, redW, redH]];
    
    [self.grayView addSubview:self.blueView];
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueBottom = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueW = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
    NSLayoutConstraint *blueH = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
    [self.grayView addConstraints:@[blueBottom, blueLeft, blueW, blueH]];
    
    [self.view addSubview:self.yellowView];
    self.yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *yellowViewTop = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeBottom multiplier:1.f constant:188.f];
    NSLayoutConstraint *yellowViewCenterX = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *yellowW = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f];
    NSLayoutConstraint *yellowH = [NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
    [self.view addConstraints:@[yellowViewTop, yellowViewCenterX, yellowW, yellowH]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = [dic.allKeys firstObject];
    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    // 由字符串转为类型的时候  如果类型是自定义的 需要在类型字符串前边加上你的项目的名字！
    Class cla = NSClassFromString([dic.allValues firstObject]);
    [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
}
    
#pragma mark - lazy load

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
                        @{
                          @"UIResponder和响应链的组成" : @"ResponderController"
                          },
                         @{
                          @"Swift是面向对象还是函数式的编程语言？" : @"OOOrFunctionController"
                          },
                         @{
                          @"Open, Public, Internal, File-private, Private" : @"AuthorityController"
                          },
                         @{
                          @"在 Swift 中，怎样理解是 copy-on-write？" : @"CopyonwriteController"
                          },
                         @{
                          @"什么是属性观察（Property Observer）？" : @"PropertyObserverController"
                          },
                         @{
                          @"Swift 实战题" : @"ReallyController"
                          }
                        
                        ];
    }
    return _dataSource;
}

- (GrayView *)grayView {
    if (!_grayView) {
        _grayView = [[GrayView alloc] init];
    }
    return _grayView;
}

- (YellowView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[YellowView alloc] init];
    }
    return _yellowView;
}

- (RedView *)redView {
    if (!_redView) {
        _redView = [[RedView alloc] init];
    }
    return _redView;
}
    
- (BlueView *)blueView {
    if (!_blueView) {
        _blueView = [[BlueView alloc] init];
    }
    return _blueView;
}
    
@end
