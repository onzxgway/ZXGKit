//
//  Book.h
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;

+ (instancetype)bookWithDict:(NSDictionary *)dict;

@end
