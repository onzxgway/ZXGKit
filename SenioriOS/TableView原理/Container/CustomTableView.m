//
//  CustomTableView.m
//  TableView原理
//
//  Created by 朱献国 on 2019/3/13.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomCellModel.h"
#import "CustomTableViewCell.h"

/**
 单独存在于.h文件或者.m文件中的。 匿名的category。
 作用：    1.扩展类的私有的 方法，属性和成员变量。
 */
@interface CustomTableView ()

@property (nonatomic, strong) NSMutableArray<CustomCellModel *> *cellModels;
@property (nonatomic, strong) NSMutableArray<CustomTableViewCell *> *reusePool; // 重用池
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, CustomTableViewCell *> *visiablePool; // 显示池

@end

@implementation CustomTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _cellModels = [NSMutableArray array];
        _reusePool = @[].mutableCopy;
        _visiablePool = @{}.mutableCopy;
    }
    return self;
}

- (CustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    
    for (CustomTableViewCell *cell in _reusePool) {
        if ([cell.identifier isEqualToString:identifier]) {
            return cell;
        }
    }
    
    return nil;
}

- (void)reloadData {
    
    [self dataHandle];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)dataHandle {
    NSInteger numberOfRows = [self.dataSource tableView:self numberOfRowsInSection:0];
    
    CGFloat yy = 0;
    for (NSInteger i = 0; i < numberOfRows; ++i) {
        
        CustomCellModel *model = [[CustomCellModel alloc] init];
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [self.dataSource tableView:self heightForRowAtIndexPath:indexP];
        model.heigth = height;
        model.y = yy;
        [_cellModels addObject:model];
        
        yy += height;
    }
    
    self.contentSize = CGSizeMake(self.bounds.size.width, yy);
}

- (void)layoutSubviews {
    
    // 计算可视范围
    CGFloat startX = (self.contentOffset.y < 0) ? 0 : self.contentOffset.y;
    CGFloat endX = ((self.contentOffset.y + self.bounds.size.height) > self.contentSize.height) ? self.contentSize.height : (self.contentOffset.y + self.bounds.size.height);
    
    // 计算可视cell的索引
    NSInteger startIndex = -1;
    NSInteger endIndex = 0;
    NSInteger i = 0;
    for (; i < _cellModels.count; ++i) {
        CustomCellModel *model = [_cellModels objectAtIndex:i];
        if (model.y <= startX && model.y + model.heigth > startX) {
            startIndex = i;
            break;
        }
        
    }
    
    for (; i < _cellModels.count; ++i) {
        CustomCellModel *model = [_cellModels objectAtIndex:i];
        if (model.y < endX && model.y + model.heigth >= endX) {
            endIndex = i;
            break;
        }
        
    }
    
    for (i = startIndex; i < endIndex + 1; ++i) {
        
        CustomCellModel *model = [_cellModels objectAtIndex:i];
        
        // 添加对应的cell
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
        CustomTableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexP];
        [self addSubview:cell];
        
        [self.visiablePool setObject:cell forKey:@(i)];
        if ([self.reusePool containsObject:cell]) {
            [self.reusePool removeObject:cell];
        }
        
        cell.frame = CGRectMake(0, model.y, self.bounds.size.width, model.heigth);
        
    }
    
    NSArray *visibleCellkeyAry = [_visiablePool allKeys];
    for (i = 0; i < visibleCellkeyAry.count; ++i) {
        
        NSInteger index = [visibleCellkeyAry[i] integerValue];
        
        if (index < startIndex || index > endIndex) {
            
            [self.reusePool addObject:[self.visiablePool objectForKey:visibleCellkeyAry[i]]];
            [self.visiablePool removeObjectForKey:visibleCellkeyAry[i]];
            
        }
        
    }
    
}

@end
