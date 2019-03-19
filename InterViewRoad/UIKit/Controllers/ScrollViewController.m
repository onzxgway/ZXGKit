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
    
    self.textArr = @[@"1.请说明并比较以下关键词：contentView，contentInset，contentSize，contentOffset。", @"2. 请说明 UITableViewCell 的重用机制", @"3. 请说明并比较以下协议：UITableViewDelegate，UITableViewDataSource", @"4. 请说明并比较以下协议：UICollectionViewDelegate，UICollectionViewDataSource，UICollectionViewDelegateFlowLayout", @"5. UICollectionView 中的 Supplementary Views 和 Decoration Views 分别指什么？"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LearnScrollViewController *scrollViewCtrl = [[LearnScrollViewController alloc] init];
    [self.navigationController pushViewController:scrollViewCtrl animated:YES];
    
}

@end
