//
//  TKeyBoardManager.m
//  LearnIQKeyBoardManager
//
//  Created by 朱献国 on 2018/6/19.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "TKeyBoardManager.h"
#import "UIView+Hierarchy.h"

/**
 思路:
 0.启动app的时候,创建一个键盘管理单例对象,该对象为通知的观察者,监听键盘弹出和消失,输入框开始编辑和结束编辑等通知,
 
 1.输入源开始编辑时,通过发送的通知体,可以获取到输入源对象,
 
 2.在键盘显示的时候,比较输入源的最大y值和键盘最终的位置的y值,根据结果,调整window的根视图的位置,避免输入源被键盘遮挡.
 
 (v3.0之后新增: 先递归寻找当前view的父视图是否是UIScrollView,如果是的话,跳转UIScrollView的垂直偏移量,,,如果找不到UIScrollView, 就调整window的根视图的位置)
 */

@interface TKeyBoardManager () {
    __weak UIView *_textFieldView;
    
    NSTimeInterval _animationDuration;
    
    CGSize _kbSize;
    
    CGRect _topViewBeginRect;
    
    NSNotification *_kbShowNotification;
    
    /*! Variable to save lastScrollView that was scrolled. */
    UIScrollView *_lastScrollView;
    
    /*! LastScrollView's initial contentOffset. */
    CGPoint _startingContentOffset;
}

@property (nonatomic, strong) NSMutableSet<Class> *disabledDistanceHandlingClasses; // <#备注#>

@property (nonatomic, strong) NSMutableSet<Class> *enabledDistanceHandlingClasses; // <#备注#>

@end

@implementation TKeyBoardManager

+ (void)load {
    [self performSelectorOnMainThread:@selector(sharedKeyBoardManager) withObject:nil waitUntilDone:NO];
}

+ (instancetype)sharedKeyBoardManager {
    static TKeyBoardManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
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
            strongSelf.enable = NO;
            strongSelf.disabledDistanceHandlingClasses = [[NSMutableSet alloc] initWithObjects:[UITableViewController class], [UIAlertController class], nil];
            strongSelf.enabledDistanceHandlingClasses = [[NSMutableSet alloc] init];
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
    _kbShowNotification = aNotification;
    
    NSTimeInterval duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    _animationDuration = duration != 0.0f ? duration : _animationDuration;
    
    CGRect rect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    CGRect resRect = CGRectIntersection(rect, screenSize);
    
    CGSize oldKBSize = _kbSize;
    
    if (CGRectIsNull(resRect)) {
        _kbSize = CGSizeZero;
    }
    else {
        CGSize size = resRect.size;
        size.height += _distanceFromKeyBoard;
        _kbSize = size;
    }
    
    if (![self keyBoardManagerIsEnable]) return;
    
    
    if (!CGSizeEqualToSize(oldKBSize, _kbSize)) {
        
        [self adjustFrame];
    }
    
}

- (void)adjustFrame {
    
    if (_textFieldView == nil) return;
    
    
    // 坐标转换
    CGRect textFieldRect = [_textFieldView.superview convertRect:_textFieldView.frame toView:[self keyWindow]];
    
    CGFloat move = CGRectGetMaxY(textFieldRect) - (CGRectGetHeight([UIScreen mainScreen].bounds) - _kbSize.height);
    
    UIViewController *topMostController = [_textFieldView topMostController];
    CGRect topViewRect = topMostController.view.frame;
    
    UIScrollView *superScrollView = [_textFieldView superScrollView];
    
    if (_lastScrollView) {
        
        if (!superScrollView) {
            [_lastScrollView setContentOffset:_startingContentOffset animated:YES];
            _lastScrollView = nil;
            _startingContentOffset = CGPointZero;
        }
        
        if (superScrollView && _lastScrollView != superScrollView) {
            [_lastScrollView setContentOffset:_startingContentOffset animated:YES];
            _lastScrollView = superScrollView;
            _startingContentOffset = superScrollView.contentOffset;
        }
        
    }
    else if (superScrollView) {
        _lastScrollView = superScrollView;
        _startingContentOffset = superScrollView.contentOffset;
    }
    
    if (_lastScrollView) {
        UIView *lastView = _textFieldView;
        UIScrollView *superScrollView = _lastScrollView;
        
        while (superScrollView) {
            CGRect lastViewRect = [[lastView superview] convertRect:lastView.frame toView:superScrollView];
            
            CGFloat shouldOffsetY = superScrollView.contentOffset.y - MIN(superScrollView.contentOffset.y, -move);
            shouldOffsetY = MIN(shouldOffsetY, lastViewRect.origin.y - 5);   //-5 is for good UI.
            
            move -= (shouldOffsetY - superScrollView.contentOffset.y);
            
            //Getting problem while using `setContentOffset:animated:`, So I used animation API.
            [UIView animateWithDuration:_animationDuration animations:^{
                superScrollView.contentOffset = CGPointMake(superScrollView.contentOffset.x, shouldOffsetY);
            }];
            
            //  Getting it's superScrollView.
            lastView = superScrollView;
            superScrollView = [lastView superScrollView];
        }
    }
    
    if (move > 0) {
        topViewRect.origin.y -= move;
        [self setRootViewFrame:topViewRect];
    }
    else {
        
    }
}

- (void)setRootViewFrame:(CGRect)frame {
    UIViewController *topMostController = [_textFieldView topMostController];
    [UIView animateWithDuration:_animationDuration animations:^{
        topMostController.view.frame = frame;
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    if (aNotification) _kbShowNotification = nil;
    
    NSTimeInterval duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    _animationDuration = duration != 0.0f ? duration : _animationDuration;
    
    if (![self keyBoardManagerIsEnable]) return;
    
    [self setRootViewFrame:_topViewBeginRect];
}

- (void)textFieldTextDidBeginEditing:(NSNotification *)aNotification {
    _textFieldView = aNotification.object;
    _topViewBeginRect = [_textFieldView topMostController].view.frame;
}

- (void)textFieldTextDidEndEditing:(NSNotification *)aNotification {
    
}

- (UIWindow *)keyWindow {
    if (_textFieldView.window) {
        return _textFieldView.window;
    }
    else {
        return [[UIApplication sharedApplication] keyWindow];
    }
}

- (void)setDistanceFromKeyBoard:(CGFloat)distanceFromKeyBoard {
    _distanceFromKeyBoard = MAX(distanceFromKeyBoard, 0);
}

- (void)setEnable:(BOOL)enable {
    
    if (enable && !_enable) {
        _enable = enable;
        
        if (_kbShowNotification) [self keyboardWillShow:_kbShowNotification];
    }
    else if (!enable && _enable) {
        [self keyboardWillHide:nil];
        
        _enable = enable;
    }
    
}

- (BOOL)keyBoardManagerIsEnable {
    UIViewController *tfContainingController = [_textFieldView viewContainingController];
    
    if (tfContainingController) {
        if (!_enable) {
            
            for (Class clazz in _enabledDistanceHandlingClasses) {
                if ([tfContainingController isKindOfClass:clazz]) {
                    _enable = YES;
                    break;
                }
            }
            
        }
        
        if (_enable) {
            for (Class clazz in _disabledDistanceHandlingClasses) {
                if ([tfContainingController isKindOfClass:clazz]) {
                    _enable = NO;
                    break;
                }
            }
            
            //Special Controllers
            if (_enable) {
                NSString *classNameString = NSStringFromClass([tfContainingController class]);
                
                //_UIAlertControllerTextFieldViewController
                if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"]) {
                    _enable = NO;
                }
            }
        }
    }
    
    return _enable;
}

@end
