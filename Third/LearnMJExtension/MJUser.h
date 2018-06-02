//
//  MJUser.h
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <ZXGCommontKit/ZXGCommonKit.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface MJUser : ZXGRootModel

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (nonatomic) NSUInteger age;
/** 身高 */
@property (strong, nonatomic) NSNumber *height;
/** 财富 */
@property (strong, nonatomic) NSDecimalNumber *money;
/** 性别 */
@property (nonatomic) Sex sex;
/** 同性恋 */
@property (nonatomic, getter=isGay) BOOL gay;

@end
