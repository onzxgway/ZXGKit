//
//  OneKeyBoardManager.h
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/14.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OneKeyBoardManager : NSObject {
    CGSize _kbSize;
    UIView *_textFieldView;
    BOOL _isKeyboardShowing;
    NSTimeInterval _animationDuration;
    //To save rootViewController.view.frame.
    CGRect _topViewBeginRect;
}

+ (instancetype)sharedKeyBoardManager;

@end
