//
//  Person.m
//  Thread
//
//  Created by onzxgway on 2019/1/10.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, copy ) dispatch_queue_t queue;

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setProperty:(NSString *)name email:(NSString *)email {
    
//    dispatch_barrier_async(_queue, ^{
        self.name = name;
        [self randomDelay:1];
        self.email = email;
//    });

}

- (NSString *)description {
    
//    __block NSString *res = nil;
//    dispatch_sync(_queue, ^{
//        res = [NSString stringWithFormat:@"%@ + %@", self.name, self.email];
//    });
//
    return [NSString stringWithFormat:@"%@ + %@", self.name, self.email];;
}

- (void)randomDelay:(double)maxDuration {
    NSTimeInterval randomWait = arc4random_uniform(maxDuration * USEC_PER_SEC);
    usleep(randomWait);
}

@end
