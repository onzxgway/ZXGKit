//
//  Person.h
//  Thread
//
//  Created by onzxgway on 2019/1/10.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy ) NSString *name;
@property (nonatomic, copy ) NSString *email;

- (void)setProperty:(NSString *)name email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END