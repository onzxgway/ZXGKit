//
//  CustomTableView.m
//  TableView原理
//
//  Created by 朱献国 on 2019/3/13.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomCellModel.h"

/**
 单独存在于.h文件或者.m文件中的。 匿名的category。
 作用：    1.扩展类的私有的 方法，属性和成员变量。
          2.
 */
@interface CustomTableView ()

@property (nonatomic, strong) NSMutableArray<CustomCellModel *> *cellModels;

@end

@implementation CustomTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellModels = [NSMutableArray array];
    }
    return self;
}

- (void)reloadData {
    
    [self dataHandle];
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
    
}

@end
