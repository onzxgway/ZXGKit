//
//  MVVMViewModel.h
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModel.h"

@interface MVVMViewModel : NSObject

@property (nonatomic, copy  ) NSString *contentStr;

@property (nonatomic, strong) MVVMModel *mVVMModel;

- (void)clickEvent;

@end
