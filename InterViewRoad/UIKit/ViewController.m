//
//  ViewController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "UIViewLabelController.h"
#import "UIViewLayerController.h"
#import "ScrollViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textArr = @[@"1.要在 UIView 上定义一个 Label有 哪几种方式？", @"2.storyboard/xib，和纯代码构建 UI 相比，有什么优缺点？", @"3.Auto Layout 和 Frame 在 UI 布局和渲染上有什么区别？", @"4.UIView 和 CALayer 有什么区别？", @"5.请说明并比较以下关键词：Frame, Bounds, Center", @"6.请说明并比较以下方法：layoutIfNeeded, layoutSubviews, setNeedsLayout", @"7.请说明并比较以下关键词：Safe Area, SafeAreaLayoutGuide, SafeAreaInsets", @"8.UIScrollView及其子类"];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    UIView *view = [[UIView alloc] init];
    table.tableFooterView = view;
    [self.view addSubview:table];
    
}

#pragma mark - tableView delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _textArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"8pm"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"8pm"];
        cell.textLabel.text = _textArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UIViewLabelController *scrollViewCtrl = [[UIViewLabelController alloc] init];
        [self.navigationController pushViewController:scrollViewCtrl animated:YES];
        
    }
    else if (indexPath.row == 1) {
        
        UIViewLabelController *viewCtrl = [[UIViewLabelController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 2) {
        
        UIViewLabelController *viewCtrl = [[UIViewLabelController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 3) {
        
        UIViewLayerController *viewCtrl = [[UIViewLayerController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 4) {
        
        UIViewLayerController *viewCtrl = [[UIViewLayerController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 5) {
        
        UIViewLayerController *viewCtrl = [[UIViewLayerController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 6) {
        
        UIViewLayerController *viewCtrl = [[UIViewLayerController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (indexPath.row == 7) {
        
        ScrollViewController *viewCtrl = [[ScrollViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
}

@end
