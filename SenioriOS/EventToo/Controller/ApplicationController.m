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
 
 ScrollView 对touch事件的拦截（相对于 父View  和  子View 来说）
 
 */
@implementation ApplicationController

- (void)loadView {
    self.view = [RedView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createScrollView];
    
    
    [self createTableView];
}

- (void)createScrollView {
    
    BannerView *sc = [[BannerView alloc] initWithFrame:CGRectMake(30, 108, 320, 480)];
    sc.backgroundColor = [UIColor lightGrayColor];
    sc.showsHorizontalScrollIndicator = NO;
    sc.pagingEnabled = YES;
    sc.clipsToBounds = NO;
    sc.contentSize = CGSizeMake(0, 880);
    [self.view addSubview:sc];
    
    // 属性默认是YES,
//    sc.panGestureRecognizer.cancelsTouchesInView = NO;
    
    // 两个属性默认都是YES,
//    sc.delaysContentTouches = NO;
//    sc.canCancelContentTouches = NO;  //与上方的区别 如果设置为NO, 就响应SubView的触摸事件，ScrollView的手势就不响应了。
    
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
