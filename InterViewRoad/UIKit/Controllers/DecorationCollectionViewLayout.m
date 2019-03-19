//
//  DecorationCollectionViewLayout.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "DecorationCollectionViewLayout.h"
#import "DecorationReusableView.h"
#import "ArmbandDecorationReusableView.h"


@implementation DecorationCollectionViewLayoutAttributes

/**
 //所定义属性的类型需要遵从 NSCopying 协议
 override func copy(with zone: NSZone? = nil) -> Any {
 let copy = super.copy(with: zone) as! SectionCardDecorationCollectionViewLayoutAttributes
 copy.backgroundColor = self.backgroundColor
 return copy
 }
 
 //所定义属性的类型还要实现相等判断方法（isEqual）
 override func isEqual(_ object: Any?) -> Bool {
 guard let rhs = object as? SectionCardDecorationCollectionViewLayoutAttributes else {
 return false
 }
 
 if !self.backgroundColor.isEqual(rhs.backgroundColor) {
 return false
 }
 return super.isEqual(object)
 }
 */

@end

@implementation ArmbandDecorationCollectionViewLayoutAttributes

/**
 //所定义属性的类型需要遵从 NSCopying 协议
 override func copy(with zone: NSZone? = nil) -> Any {
 let copy = super.copy(with: zone) as! SectionCardArmbandDecorationCollectionViewLayoutAttributes
 copy.imageName = self.imageName
 return copy
 }
 
 //所定义属性的类型还要实现相等判断方法（isEqual）
 override func isEqual(_ object: Any?) -> Bool {
 guard let rhs = object as? SectionCardArmbandDecorationCollectionViewLayoutAttributes else {
 return false
 }
 
 if self.imageName != rhs.imageName {
 return false
 }
 return super.isEqual(object)
 }
 
 */

@end

@interface DecorationCollectionViewLayout ()

// 保存所有自定义的section背景的布局属性
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UICollectionViewLayoutAttributes *> *cardDecorationViewAttrs;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UICollectionViewLayoutAttributes *> *armbandDecorationViewAttrs;

@end


@implementation DecorationCollectionViewLayout

