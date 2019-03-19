//
//  DecorationCollectionViewLayout.h
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DecorationCollectionViewLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol DecorationCollectionViewLayoutDelegate <NSObject>

@required
/// 指定section是否显示卡片装饰图，默认值为false
- (BOOL)collectionView:(UICollectionView *)collectionView
  collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
decorationDisplayedForSectionAtSection:(NSInteger)section;

/// 指定section卡片装饰图颜色，默认为白色
- (UIColor *)collectionView:(UICollectionView *)collectionView
       collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
decorationColorForSectionAtSection:(NSInteger)section;

/// 指定section卡片装饰图间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
          collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
    decorationInsetForSectionAtSection:(NSInteger)section;

/// 指定section卡片装饰图是否显示袖标，默认值为false
- (BOOL)collectionView:(UICollectionView *)collectionView
  collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandDisplayedForSectionAtSection:(NSInteger)section;

/// 指定section的袖标图标本地图片名字，默认为nil
- (NSString *)collectionView:(UICollectionView *)collectionView
  collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandImageForSectionAtSection:(NSInteger)section;

/// 指定section的袖标距离卡片的TopOffsetp
- (CGFloat)collectionView:(UICollectionView *)collectionView
        collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandTopOffsetForSectionAtSection:(NSInteger)section;

@end

@interface DecorationCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak  ) id<DecorationCollectionViewLayoutDelegate> decorationDelegate;

@end


@interface DecorationCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *backgroundColor;

@end


@interface ArmbandDecorationCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, copy  ) NSString *imageName;

@end


NS_ASSUME_NONNULL_END
