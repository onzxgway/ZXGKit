//
//  SystemScrollViewController.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "SystemScrollViewController.h"

@interface SystemScrollViewController () <UIGestureRecognizerDelegate, UIScrollViewDelegate> {
    
    UIScrollView *scrollViewOne;
    
}

@end

@implementation SystemScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self createMultiScrollView];
    [self createOneScrollView];
}

/**
 
 系统UIScrollView
 
 父子都是UIScrollView的时候:
  子UIScrollView可以滑动的时候，优先响应。此时父UIScrollView的手势不响应。 子UIScrollView到尽头滑动不了的时候，手势不响应。此时父UIScrollView的手势响应，可以继续滑动。
  同一时刻，只能有一个 拖拽手势响应。
 */
- (void)createMultiScrollView {
    
    UIScrollView *scrollViewOne = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 100.f, self.view.frame.size.width, 300.f)];
    scrollViewOne.backgroundColor = [UIColor redColor];
    scrollViewOne.contentSize = CGSizeMake(self.view.frame.size.width, 300.f * 2);
    
    UIScrollView *scrollViewTwo = [[UIScrollView alloc] initWithFrame:scrollViewOne.bounds];
    scrollViewTwo.contentSize = CGSizeMake(self.view.frame.size.width * 2, 300.f); // 600.f
    scrollViewTwo.backgroundColor = [UIColor lightGrayColor];
    
//    UIScrollView *scrollViewThree = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 300.f)];
//    scrollViewThree.contentSize = CGSizeMake(self.view.frame.size.width * 2, 300.f);
//    scrollViewThree.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:scrollViewOne];
    [scrollViewOne addSubview:scrollViewTwo];
//    [scrollViewTwo addSubview:scrollViewThree];
    
}

// contentInset 作用：扩展内容区域
//              原理：修改bounds
// scrollView 及其子类 遇到 导航控制器，会自动 top 间距。

- (void)createOneScrollView {
    
    scrollViewOne = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
    scrollViewOne.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        scrollViewOne.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
       #pragma clang diagnostic push
       #pragma clang diagnostic ignored"-Wdeprecated-declarations"
       self.automaticallyAdjustsScrollViewInsets = NO;
       #pragma clang diagnostic pop
    }
    scrollViewOne.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    scrollViewOne.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollViewOne];
    
//    ScrollView.contentInset实质就是修改scrollView的bounds
    scrollViewOne.contentInset = UIEdgeInsetsMake(88.f, 0.f, 0.f, 0.f);
    scrollViewOne.contentOffset = CGPointMake(0.f, -88.f);

    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = [UIColor greenColor];
    imgView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 3400.f);
    [scrollViewOne addSubview:imgView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // ScrollView实质就是修改它的bounds来进行view的滑动，可以在代理方法里打印ScrollView的bounds值来看
    NSLog(@"scrollView bounds %@", NSStringFromCGRect(scrollView.bounds));
    NSLog(@"scrollView contentInset %@", NSStringFromUIEdgeInsets(scrollView.contentInset));
    if (@available(iOS 11.0, *)) {
        NSLog(@"scrollView safeAreaInsets %@", NSStringFromUIEdgeInsets(scrollView.safeAreaInsets));
        NSLog(@"scrollVIew adjustInsets %@", NSStringFromUIEdgeInsets(scrollView.adjustedContentInset));
    }
    
}



@end
