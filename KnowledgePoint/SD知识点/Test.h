//
//  Test.h
//  SD知识点
//
//  Created by feizhu on 2018/3/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegate.h"

@interface Test : NSObject

//- (void)cancel;

- (void)test;

/**
 通过__deprecated_msg宏告诉开发者该方法不建议使用，那么在平时的开发中，如果一个方法被另一个新的方法替代了，就可以使用这个宏来告诉其他的开发者，我有了一个更好的方案。
 */
- (void)oldTest __deprecated; //提醒该方法已废弃

- (void)oldOldTest __deprecated_msg("该方法已被`test`替代，请使用新方法!");

@end
