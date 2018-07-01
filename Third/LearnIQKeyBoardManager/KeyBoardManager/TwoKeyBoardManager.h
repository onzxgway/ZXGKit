//
//  TwoKeyBoardManager.h
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/15.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TwoKeyBoardManager : NSObject

@property (nonatomic) CGFloat keyboardDistanceFromTextField; // <#备注#>

@property (nonatomic, getter=isEnabled) BOOL enable; // <#备注#>

+ (instancetype)sharedKeyBoardManager;

- (instancetype)init __attribute__((unavailable("init is not available in TwoKeyBoardManager, Use class methods")));

+ (instancetype)new __attribute__((unavailable("new is not available in TwoKeyBoardManager, Use class methods")));

@end
