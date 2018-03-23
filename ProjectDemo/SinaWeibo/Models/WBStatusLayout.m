//
//  WBStatusLayout.m
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "WBStatusLayout.h"

@implementation WBStatusLayout

#pragma mark - Overwrite
- (instancetype)initWithStatus:(WBStatus *)status style:(WBLayoutStyle)style {
    if (!status || !status.user) return nil;
    self = [super init];
    if (self) {
        _status = status;
        _style = style;
        [self layout];
    }
    return self;
}

#pragma mark - Init
- (void)layout {

}

#pragma mark - Properties
#pragma mark - Lazy Load
#pragma mark - Singleton
#pragma mark - Dealloc
#pragma mark - Setter
#pragma mark - Private
#pragma mark - Public
#pragma mark - APIs
#pragma mark - Events
@end
