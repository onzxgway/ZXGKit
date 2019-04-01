//
//  CollectionViewLayout.m
//  UICollectionView
//
//  Created by onzxgway on 2019/4/1.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout () {
    NSMutableArray *_layoutAttriAry;
    NSMutableArray *_originYAry;
    NSInteger _collectViewRowCount;
}

@end

@implementation CollectionViewLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        _layoutAttriAry = [NSMutableArray array];
        _originYAry = [NSMutableArray array];
        _collectViewRowCount = 3;
    }
    return self;
}

// 在布局更新期间， collection view都会首先调用该方法，允许布局对象对此次的更新做一些和布局相关的数据创建或计算操作。    默认情况下，该方法不会做任何操作，子类可以重载该方法。
- (void)prepareLayout {
    
    //准备数据 对每一个cell的布局进行初始化
    [_layoutAttriAry removeAllObjects];
    [_originYAry removeAllObjects];
    for (int i = 0; i < _collectViewRowCount; i++) {
        [_originYAry addObject:@(0)];
    }
    
    // row
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellCount; i++) {
        // 初始化每一个cell的布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *atributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_layoutAttriAry addObject:atributes];
    }
    
}

// 返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat hMargin = 10.f;
    CGFloat vMargin = 18.f;
    
    float cellSizeWidth = (self.collectionView.bounds.size.width - 2 * hMargin) / _collectViewRowCount;
    
    // 如果这个cell是一个图片内容，那么就返回图片高度
    float cellSizeHeight = 50 + arc4random_uniform(100); // 通过indexPath 算出cell相应高度
    
    float cellX = (cellSizeWidth + hMargin) * (indexPath.row%_collectViewRowCount);
    
    float cellY = [_originYAry[indexPath.row%3] floatValue];
    _originYAry[indexPath.row%_collectViewRowCount] = @(cellY + cellSizeHeight + vMargin);
    
    attributes.frame = CGRectMake(cellX, cellY, cellSizeWidth, cellSizeHeight);
    
    return attributes;
}

// 返回collectionView内容区的宽度和高度，子类必须重载该方法，返回值代表了所有内容的宽度和高度，而不仅仅是可见范围的，collectionView通过该信息配置它的滚动范围，默认返回 CGSizeZero。
- (CGSize)collectionViewContentSize {
    
    float maxHeight = [_originYAry[0] floatValue];
    for (int i = 1; i < _collectViewRowCount; i++) {
        if (maxHeight < [_originYAry[i] floatValue]) {
            maxHeight = [_originYAry[i] floatValue];
        }
    }
    
    CGSize size = CGSizeMake(self.collectionView.bounds.size.width, maxHeight);
    return size;
    
}

// 返回UICollectionViewLayoutAttributes 类型的数组，UICollectionViewLayoutAttributes 对象包含cell或view的布局信息。子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图。
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _layoutAttriAry;
}

@end
