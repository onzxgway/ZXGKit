//
//  ApplicationController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ApplicationController.h"
#import "RedView.h"
#import "BannerView.h"
#import "BlueView.h"
#import "RedGesture.h"
#import "TableView.h"

@interface ApplicationController () <UITableViewDelegate, UITableViewDataSource>

@end

/**
 ScrollView上的触摸事件的分析
 
 */
@implementation ApplicationController

- (void)loadView {
    self.view = [RedView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ScrollView 事件处理（相对于 子View）
//    [self createScrollView];
    
    [self createTableView];
}

/**
 
 1. ScrollView 不能滚动的时候（x方向 或 y方向），其本身以及子控件的touch事件会被触发。
 
 2. ScrollView 可以滚动的时候（x方向 或 y方向），其本身以及子控件的touch事件不会被触发。
 
 原因： 当可以滚动的时候，ScrollView 本身以及子控件内部的 touch事件默认 会被 取消。
 
 需求： 1. 开启touch事件。
        解决方法：    一  sc.panGestureRecognizer.cancelsTouchesInView = NO;
                    二  sc.delaysContentTouches = NO;
                        sc.canCancelContentTouches = NO;
 */
- (void)createScrollView {
    
    BannerView *sc = [[BannerView alloc] initWithFrame:CGRectMake(30, 108, 320, 480)];
    sc.backgroundColor = [UIColor lightGrayColor];
    sc.showsHorizontalScrollIndicator = NO;
    sc.pagingEnabled = YES;
    sc.clipsToBounds = NO;
    sc.contentSize = CGSizeMake(0, 680);
    [self.view addSubview:sc];
    
    // 属性默认是YES,
//    sc.panGestureRecognizer.cancelsTouchesInView = NO;
    
    // 两个属性默认都是YES,
    sc.delaysContentTouches = NO;
    sc.canCancelContentTouches = NO;  //与上方的区别 如果设置为NO, 响应触摸事件，ScrollView的手势就不响应了。
    
    BlueView *bv = [BlueView new];
    bv.backgroundColor = [UIColor blueColor];
    [sc addSubview:bv];
    bv.frame = CGRectMake(0, 180, 320, 280);
    
}

- (void)createTableView {
    
    RedGesture *ges = [[RedGesture alloc] initWithTarget:self action:@selector(click)];
    ges.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:ges];
    
    TableView *tv = [[TableView alloc] initWithFrame:CGRectMake(20, 108, 320, 560) style:UITableViewStylePlain];
    tv.backgroundColor = [UIColor greenColor];
    [self.view addSubview:tv];
    tv.delegate = self;
    tv.dataSource = self;
    
}

- (void)click {
    NSLog(@"RedGesture click!");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
}

@end
