//
//  CascadeViewController.m
//  UICollectionView
//
//  Created by onzxgway on 2019/4/1.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "CascadeViewController.h"
#import "CollectionViewLayout.h"

@interface CascadeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CascadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionViewLayout *layout = [[CollectionViewLayout alloc] init];
    
    [_collectionView setCollectionViewLayout:layout];
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_collectionView setAlwaysBounceHorizontal:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
