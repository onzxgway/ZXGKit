//
//  OneKeyBoardManager.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/14.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "OneKeyBoardManager.h"
/**
 核心功能的实现是基于通知机制的
 */

@interface OneKeyBoardManager ()
@property (nonatomic) CGFloat keyboardDistanceFromTextField;
@end

@implementation OneKeyBoardManager

+ (instancetype)sharedKeyBoardManager {
    static OneKeyBoardManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[OneKeyBoardManager alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _keyboardDistanceFromTextField = 10.0;
        
        NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
        
        [noti addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [noti addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [noti addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [noti addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
        
    CGFloat duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSUInteger curve = [[aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    _kbSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"keyboardWillShow:%@", NSStringFromCGSize(_kbSize));
    
    _kbSize.height += _keyboardDistanceFromTextField;
    
    [self adjustFrameWithDuration:duration curve:curve];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSLog(@"keyboardWillHide");
    
    if (_textFieldView == nil) return;
    
    //Boolean to know keyboard is showing/hiding
    _isKeyboardShowing = NO;
    
    //Getting keyboard animation duration
    CGFloat aDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (aDuration != 0.0f) {
        //Setitng keyboard animation duration
        _animationDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    }
    
    //Setting rootViewController frame to it's original position.
    [self setRootViewFrame:_topViewBeginRect curve:0];
}

#pragma mark - UITextField Delegate methods
//Fetching UITextField object from notification.
- (void)textFieldDidBeginEditing:(NSNotification *)notification {
    _textFieldView = notification.object;
    [self commonDidBeginEditing];
}

- (void)commonDidBeginEditing {
    if (_isKeyboardShowing) {
        // keyboard is already showing. adjust frame.
        [self adjustFrameWithDuration:0 curve:0];
    }
    else {
        //keyboard is not showing(At the beginning only). We should save rootViewRect.
        UIViewController *rootController = [OneKeyBoardManager topMostController];
        _topViewBeginRect = rootController.view.frame;
        
        // keyboard is not showing. adjust frame.
        [self adjustFrameWithDuration:_animationDuration curve:0];
    }
}

//Removing fetched object.
- (void)textFieldDidEndEditing:(NSNotification *)notification {
    _textFieldView = nil;
}

//UIKeyboard Did show. Adjusting RootViewController's frame according to device orientation.
- (void)adjustFrameWithDuration:(CGFloat)aDuration curve:(NSUInteger)curve {
    if (_textFieldView == nil) return;
    
    //Boolean to know keyboard is showing/hiding
    _isKeyboardShowing = YES;
    
    if (aDuration != 0.0f) _animationDuration = aDuration;
    
    //Getting KeyWindow object.
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    //Getting RootViewController's view.
    UIViewController *rootController = [OneKeyBoardManager topMostController];
    
    //Converting Rectangle according to window bounds.
    CGRect textFieldViewRect = [_textFieldView.superview convertRect:_textFieldView.frame toView:window];
    
    //Getting RootViewRect.
    CGRect rootViewRect = rootController.view.frame;
    
    CGFloat move;
    //Move positive = textField is hidden.
    //Move negative = textField is showing.
    
    //Calculating move position. Common for both normal and special cases.
    move = CGRectGetMaxY(textFieldViewRect) - (CGRectGetHeight(window.frame) - _kbSize.height);

    
    //Special case.
    if ([[OneKeyBoardManager topMostController] modalPresentationStyle] == UIModalPresentationFormSheet ||
        [[OneKeyBoardManager topMostController] modalPresentationStyle] == UIModalPresentationPageSheet) {
        //Positive or zero.
        if (move >= 0) {
            //We should only manipulate y.
            rootViewRect.origin.y -= move;
            [self setRootViewFrame:rootViewRect curve:curve];
        }
        //Negative
        else {
            //Calculating disturbed distance
            CGFloat disturbDistance = CGRectGetMinY(rootViewRect) - CGRectGetMinY(_topViewBeginRect);
            
            //Move Negative = frame disturbed.
            //Move positive or frame not disturbed.
            if (disturbDistance < 0) {
                //We should only manipulate y.
                rootViewRect.origin.y -= MAX(move, disturbDistance);
                [self setRootViewFrame:rootViewRect curve:curve];
            }
        }
    }
    else {
        //Positive or zero.
        if (move >= 0) {
            //adjusting rootViewRect
            rootViewRect.origin.y -= move;

            //Setting adjusted rootViewRect
            [self setRootViewFrame:rootViewRect curve:curve];
        }
        //Negative
        else {
            //Calculating disturbed distance
            CGFloat disturbDistance = CGRectGetMinY(rootViewRect) - CGRectGetMinY(_topViewBeginRect);
            
            //Move Negative = frame disturbed.
            //Move positive or frame not disturbed.
            if (disturbDistance < 0) {
                //adjusting rootViewRect
                rootViewRect.origin.y -= MAX(move, disturbDistance);
                //Setting adjusted rootViewRect
                [self setRootViewFrame:rootViewRect curve:curve];
            }
        }
    }
}

- (void)setRootViewFrame:(CGRect)frame curve:(NSUInteger)curve {
    //Getting topMost ViewController.
    UIViewController *controller = [OneKeyBoardManager topMostController];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        //Setting it's new frame
        [controller.view setFrame:frame];
    } completion:nil];
}

+ (UIViewController *)topMostController {
    //Getting rootViewController
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //Getting topMost ViewController
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    //Returning topMost ViewController
    return topController;
}

@end
