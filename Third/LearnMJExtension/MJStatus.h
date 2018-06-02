//
//  MJStatus.h
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <ZXGCommontKit/ZXGCommonKit.h>
@class MJUser;

@interface MJStatus : ZXGRootModel

/** 微博文本内容 */
@property (copy, nonatomic) NSString *text;
/** 微博作者 */
@property (strong, nonatomic) MJUser *user;
/** 转发的微博 */
@property (strong, nonatomic) MJStatus *retweetedStatus;

@end
