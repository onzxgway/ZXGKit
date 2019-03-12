//
//  ZXGTableView.m
//  TableView原理
//
//  Created by 朱献国 on 2019/3/12.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTableView.h"
#import "CustomCellModel.h"

/**
 extension看起来很像一个匿名的category。
 1. extension一般用于声明私有方法，私有属性，私有成员变量。
 2. extension只存在于一个.h文件中，或者extension只能寄生于一个类的.m文件中。比如，viewController.m文件中通常寄生这么个东西，其实这就是一个extension.
 */
@interface ZXGTableView ()

@property (nonatomic, strong) NSMutableArray *cellInfoAry;

// key是indexPath.row， vaule就是cell
@property (nonatomic, strong) NSMutableDictionary *visibleCellDict;
@property (nonatomic, strong) NSMutableArray *reusePoolCellAry;

@end

@implementation ZXGTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _cellInfoAry = @[].mutableCopy;
        _visibleCellDict = [NSMutableDictionary dictionary];
        _reusePoolCellAry = [NSMutableArray array];
    }
    return self;
}

- (void)reloadData {
    
    [self handleData];
    
    [self setNeedsLayout]; // 不是同步的
    [self layoutIfNeeded]; // 设置同步执行
}

- (void)handleData {
    
    // 1.1 cell的数量  不做section的处理 section = 0，就一个section
    NSInteger allCellCount = [self.dataSource tableView:self numberOfRowsInSection:0];
    
    
    //1.2 cell的位置和高度
    CGFloat addupHeight = 0;
    for (NSInteger i = 0; i < allCellCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat cellHeigth =  [self.dataSource tableView:self heightForRowAtIndexPath:indexPath];
        
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
    CGFloat startY = (self.contentOffset.y < 0) ? 0 :self.contentOffset.y;
    CGFloat endY = ((self.contentOffset.y + self.frame.size.height) > self.contentSize.height) ? self.contentSize.height : (self.contentOffset.y + self.frame.size.height);
    
    // 2.2 添加相应的cell
    NSInteger startIndex = -1;
    NSInteger endIndex = 0;
    NSInteger index = 0;
    
    for (; index < _cellInfoAry.count; index++) {
        
        CustomCellModel *cellModel = _cellInfoAry[index];
        if (cellModel.y <= startY && cellModel.y + cellModel.heigth > startY) {
            startIndex = index;
            break;
        }
    }
    
    // 2.2.2 计算endIndex
    for (; index < _cellInfoAry.count; index++) {
        
        CustomCellModel *cellModel = _cellInfoAry[index];
        if (cellModel.y < endY && cellModel.y + cellModel.heigth >= endY) {
            endIndex = index;
            break;
        }
    }
    
    // 2.2.3 获取相应的cell  1种已经在界面上的， 2种没在界面的
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        // 如对应的index的row已经在界面上了
        CustomTableViewCell *cell =  _visibleCellDict[@(indexPath.row)];
//        cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell =  [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
            [self addSubview:cell];
        }
        
        // section = 0;
        [_visibleCellDict setObject:cell forKey:@(indexPath.row)];
        // _visibleCellDict[@(indexPath.row)] = cell;
        [_reusePoolCellAry removeObject:cell]; // 这个cell可能是从重用池里面拿过来的
        
        CustomCellModel *cellModel = _cellInfoAry[i];
        cell.frame = CGRectMake(0, cellModel.y, self.frame.size.width, cellModel.heigth);
    }
    
    // 2.3 移除多于cell（不在可视范围里面的cell），移到重用池里
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

// 重用池中获取cell
- (CustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString*)identifier {
    
    /* 判断是否已经在现有池里面，如果在，那么直接从现有池里面返回来
     这个逻辑 需要做一个 indexPath的成员变量
     CustomTableViewCell *cell = _visibleCellDict[@(indexPath.row)];
     */
    for(NSInteger i = 0; i < _reusePoolCellAry.count; i++) {
        CustomTableViewCell *cell = _reusePoolCellAry[i];
        if ([cell.identifier isEqualToString:identifier]) {
            return cell;
        }
    }
    return nil;
}


@end