/**
 
 1.初始化时进行装饰视图的注册操作（对应 setup 方法）
 2.override prepareLayout 方法，计算生成装饰视图的布局属性
 3.override layoutAttributesForElements 方法，返回可视范围下装饰视图的布局属性
 
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        _cardDecorationViewAttrs = [NSMutableDictionary dictionary];
        _armbandDecorationViewAttrs = [NSMutableDictionary dictionary];
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self registerClass:DecorationReusableView.class forDecorationViewOfKind:@"DecorationReuseIdentifier"];
    
    [self registerClass:ArmbandDecorationReusableView.class forDecorationViewOfKind:@"ArmbandDecorationReusableView"];
}

// 未布局之时,它用于计算各种布局信息.
- (void)prepareLayout {
    [super prepareLayout];
    
    // 如果collectionView当前没有分区，则直接退出
    if (self.collectionView.numberOfSections == 0) {
        return;
    }
    
    if (!self.decorationDelegate) {
        return;
    }
    
    
    // 删除旧的装饰视图的布局数据
    [self.cardDecorationViewAttrs removeAllObjects];
    [self.armbandDecorationViewAttrs removeAllObjects];
    
    // 分别计算每个section的装饰视图的布局属性
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; ++section) {
        
        // 获取该section的第一个，以及最后一个item的布局属性
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        UICollectionViewLayoutAttributes *firstItem = nil;
        UICollectionViewLayoutAttributes *lastItem = nil;
        
        if (numberOfItems > 0) {
           firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
           lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:numberOfItems - 1 inSection:section]];
        }
        else {
            continue;
        }
        
        id<UICollectionViewDelegateFlowLayout> flowLayoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        
        // 获取该section的内边距
        UIEdgeInsets sectionInset = self.sectionInset;
        
        if (flowLayoutDelegate && [flowLayoutDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            
            sectionInset = [flowLayoutDelegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }
        
        // 计算得到该section实际的位置 CGRectUnion 能够包含两个矩形的最小矩形
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        
        // 计算得到该section实际的尺寸
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.origin.x -= sectionInset.left;
            sectionFrame.origin.y = sectionInset.top;
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.bounds.size.height;
        }
        else {
            sectionFrame.origin.x = sectionInset.left;
            sectionFrame.origin.y -= sectionInset.top;
            sectionFrame.size.width = self.collectionView.bounds.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }

        // 想判断卡片是否可见
        if (self.decorationDelegate && [self.decorationDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            BOOL res = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self decorationDisplayedForSectionAtSection:section];
            if (!res) {
                continue;
            }
        }
        
        UIEdgeInsets cardDecorationInset = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self decorationInsetForSectionAtSection:section];
        // 计算得到cardDecoration该实际的尺寸
        CGRect cardDecorationFrame = sectionFrame;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            cardDecorationFrame.origin.x = sectionFrame.origin.x + cardDecorationInset.left;
            cardDecorationFrame.origin.y = cardDecorationInset.top;
        }
        else {
            cardDecorationFrame.origin.x = cardDecorationInset.left;
            cardDecorationFrame.origin.y = sectionFrame.origin.y + cardDecorationInset.top;
        }
        cardDecorationFrame.size.width = sectionFrame.size.width - (cardDecorationInset.left + cardDecorationInset.right);
        cardDecorationFrame.size.height = sectionFrame.size.height - (cardDecorationInset.top + cardDecorationInset.bottom);
        
        // 根据上面的结果计算卡片装饰图的布局属性
        DecorationCollectionViewLayoutAttributes *cardAttr = [DecorationCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"DecorationReuseIdentifier" withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        cardAttr.frame = cardDecorationFrame;
        
        // zIndex用于设置front-to-back层级；值越大，优先布局在上层；cell的zIndex为0
        cardAttr.zIndex = -1;
        cardAttr.backgroundColor = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self decorationColorForSectionAtSection:section];
        
        //将该section的卡片装饰图的布局属性保存起来
        [self.cardDecorationViewAttrs setObject:cardAttr forKey:@(section)];
        
        
        
        // 先判断袖标是否可见
        BOOL armbandDisplayed = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self armbandDisplayedForSectionAtSection:section];
        if (!armbandDisplayed) {
            continue;
        }
        
        // 如果袖标图片名称为nil，就跳过
        NSString *imageName = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self armbandImageForSectionAtSection:section];
        
        if(!imageName || [imageName isEqualToString:@""]) {
            continue;
        }
        
        // 计算袖标装饰图的属性
        UIEdgeInsets armbandDecorationInset = cardDecorationInset;
        armbandDecorationInset.left = 1;
        armbandDecorationInset.top = 18;
        CGFloat topOffset = [self.decorationDelegate collectionView:self.collectionView collectionViewLayout:self armbandTopOffsetForSectionAtSection:section];
        armbandDecorationInset.top = topOffset;
        
        // 计算得到armbandDecoration该实际的尺寸
        CGRect armbandDecorationFrame = sectionFrame;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            armbandDecorationFrame.origin.x = sectionFrame.origin.x + armbandDecorationInset.left;
            armbandDecorationFrame.origin.y = armbandDecorationInset.top;
        } else {
            armbandDecorationFrame.origin.x = armbandDecorationInset.left;
            armbandDecorationFrame.origin.y = sectionFrame.origin.y + armbandDecorationInset.top;
        }
        armbandDecorationFrame.size.width = 80;
        armbandDecorationFrame.size.height = 53;
        
        // 根据上面的结果计算袖标装饰视图的布局属性
        ArmbandDecorationCollectionViewLayoutAttributes *armbandAttr = [ArmbandDecorationCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"ArmbandDecorationReusableView" withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        
        armbandAttr.frame = armbandDecorationFrame;
        armbandAttr.zIndex = 1;
        armbandAttr.imageName = imageName;
        
        //将该section的袖标装饰视图的布局属性保存起来
        [self.armbandDecorationViewAttrs setObject:armbandAttr forKey:@(section)];
    }
    
}

// 返回rect范围下父类的所有元素的布局属性以及子类自定义装饰视图的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrs = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    
    [self.cardDecorationViewAttrs enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UICollectionViewLayoutAttributes *_Nonnull obj, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [attrs addObject:obj];
        }
        
    }];
    
    [self.armbandDecorationViewAttrs enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UICollectionViewLayoutAttributes *_Nonnull obj, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [attrs addObject:obj];
        }
        
    }];
    
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if ([elementKind isEqualToString:@"DecorationReuseIdentifier"]) {
        return [self.cardDecorationViewAttrs objectForKey:@(section)];
    }
    else if ([elementKind isEqualToString:@"ArmbandDecorationReusableView"]) {
        return [self.armbandDecorationViewAttrs objectForKey:@(section)];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
    
}

@end
