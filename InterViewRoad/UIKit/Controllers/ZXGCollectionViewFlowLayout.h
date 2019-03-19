//
//  ZXGCollectionViewFlowLayout.h
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZXGCollectionViewFlowLayout;

@protocol ZXGWaterFlowDelegate <NSObject>

- (CGFloat)waterFlow:(ZXGCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach;

@end

@interface ZXGCollectionViewFlowLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets sectionInset;
@property (nonatomic) CGFloat rowMagrin;
@property (nonatomic) CGFloat colMagrin;
@property (nonatomic) CGFloat colCount;

@property (nonatomic, weak) id<ZXGWaterFlowDelegate> degelate;

@end

NS_ASSUME_NONNULL_END
