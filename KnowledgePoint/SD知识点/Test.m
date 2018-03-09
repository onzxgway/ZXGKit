//
//  Test.m
//  SD知识点
//
//  Created by feizhu on 2018/3/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "Test.h"

@interface Test () <TestDelegate>
@end

@implementation Test

- (void)test {
    NSLog(@"test");
}

- (void)oldTest {
    NSLog(@"oldTest");
}

- (void)oldOldTest {

    NSLog(@"oldOldTest");
}

//- (void)cancel {
//
//}

@end
