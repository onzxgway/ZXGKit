//
//  Rectangle.h
//  DesignatedInitializer
//
//  Created by feizhu on 2018/2/27.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rectangle : NSObject

// property默认 atomic, assign, readwrite
@property (nonatomic, assign, readwrite) float width;
@property (nonatomic) float height;

- (instancetype)initWithWidth:(float)width;

- (instancetype)initWithWidth:(float)width Height:(float)height NS_DESIGNATED_INITIALIZER;

@end
