//
//  ZXGCollectionViewController.m
//  UICollectionView
//
//  Created by 朱献国 on 2018/5/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGCollectionViewController.h"
#import "ZXGCommonKit.h"

@interface ZXGCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation ZXGCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(68, 68);
    layout.minimumInteritemSpacing = 18;
    layout.minimumLineSpacing = 18;
    // 方法一
//    layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 111;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = kRandomColor;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 方法二
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    NSInteger numberOfItems = [collectionView numberOfItemsInSection:section];

    CGFloat combinedItemWidth = 0.f;
    for (NSInteger i = 1; i <= numberOfItems; ++i) {
        CGFloat tempCombinedItemWidth = (i * collectionViewLayout.itemSize.width) + ((i - 1) * collectionViewLayout.minimumInteritemSpacing);
        if (tempCombinedItemWidth > collectionView.frame.size.width) {
            break;
        }
        combinedItemWidth = tempCombinedItemWidth;
    }

    if (combinedItemWidth > 0) {
        
        CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) * 0.5;
        
        padding = padding > 0 ? padding : 0;
        
        return UIEdgeInsetsMake(0, padding, 0, padding);
    }
    
    return UIEdgeInsetsZero;
}

@end
