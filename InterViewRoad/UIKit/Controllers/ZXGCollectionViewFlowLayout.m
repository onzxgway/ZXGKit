//
//  ZXGCollectionViewFlowLayout.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGCollectionViewFlowLayout.h"

@interface ZXGCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableDictionary *maxYdic;

@end

@implementation ZXGCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.colMagrin = 10;
        self.rowMagrin = 20;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.colCount = 2;
    }
    return self;
}

/**
 1. collectionViewContentSize。由于瀑布流导致的尺寸变化我们重写 contentSize。其中宽度一般情况我们是可以确定的，它取决于每个item的宽度，一行几个 item，以及 contentInset 值。高度我们可以先设定为 0，之后在 prepare() 里进行更新。
 2. prepare()。该方法发生在 UICollectionView 数据准备好，但界面还未布局之时。它用于计算各种布局信息，并设定每个 item 的相关属性。这里我们用横纵坐标轴分别进行计算每个 cell 的 xOffset 和 yOffset，然后将其转化为相应的 frame 并缓存起来。
 3. layoutAttributesForElements(in:)。prepare() 完成布局之后该方法被调用，它决定了哪些 item 在 CollectionView 给定的区域内可见。我们只要取交集（intersect）即可。
 4. layoutAttributesForItem(at:)。该方法需要我们针对每一个 item 设定 layoutAttribute。由于我们在 prepare() 中已经完成相应计算，此时只需返回对应 indexPath 的特定属性即可。
 */
- (void)prepareLayout {
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 子类必须重写该方法， and use it to return the width and height of the collection view’s content. These values represent the width and height of all the content, not just the content that is currently visible. The collection view uses this information to configure its own content size to facilitate scrolling.
- (CGSize)collectionViewContentSize {
    
    __block NSString *maxCol = @"0";
    // 找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYdic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    return CGSizeMake(0, [self.maxYdic[maxCol] floatValue]);
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    for(NSInteger i = 0; i < self.colCount; i++) {
        NSString *col = [NSString stringWithFormat:@"%zd", i];
        self.maxYdic[col] = @0;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    __block NSString * minCol = @"0";
    //找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYdic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    //    计算宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right -(self.colCount - 1) * self.colMagrin) / self.colCount;
    //    计算高度
    CGFloat hight = [self.degelate waterFlow:self heightForWidth:width atIndexPath:indexPath];
    
    //    CGFloat hight = 100 + arc4random_uniform(100);
    CGFloat x = self.sectionInset.left + (width + self.colMagrin) * [minCol intValue];
    CGFloat y = [self.maxYdic[minCol] floatValue] + self.rowMagrin;
    //    跟新最大的y值
    self.maxYdic[minCol] = @(y + hight);
    
    //    计算位置
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, width, hight);
    return attri;

}

- (NSMutableDictionary *)maxYdic {
    if (!_maxYdic) {
        _maxYdic = [[NSMutableDictionary alloc] init];
    }
    return _maxYdic;
}


@end
