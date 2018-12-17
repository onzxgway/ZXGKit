//
//  CustonScrollView.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomCellModel.h"
#import "CustomTableViewCell.h"

@implementation CustomTableView {
    
    NSMutableArray *_cellInfoAry;
//     key是indexPath.row， vaule就是cell
    NSMutableDictionary *_visibleCellDict;
    NSMutableArray *_reusePoolCellAry;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        _cellInfoAry = [NSMutableArray array];
        _visibleCellDict = [NSMutableDictionary dictionary];
        _reusePoolCellAry = [NSMutableArray array];
    }
    return self;
}

- (void)reloadData {
    
    [self dataHandle];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)dataHandle {
    
    //1.1 cell的数量  不做section的处理 section = 0，就一个section
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSInteger cellCount = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];
    
    //1.2 cell的位置和高度
    CGFloat addupHeight = 0;
    for (NSInteger i = 0; i < cellCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat cellHeigth = [self.dataSource tableView:self heightForRowAtIndexPath:indexPath];
        
        CustomCellModel *eocCellModel = [CustomCellModel new];
        eocCellModel.y = addupHeight;
        eocCellModel.heigth = cellHeigth;
        addupHeight += cellHeigth;
        
        [_cellInfoAry addObject:eocCellModel];
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, addupHeight)];
}

- (void)layoutSubviews {
    
    // 2.1 计算可视范围
    CGFloat startY = (self.contentOffset.y < 0) ? 0 : self.contentOffset.y;
    CGFloat endY = ((self.contentOffset.y + self.frame.size.height) > self.contentSize.height) ? self.contentSize.height : (self.contentOffset.y + self.frame.size.height);
    
    // 2.2 添加相应的cell
    NSInteger startIndex = -1;
    NSInteger endIndex = 0;
    
    CustomCellModel *startCellM = [CustomCellModel new];
    startCellM.y = startY;
    startIndex = [self binarySerchOC:_cellInfoAry target:startCellM];
    
    CustomCellModel *endCellM = [CustomCellModel new];
    endCellM.y = endY;
    endIndex = [self binarySerchOC:_cellInfoAry target:endCellM];
    
    // 2.2.3 获取相应的cell  1种已经在界面上的， 2种没在界面的
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        // 如对应的index的row已经在界面上了
        CustomTableViewCell *cell = _visibleCellDict[@(indexPath.row)];
        if (!cell) {
            cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
            [self addSubview:cell];
        }
        
        // section = 0
        [_visibleCellDict setObject:cell forKey:@(indexPath.row)];
        [_reusePoolCellAry removeObject:cell]; // 这个cell可能是从重用池里面拿过来的
        
        CustomCellModel *cellModel = _cellInfoAry[i];
        cell.frame = CGRectMake(0, cellModel.y, self.frame.size.width, cellModel.heigth);
    }
    
    // 2.3 移除多余cell（不在可视范围里面的cell），移到重用池里
    // 2.3 _visibleCellDict 这个里面的数据进行处理（不在界面上的）
    NSArray *visibleCellkeyAry = [_visibleCellDict allKeys];
    
    for (NSInteger i = 0; i < visibleCellkeyAry.count; i++) {
        
        NSInteger index = [visibleCellkeyAry[i] integerValue];
        
        if (index < startIndex || index > endIndex) {
            // 移除
            [_reusePoolCellAry addObject:_visibleCellDict[visibleCellkeyAry[i]]];
            [_visibleCellDict removeObjectForKey:visibleCellkeyAry[i]];
        }
    }
    
}

- (NSInteger)binarySerchOC:(NSArray *)dataAry target:(CustomCellModel *)targetModel {
    
    NSInteger min = 0;
    NSInteger max = dataAry.count - 1;
    NSInteger mid;
    while (min < max) {
        mid = min + (max - min)/2;
        // 条件判断
        CustomCellModel *midModel = dataAry[mid];
        if (midModel.y < targetModel.y && midModel.y + midModel.heigth > targetModel.y) {
            return mid;
        }
        else if(targetModel.y < midModel.y){
            max = mid;// 在左边
            if (max - min == 1) {
                return min;
            }
        }
        else {
            min = mid;// 在右边
            if (max - min == 1) {
                return max;
            }
        }
    }
    return -1;
    
}

@end
