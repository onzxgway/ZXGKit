//
//  ZXGCollectionViewCell.h
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXGCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ShopModel *shopModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END
