//
//  TwoKeyBoardManager.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/15.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "TwoKeyBoardManager.h"

@implementation TwoKeyBoardManager {
    
    NSTimeInterval _animationDuration;
    
    CGSize _kbSize;
    
    UIView *_textField;
    
    NSNotification *_aNotification;
    
    CGRect _rootViewBeginRect;
    
    BOOL _isKeyboardShowing;
}

+ (instancetype)sharedKeyBoardManager {
    static TwoKeyBoardManager *_keyBoardManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyBoardManager = [[TwoKeyBoardManager alloc] initSingleton];
    });
    return _keyBoardManager;
}

- (instancetype)initSingleton {
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            
            [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
            
            [center addObserver:self selector:@selector(textFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
            [center addObserver:self selector:@selector(textFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
            
            [self setKeyboardDistanceFromTextField:10.f];
            
            [self setEnable:YES];
            
            _animationDuration = 0.25;
        });
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    
    _aNotification = noti;
    
    if (!_enable) return;
    
    NSTimeInterval duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    _animationDuration = duration != 0.0f ? duration : _animationDuration;
    
    _kbSize = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _kbSize.height += _keyboardDistanceFromTextField;
    
    [self adjustFrame];
}

- (void)adjustFrame {
    
    if (!_textField) return;
    
    _isKeyboardShowing = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect tfWindowRect = [_textField.superview convertRect:_textField.frame toView:window];
    
    UIViewController *rootCtrl = [TwoKeyBoardManager topMostController];
    
    CGFloat move = CGRectGetMaxY(tfWindowRect) - (CGRectGetHeight(window.frame) - _kbSize.height);
    
    CGRect rootViewRect = [[rootCtrl view] frame];
    if (move >= 0) {
        
        rootViewRect.origin.y -= move;
        
        [self setRootViewFrame:rootViewRect];
    }
    else {
        
        CGFloat disturbDistance = CGRectGetMinY(rootViewRect) - CGRectGetMinY(_rootViewBeginRect);
        if (disturbDistance < 0) {
            rootViewRect.origin.y -= MAX(disturbDistance, move);
            [self setRootViewFrame:rootViewRect];
        }
    }
}
                                  
+ (UIViewController *)topMostController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIViewController *rootCtrl = window.rootViewController;
    
    while ([rootCtrl presentedViewController]) rootCtrl = [rootCtrl presentedViewController];
    
    return rootCtrl;
}

- (void)setRootViewFrame:(CGRect)frame {
    
    UIViewController *rootCtrl = [TwoKeyBoardManager topMostController];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        rootCtrl.view.frame = frame;
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    _aNotification = nil;
    
    if (!_enable) return;
    
    if (!_textField) return;
    
    _isKeyboardShowing = NO;
    
    NSTimeInterval duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    _animationDuration = duration != 0.0f ? duration : _animationDuration;
    
    [self setRootViewFrame:_rootViewBeginRect];
}

- (void)textFieldTextDidBeginEditing:(NSNotification *)noti {
    
    _textField = noti.object;
    
    if (_enable == NO) return;
    
    if (!_isKeyboardShowing) {
        //  keyboard is not showing(At the beginning only). We should save rootViewRect.
        UIViewController *rootController = [TwoKeyBoardManager topMostController];
        _rootViewBeginRect = rootController.view.frame;
    }
    
    //  keyboard is already showing. adjust frame.
    [self adjustFrame];
}

- (void)textFieldTextDidEndEditing:(NSNotification *)noti {
    _textField = nil;
}

- (void)setKeyboardDistanceFromTextField:(CGFloat)keyboardDistanceFromTextField {
    _keyboardDistanceFromTextField = MAX(keyboardDistanceFromTextField, 0);
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
}

@end
