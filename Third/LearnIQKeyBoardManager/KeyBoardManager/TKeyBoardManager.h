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

+ (instancetype)sharedKeyBoardManager;

@end
