//
//  MasonryViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()
@property (nonatomic, strong) NSMutableArray *masonryViewArray; // <#备注#>

@property (nonatomic, strong) NSMutableArray *masonryGreenViewArray; // <#备注#>
@end

@implementation MasonryViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test_masonry_horizontal_fixSpace];
    [self test_masonry_horizontal_fixItemWidth];
}

#pragma mark - CreateViews

#pragma mark - Private
- (void)test_masonry_horizontal_fixSpace {
    // 实现masonry水平固定间隔方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:22 leadSpacing:22 tailSpacing:22];
    
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.height.mas_equalTo(88);
    }];

}

- (void)test_masonry_horizontal_fixItemWidth {
    
    // 实现masonry水平固定控件宽度方法
    [self.masonryGreenViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:66 leadSpacing:8 tailSpacing:8];
    
    // 设置array的垂直方向的约束
    [self.masonryGreenViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(260);
        make.height.mas_equalTo(88);
    }];
}

#pragma mark - Public

#pragma mark - LazyLoad
- (NSMutableArray *)masonryViewArray {
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            [self.view addSubview:view];
            [_masonryViewArray addObject:view];
        }
    }
    return _masonryViewArray;
}

- (NSMutableArray *)masonryGreenViewArray {
    if (!_masonryGreenViewArray) {
        _masonryGreenViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor greenColor];
            [self.view addSubview:view];
            [_masonryGreenViewArray addObject:view];
        }
    }
    return _masonryGreenViewArray;
}

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
