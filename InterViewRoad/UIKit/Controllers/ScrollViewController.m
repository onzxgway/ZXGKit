//
//  ScrollViewController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ScrollViewController.h"
#import "LearnScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textArr = @[@"1.请说明并比较以下关键词：contentView，contentInset，contentSize，contentOffset。", @"2.storyboard/xib，和纯代码构建 UI 相比，有什么优缺点？", @"3.Auto Layout 和 Frame 在 UI 布局和渲染上有什么区别？", @"4.UIView 和 CALayer 有什么区别？", @"5.请说明并比较以下关键词：Frame, Bounds, Center", @"6.请说明并比较以下方法：layoutIfNeeded, layoutSubviews, setNeedsLayout", @"7.请说明并比较以下关键词：Safe Area, SafeAreaLayoutGuide, SafeAreaInsets", @"UIScrollView及其子类"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LearnScrollViewController *scrollViewCtrl = [[LearnScrollViewController alloc] init];
    [self.navigationController pushViewController:scrollViewCtrl animated:YES];
    
}

@end
