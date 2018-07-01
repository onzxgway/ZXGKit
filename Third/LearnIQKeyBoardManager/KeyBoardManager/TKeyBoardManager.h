//
//  TKeyBoardManager.h
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/19.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKeyBoardManager : NSObject

@property (nonatomic) CGFloat distanceFromKeyBoard; // <#备注#>

@property (nonatomic, getter=isEnabled) BOOL enable; // 默认NO

@property (nonatomic, strong, readonly) NSMutableSet<Class> *disabledDistanceHandlingClasses; // 强制关闭

@property (nonatomic, strong, readonly) NSMutableSet<Class> *enabledDistanceHandlingClasses; // 强制开启

+ (instancetype)sharedKeyBoardManager;


/**
 请使用 sharedKeyBoardManager
 */
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end
