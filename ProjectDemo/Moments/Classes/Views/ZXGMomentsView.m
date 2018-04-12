//
//  ZXGMomentsView.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/4/12.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsView.h"
#import "ZXGMomentsCell.h"

@interface ZXGMomentsView ()

@end

@implementation ZXGMomentsView

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - overwrite
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXGMomentsCell *cell = [ZXGMomentsCell momentsCell:self];
    
    if (indexPath.row == _momentModels.count - 1) {
//        cell.bottomLine.hidden = NO;
    }
    else {
//        cell.bottomLine.hidden = YES;
    }
    
//    ZXGDynamicModel *model = _momentModels[indexPath.row];
//    model.indexPath = indexPath;
//    cell.dynamicCellModel = model;
    
    return cell;
}

#pragma mark - private
- (void)setupUI {
    //
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = kWhiteColor;
    
    //
    self.tableFooterView = [[UIView alloc] init];
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 0, 0, 0.5);
    self.tableHeaderView = tableHeaderView;
    
}
#pragma mark - public
#pragma mark - lazyLoad

@end
