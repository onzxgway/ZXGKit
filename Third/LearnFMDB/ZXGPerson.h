//
//  ZXGPerson.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGPerson : NSObject

/** name*/
@property (nonatomic, copy  ) NSString *name;

/** <#备注#>*/
@property (nonatomic, assign) NSUInteger age;

/** home*/
@property (nonatomic, copy  ) NSString *homeAdress;

/** <#备注#>*/
@property (nonatomic, copy  ) NSString *studyNo;

//数据库用于主键
@property (nonatomic, copy  ) NSString *currentAccount;

@end
