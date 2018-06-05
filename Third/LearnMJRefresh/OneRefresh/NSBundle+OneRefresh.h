//
//  NSBundle+OneRefresh.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (OneRefresh)

+ (instancetype)refreshBundle;
+ (NSString *)localizedStringForKey:(NSString *)key;
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

@end
