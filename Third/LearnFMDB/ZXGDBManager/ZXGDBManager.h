//
//  ZXGDBManager.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGDBOperation.h"

@interface ZXGDBManager : NSObject

+ (ZXGDBManager *)sharedManager;

- (void)addOperation:(ZXGDBOperation *)operation;

@end
