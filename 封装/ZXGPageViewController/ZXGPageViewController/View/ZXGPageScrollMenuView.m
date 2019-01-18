//
//  ZXGPageScrollMenuView.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGPageScrollMenuView.h"
#import "ZXGPageConfigration.h"

@interface ZXGPageScrollMenuView ()
/// 配置信息
@property (nonatomic, strong) ZXGPageConfigration *configration;
/// 上次index
@property (nonatomic) NSInteger lastIndex;
/// 当前index
@property (nonatomic) NSInteger currentIndex;
/// items
@property (nonatomic, strong) NSMutableArray<UIButton *> *itemsArrayM;

@end

@implementation ZXGPageScrollMenuView

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame titles:@[].mutableCopy configration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectZero titles:@[].mutableCopy configration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

#pragma mark - API
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSMutableArray<NSString *> *)titles
                 configration:(ZXGPageConfigration *)configration
                     delegate:(id<ZXGPageScrollMenuViewDelegate>)delegate
                 currentIndex:(NSInteger)currentIndex {
    
    self = [super initWithFrame:frame];
    if (self) {
        frame.size.height = configration.menuHeight;
        frame.size.width = configration.menuWidth;
        
        _titles = titles;
        //    menuView.delegate = delegate;
        _configration = configration ?: [ZXGPageConfigration defaultConfig];
        _currentIndex = currentIndex;
        _itemsArrayM = @[].mutableCopy;
//        _itemsWidthArraM = @[].mutableCopy;
        
        [self createSubViews];
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
    
}

- (void)adjustItemWithProgress:(CGFloat)progress
                     lastIndex:(NSInteger)lastIndex
                  currentIndex:(NSInteger)currentIndex {
    self.lastIndex = lastIndex;
    self.currentIndex = currentIndex;
    
    if (lastIndex == currentIndex) return;
    UIButton *lastButton = self.itemsArrayM[self.lastIndex];
    UIButton *currentButton = self.itemsArrayM[self.currentIndex];
    
    /// 缩放系数
    if (self.configration.itemMaxScale > 1) {
        CGFloat scaleB = self.configration.itemMaxScale - self.configration.deltaScale * progress;
        CGFloat scaleS = 1 + self.configration.deltaScale * progress;
        lastButton.transform = CGAffineTransformMakeScale(scaleB, scaleB);
        currentButton.transform = CGAffineTransformMakeScale(scaleS, scaleS);
    }
    
    if (self.configration.showGradientColor) {
        
        /// 颜色渐变
        [self.configration setRGBWithProgress:progress];
        UIColor *norColor = [UIColor colorWithRed:self.configration.deltaNorR green:self.configration.deltaNorG blue:self.configration.deltaNorB alpha:1];
        UIColor *selColor = [UIColor colorWithRed:self.configration.deltaSelR green:self.configration.deltaSelG blue:self.configration.deltaSelB alpha:1];
        [lastButton setTitleColor:norColor forState:UIControlStateNormal];
        
        [currentButton setTitleColor:selColor forState:UIControlStateNormal];
    } else{
        if (progress > 0.5) {
            lastButton.selected = NO;
            currentButton.selected = YES;
            [lastButton setTitleColor:self.configration.normalItemColor forState:UIControlStateNormal];
            [currentButton setTitleColor:self.configration.selectedItemColor forState:UIControlStateNormal];
            currentButton.titleLabel.font = self.configration.selectedItemFont;
            
        } else if (progress < 0.5 && progress > 0){
            lastButton.selected = YES;
            [lastButton setTitleColor:self.configration.selectedItemColor forState:UIControlStateNormal];
            lastButton.titleLabel.font = self.configration.selectedItemFont;
            
            currentButton.selected = NO;
            [currentButton setTitleColor:self.configration.normalItemColor forState:UIControlStateNormal];
            currentButton.titleLabel.font = self.configration.itemFont;
            
        }
    }
    
    if (progress > 0.5) {
        lastButton.titleLabel.font = self.configration.itemFont;
        currentButton.titleLabel.font = self.configration.selectedItemFont;
    } else if (progress < 0.5 && progress > 0){
        lastButton.titleLabel.font = self.configration.selectedItemFont;
        currentButton.titleLabel.font = self.configration.itemFont;
    }
    CGFloat xD = 0;
    CGFloat wD = 0;
    if (!self.configration.scrollMenu &&
        !self.configration.aligmentModeCenter &&
        self.configration.lineWidthEqualFontWidth) {
        xD = currentButton.titleLabel.yn_x + currentButton.yn_x -( lastButton.titleLabel.yn_x + lastButton.yn_x );
        
        wD = currentButton.titleLabel.yn_width - lastButton.titleLabel.yn_width;
    } else {
        xD = currentButton.yn_x - lastButton.yn_x;
        wD = currentButton.yn_width - lastButton.yn_width;
    }
    
    /// 线条
    if (self.configration.showScrollLine) {
        
        if (!self.configration.scrollMenu &&
            !self.configration.aligmentModeCenter &&
            self.configration.lineWidthEqualFontWidth) { /// 处理Line宽度等于字体宽度
            self.lineView.yn_x = lastButton.yn_x + ([lastButton yn_width]  - ([self.itemsWidthArraM[lastButton.tag] floatValue])) / 2 - self.configration.lineLeftAndRightAddWidth + xD *progress;
            
            self.lineView.yn_width = [self.itemsWidthArraM[lastButton.tag] floatValue] + self.configration.lineLeftAndRightAddWidth *2 + wD *progress;
            
        } else {
            self.lineView.yn_x = lastButton.yn_x + xD *progress - self.configration.lineLeftAndRightAddWidth + self.configration.lineLeftAndRightMargin;
            self.lineView.yn_width = lastButton.yn_width + wD *progress + self.configration.lineLeftAndRightAddWidth *2 - 2 * self.configration.lineLeftAndRightMargin;
        }
    }
    /// 遮盖
    if (self.configration.showConver) {
        self.converView.yn_x = lastButton.yn_x + xD *progress - kYNPageScrollMenuViewConverMarginX;
        self.converView.yn_width = lastButton.yn_width  + wD *progress + kYNPageScrollMenuViewConverMarginW;
        
        if (!self.configration.scrollMenu &&
            !self.configration.aligmentModeCenter &&
            self.configration.lineWidthEqualFontWidth) { /// 处理cover宽度等于字体宽度
            self.converView.yn_x = lastButton.yn_x + ([lastButton yn_width]  - ([self.itemsWidthArraM[lastButton.tag] floatValue])) / 2 -  kYNPageScrollMenuViewConverMarginX + xD *progress;
            self.converView.yn_width = [self.itemsWidthArraM[lastButton.tag] floatValue] + kYNPageScrollMenuViewConverMarginW + wD *progress;
        }
        
    }
}


#pragma mark - CreateView
- (void)createSubViews {
    
    self.backgroundColor = self.configration.scrollViewBackgroundColor;
    
    [self setupItems];
    [self setupOtherViews];
}

- (void)setupItems {
    
    if (self.configration.buttonArray.count > 0 && self.titles.count == self.configration.buttonArray.count) {
        [self.configration.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull itemButton, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setupButton:itemButton title:self.titles[idx] idx:idx];
        }];
    }
    else {
        [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupButton:itemButton title:title idx:idx];
        }];
    }
    
}

