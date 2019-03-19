//
//  ShopModel.h
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@property (nonatomic) CGFloat w;
@property (nonatomic) CGFloat h;

@end

NS_ASSUME_NONNULL_END
