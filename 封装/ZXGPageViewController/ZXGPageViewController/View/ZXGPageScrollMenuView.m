//
//  ZXGPageScrollMenuView.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGPageScrollMenuView.h"
#import "ZXGPageConfigration.h"

@implementation ZXGPageScrollMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame titles:@[].mutableCopy configration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectZero titles:@[].mutableCopy configration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSMutableArray<NSString *> *)titles
                 configration:(ZXGPageConfigration *)configration
                     delegate:(id<ZXGPageScrollMenuViewDelegate>)delegate
                 currentIndex:(NSInteger)currentIndex {
    
    self = [super initWithFrame:frame];
    if (self) {
        frame.size.height = configration.menuHeight;
        frame.size.width = configration.menuWidth;
        
        //    menuView.titles = titles;
        //    menuView.delegate = delegate;
        //    menuView.configration = configration ?: [YNPageConfigration defaultConfig];
        //    menuView.currentIndex = currentIndex;
        //    menuView.itemsArrayM = @[].mutableCopy;
        //    menuView.itemsWidthArraM = @[].mutableCopy;
        //
        //    [menuView setupSubViews];
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
    
}

@end
