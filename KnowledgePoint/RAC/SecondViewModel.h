//
//  SecondViewModel.h
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondViewModel : NSObject

// 保存登录界面的账号和密码
/** 账号 */
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;

@property (nonatomic, strong) RACSignal *loginBtnEnableSignal;
@property (nonatomic, strong) RACCommand *loginSignal;
@property (nonatomic, strong) RACCommand *reqSignal;

@end