- (void)setupButton:(UIButton *)itemButton title:(NSString *)title idx:(NSInteger)idx {
    
    itemButton.titleLabel.font = self.configration.selectedItemFont;
    [itemButton setTitleColor:self.configration.normalItemColor forState:UIControlStateNormal];
    [itemButton setTitle:title forState:UIControlStateNormal];
    itemButton.tag = idx;
    
    [itemButton addTarget:self action:@selector(itemButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [itemButton sizeToFit];
    
    [self.itemsWidthArraM addObject:@(itemButton.yn_width)];
    [self.itemsArrayM addObject:itemButton];
    [self.scrollView addSubview:itemButton];
    
}

- (void)setupOtherViews {
    
    self.scrollView.frame = CGRectMake(0, 0, self.configration.showAddButton ? self.yn_width - self.yn_height : self.yn_width, self.yn_height);
    
    [self addSubview:self.scrollView];
    
    if (self.configration.showAddButton) {
        self.addButton.frame = CGRectMake(self.yn_width - self.yn_height, 0, self.yn_height, self.yn_height);
        [self addSubview:self.addButton];
    }
    
    /// item
    __block CGFloat itemX = 0;
    __block CGFloat itemY = 0;
    __block CGFloat itemW = 0;
    __block CGFloat itemH = self.yn_height - self.configration.lineHeight;
    
    [self.itemsArrayM enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            itemX += self.configration.itemLeftAndRightMargin;
        }else{
            itemX += self.configration.itemMargin + [self.itemsWidthArraM[idx - 1] floatValue];
        }
        button.frame = CGRectMake(itemX, itemY, [self.itemsWidthArraM[idx] floatValue], itemH);
    }];
    
    CGFloat scrollSizeWidht = self.configration.itemLeftAndRightMargin + CGRectGetMaxX([[self.itemsArrayM lastObject] frame]);
    if (scrollSizeWidht < self.scrollView.yn_width) {//不超出宽度
        itemX = 0;
        itemY = 0;
        itemW = 0;
        
        CGFloat left = 0;
        
        for (NSNumber *width in self.itemsWidthArraM) {
            left += [width floatValue];
        }
        
        left = (self.scrollView.yn_width - left - self.configration.itemMargin * (self.itemsWidthArraM.count-1)) * 0.5;
        /// 居中且有剩余间距
        if (self.configration.aligmentModeCenter && left >= 0) {
            [self.itemsArrayM enumerateObjectsUsingBlock:^(UIButton  * button, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == 0) {
                    itemX += left;
                }else{
                    itemX += self.configration.itemMargin + [self.itemsWidthArraM[idx - 1] floatValue];
                }
                button.frame = CGRectMake(itemX, itemY, [self.itemsWidthArraM[idx] floatValue], itemH);
            }];
            
            self.scrollView.contentSize = CGSizeMake(left + CGRectGetMaxX([[self.itemsArrayM lastObject] frame]), self.scrollView.yn_height);
            
        } else { /// 否则按原来样子
            /// 不能滚动则平分
            if (!self.configration.scrollMenu) {
                [self.itemsArrayM enumerateObjectsUsingBlock:^(UIButton  * button, NSUInteger idx, BOOL * _Nonnull stop) {
                    itemW = self.scrollView.yn_width / self.itemsArrayM.count;
                    itemX = itemW *idx;
                    button.frame = CGRectMake(itemX, itemY, itemW, itemH);
                }];
                
                self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([[self.itemsArrayM lastObject] frame]), self.scrollView.yn_height);
                
            } else {
                self.scrollView.contentSize = CGSizeMake(scrollSizeWidht, self.scrollView.yn_height);
            }
        }
    } else { /// 大于scrollView的width·
        self.scrollView.contentSize = CGSizeMake(scrollSizeWidht, self.scrollView.yn_height);
    }
    
    CGFloat lineX = [(UIButton *)[self.itemsArrayM firstObject] yn_x];
    CGFloat lineY = self.scrollView.yn_height - self.configration.lineHeight;
    CGFloat lineW = [[self.itemsArrayM firstObject] yn_width];
    CGFloat lineH = self.configration.lineHeight;
    
    if (!self.configration.scrollMenu &&
        !self.configration.aligmentModeCenter &&
        self.configration.lineWidthEqualFontWidth) { ///处理Line宽度等于字体宽度
        lineX = [(UIButton *)[self.itemsArrayM firstObject] yn_x] + ([[self.itemsArrayM firstObject] yn_width]  - ([self.itemsWidthArraM.firstObject floatValue])) / 2;
        lineW = [self.itemsWidthArraM.firstObject floatValue];
    }
    
    /// conver
    if (self.configration.showConver) {
        self.converView.frame = CGRectMake(lineX - kYNPageScrollMenuViewConverMarginX, (self.scrollView.yn_height - self.configration.converHeight - self.configration.lineHeight) * 0.5, lineW + kYNPageScrollMenuViewConverMarginW, self.configration.converHeight);
        [self.scrollView insertSubview:self.converView atIndex:0];
    }
    /// bottomline
    if (self.configration.showBottomLine) {
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.backgroundColor = self.configration.bottomLineBgColor;
        self.bottomLine.frame = CGRectMake(self.configration.bottomLineLeftAndRightMargin, self.yn_height - self.configration.bottomLineHeight, self.scrollView.yn_width - 2 * self.configration.bottomLineLeftAndRightMargin, self.configration.bottomLineHeight);
        self.bottomLine.layer.cornerRadius = self.configration.bottomLineCorner;
        [self insertSubview:self.bottomLine atIndex:0];
    }
    
    if (self.configration.showScrollLine) {
        self.lineView.frame = CGRectMake(lineX - self.configration.lineLeftAndRightAddWidth + self.configration.lineLeftAndRightMargin, lineY - self.configration.lineBottomMargin, lineW + self.configration.lineLeftAndRightAddWidth * 2 - 2 * self.configration.lineLeftAndRightMargin, lineH);
        self.lineView.layer.cornerRadius = self.configration.lineCorner;
        [self.scrollView addSubview:self.lineView];
    }
    
    if (self.configration.itemMaxScale > 1) {
        ((UIButton *)self.itemsArrayM[self.currentIndex]).transform = CGAffineTransformMakeScale(self.configration.itemMaxScale, self.configration.itemMaxScale);
    }
    
    [self setDefaultTheme];
    
    [self selectedItemIndex:self.currentIndex animated:NO];
    
}

@end
