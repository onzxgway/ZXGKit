//
//  MJStatusResult.m
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJStatusResult.h"

@implementation MJStatusResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"statuses" : @"MJStatus",
             @"ads" : @"MJAd"
             };
}

@end
