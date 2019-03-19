//
//  ZXGCollectionViewCell.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGCollectionViewCell.h"

@implementation ZXGCollectionViewCell

- (void)setShopModel:(ShopModel *)shopModel {
    _shopModel = shopModel;
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_shop.img]];
    self.label.text = _shopModel.price;
    
}

@end
