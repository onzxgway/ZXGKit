//
//  TKeyBoardManager.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/19.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "TKeyBoardManager.h"

/**
 思路:
 0.启动app的时候,创建一个键盘管理单例对象,该对象为通知的观察者,监听键盘弹出和消失,输入框开始编辑和结束编辑等通知,
 
 1.输入源开始编辑时,通过发送的通知体,可以获取到输入源对象,
 
 2.在键盘显示的时候,比较输入源的最大y值和键盘最终的位置的y值,根据结果,调整window的根视图的位置,避免输入源被键盘遮挡.
 */

@interface TKeyBoardManager () {
    __weak UIView *_textFieldView;
    
    NSTimeInterval _animationDuration;
    
    CGSize _kbSize;
}

@end

@implementation TKeyBoardManager

+ (void)load {
    [self performSelectorOnMainThread:@selector(sharedKeyBoardManager) withObject:nil waitUntilDone:NO];
}

+ (instancetype)sharedKeyBoardManager {
    static TKeyBoardManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TKeyBoardManager alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [strongSelf registerNotification];
            
            _animationDuration = 0.25;
            
            strongSelf.distanceFromKeyBoard = 10.f;
        });
    }
    return self;
}

- (void)registerNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [center addObserver:self selector:@selector(textFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(textFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [center removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    [center removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    NSTimeInterval duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    _animationDuration = duration != 0.0f ? duration : _animationDuration;
    
    CGRect rect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    CGRect resRect = CGRectIntersection(rect, screenSize);
    if (CGRectIsNull(resRect)) {
        _kbSize = CGSizeZero;
    }
    else {
        CGSize size = resRect.size;
        size.height += _distanceFromKeyBoard;
        _kbSize = size;
    }
    
    [self adjustFrame];
    
}

- (void)adjustFrame {
    // 坐标转换
    CGRect textFieldRect = [_textFieldView.superview convertRect:_textFieldView.frame toView:[self keyWindow]];
    
    CGFloat move = CGRectGetMaxY(textFieldRect) - (CGRectGetHeight([UIScreen mainScreen].bounds) - _kbSize.height);
    
    if (move > 0) {
        
    }
    else {
        
    }
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    
}

- (void)textFieldTextDidBeginEditing:(NSNotification *)aNotification {
    _textFieldView = aNotification.object;
}

- (void)textFieldTextDidEndEditing:(NSNotification *)aNotification {
    
}

- (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

- (void)setDistanceFromKeyBoard:(CGFloat)distanceFromKeyBoard {
    _distanceFromKeyBoard = MAX(distanceFromKeyBoard, 0);
}

@end
