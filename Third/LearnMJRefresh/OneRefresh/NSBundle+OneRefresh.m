//
//  NSBundle+OneRefresh.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "NSBundle+OneRefresh.h"
#import "OneRefreshComponent.h"

@implementation NSBundle (OneRefresh)

+ (instancetype)refreshBundle {
    static NSBundle *bundle = nil;
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[OneRefreshComponent class]] pathForResource:@"OneRefresh" ofType:@"bundle"]];
    }
    return bundle;
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    
    return [self localizedStringForKey:key value:nil];
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
    
    static NSBundle *bundle = nil;
    if (!bundle) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        }
        else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            }
            else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        // 从OneRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle refreshBundle] pathForResource:language ofType:@"lproj"]];
    }
    
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end
