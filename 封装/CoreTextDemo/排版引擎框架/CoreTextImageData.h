//
//  CoreTextImageData.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger position;    //位置
// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic) CGRect imagePosition;

@end
