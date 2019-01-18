//
//  ZXGPageScrollMenuView.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGPageScrollMenuView.h"
#import "ZXGPageConfigration.h"
#import "ZXGPageScrollView.h"
#import "UIView+ZXGPageExtend.h"

@interface ZXGPageScrollMenuView ()

/// line指示器
@property (nonatomic, strong) UIView *lineView;
/// 底部线条
@property (nonatomic, strong) UIView *bottomLine;
/// 蒙层
@property (nonatomic, strong) UIView *converView;
/// ScrollView
@property (nonatomic, strong) ZXGPageScrollView *scrollView;
/// 代理
@property (nonatomic, weak  ) id<ZXGPageScrollMenuViewDelegate> delegate;
/// 配置信息
@property (nonatomic, strong) ZXGPageConfigration *configuration;
/// 上次index
@property (nonatomic) NSInteger lastIndex;
/// 当前index
@property (nonatomic) NSInteger currentIndex;
/// items
@property (nonatomic, strong) NSMutableArray<UIButton *> *itemsM;
/// item宽度
@property (nonatomic, strong) NSMutableArray<NSNumber *> *itemsWidthM;

@end

/**
 UI 层级结构：
 
    UIView (self)
 
        UIScrollView
            UIButton
            ....
            UIView (滚动线段)
 
        UIButton
 
 
        UIView (底部线条 和 UIScrollView 同宽)
 */


@implementation ZXGPageScrollMenuView

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame titles:@[].mutableCopy configuration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectZero titles:@[].mutableCopy configuration:[ZXGPageConfigration defaultConfig] delegate:nil currentIndex:0];
}

#pragma mark - APIs
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                configuration:(ZXGPageConfigration *)configuration
                     delegate:(id<ZXGPageScrollMenuViewDelegate>)delegate
                 currentIndex:(NSInteger)currentIndex {
    
    frame.size.height = configuration.menuHeight;
    frame.size.width = configuration.menuWidth;
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _titles = titles;
        _delegate = delegate;
        _configuration = configuration ?: [ZXGPageConfigration defaultConfig];
        _currentIndex = currentIndex;
        _itemsM = @[].mutableCopy;
        _itemsWidthM = @[].mutableCopy;
        
        [self createSubViews];
        
    }
    return self;
    
}

- (void)adjustItemWithProgress:(CGFloat)progress
                     lastIndex:(NSInteger)lastIndex
                  currentIndex:(NSInteger)currentIndex {
    self.lastIndex = lastIndex;
    self.currentIndex = currentIndex;
    
    if (lastIndex == currentIndex) return;
    UIButton *lastButton = self.itemsM[self.lastIndex];
    UIButton *currentButton = self.itemsM[self.currentIndex];

    /// 缩放系数
    if (self.configuration.itemMaxScale > 1) {
//        CGFloat scaleB = self.configuration.itemMaxScale - self.configuration.deltaScale * progress;
//        CGFloat scaleS = 1 + self.configuration.deltaScale * progress;
//        lastButton.transform = CGAffineTransformMakeScale(scaleB, scaleB);
//        currentButton.transform = CGAffineTransformMakeScale(scaleS, scaleS);
    }

//    if (self.configuration.showGradientColor) {
//
//        /// 颜色渐变
//        [self.configuration setRGBWithProgress:progress];
//        UIColor *norColor = [UIColor colorWithRed:self.configuration.deltaNorR green:self.configuration.deltaNorG blue:self.configuration.deltaNorB alpha:1];
//        UIColor *selColor = [UIColor colorWithRed:self.configuration.deltaSelR green:self.configuration.deltaSelG blue:self.configuration.deltaSelB alpha:1];
//        [lastButton setTitleColor:norColor forState:UIControlStateNormal];
//
//        [currentButton setTitleColor:selColor forState:UIControlStateNormal];
//    } else{
//        if (progress > 0.5) {
//            lastButton.selected = NO;
//            currentButton.selected = YES;
//            [lastButton setTitleColor:self.configuration.normalItemColor forState:UIControlStateNormal];
//            [currentButton setTitleColor:self.configuration.selectedItemColor forState:UIControlStateNormal];
//            currentButton.titleLabel.font = self.configuration.selectedItemFont;
//
//        } else if (progress < 0.5 && progress > 0){
//            lastButton.selected = YES;
//            [lastButton setTitleColor:self.configuration.selectedItemColor forState:UIControlStateNormal];
//            lastButton.titleLabel.font = self.configuration.selectedItemFont;
//
//            currentButton.selected = NO;
//            [currentButton setTitleColor:self.configuration.normalItemColor forState:UIControlStateNormal];
//            currentButton.titleLabel.font = self.configuration.itemFont;
//
//        }
//    }

    if (progress > 0.5) {
        lastButton.titleLabel.font = self.configuration.itemFont;
        currentButton.titleLabel.font = self.configuration.selectedItemFont;
    }
    else if (progress < 0.5 && progress > 0){
        lastButton.titleLabel.font = self.configuration.selectedItemFont;
        currentButton.titleLabel.font = self.configuration.itemFont;
    }
    
    CGFloat xDistance = 0;
    CGFloat wDistance = 0;
    if (!self.configuration.scrollMenu &&
        !self.configuration.aligmentModeCenter &&
        self.configuration.lineWidthEqualFontWidth) {
        xDistance = currentButton.titleLabel.zxg_x + currentButton.zxg_x -( lastButton.titleLabel.zxg_x + lastButton.zxg_x );

        wDistance = currentButton.titleLabel.zxg_width - lastButton.titleLabel.zxg_width;
    }
    else {
        xDistance = currentButton.zxg_x - lastButton.zxg_x;
        wDistance = currentButton.zxg_width - lastButton.zxg_width;
    }

    /// 线条
    if (self.configuration.showScrollLine) {

        if (!self.configuration.scrollMenu &&
            !self.configuration.aligmentModeCenter &&
            self.configuration.lineWidthEqualFontWidth) { /// 处理Line宽度等于字体宽度
            
            self.lineView.zxg_x = lastButton.zxg_x + ([lastButton zxg_width]  - ([self.itemsWidthM[[lastButton.accessibilityIdentifier integerValue]] floatValue])) / 2 - self.configuration.lineLeftAndRightAddWidth + xDistance *progress;
            self.lineView.zxg_width = [self.itemsWidthM[[lastButton.accessibilityIdentifier integerValue]] floatValue] + self.configuration.lineLeftAndRightAddWidth *2 + wDistance *progress;

        }
        else {
            self.lineView.zxg_x = lastButton.zxg_x + xDistance * progress - self.configuration.lineLeftAndRightAddWidth + self.configuration.lineLeftAndRightMargin;
            self.lineView.zxg_width = lastButton.zxg_width + wDistance * progress + self.configuration.lineLeftAndRightAddWidth * 2 - 2 * self.configuration.lineLeftAndRightMargin;
        }
    }
    
//    /// 遮盖
//    if (self.configuration.showConver) {
//        self.converView.zxg_x = lastButton.zxg_x + xDistance *progress - kYNPageScrollMenuViewConverMarginX;
//        self.converView.zxg_width = lastButton.zxg_width  + wDistance *progress + kYNPageScrollMenuViewConverMarginW;
//
//        if (!self.configuration.scrollMenu &&
//            !self.configuration.aligmentModeCenter &&
//            self.configuration.lineWidthEqualFontWidth) { /// 处理cover宽度等于字体宽度
//            self.converView.zxg_x = lastButton.zxg_x + ([lastButton zxg_width]  - ([self.itemsWidthArraM[lastButton.tag] floatValue])) / 2 -  kYNPageScrollMenuViewConverMarginX + xDistance *progress;
//            self.converView.zxg_width = [self.itemsWidthArraM[lastButton.tag] floatValue] + kYNPageScrollMenuViewConverMarginW + wDistance *progress;
//        }
//
//    }
}


#pragma mark - CreateView
- (void)createSubViews {
    
    self.backgroundColor = self.configuration.menuViewBackgroundColor;
    
    [self setupItems];
    [self setupOtherViews];
}

- (void)setupItems {
    
    if (self.configuration.buttonArray.count > 0 && self.titles.count == self.configuration.buttonArray.count) {
        [self.configuration.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull itemButton, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setupButton:itemButton title:self.titles[idx] idx:idx];
        }];
    }
    else {
        [self.titles enumerateObjectsUsingBlock:^(NSString *_Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupButton:itemButton title:title idx:idx];
        }];
    }
    
}

- (void)setupButton:(UIButton *)btn title:(NSString *)title idx:(NSInteger)idx {
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:self.configuration.selectedItemColor forState:UIControlStateSelected];
    [btn setTitleColor:self.configuration.itemColor forState:UIControlStateNormal];
    btn.titleLabel.font = self.configuration.itemFont;
    btn.accessibilityIdentifier = [@(idx) stringValue];
    
    [btn addTarget:self action:@selector(itemButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    
    [self.itemsWidthM addObject:@(btn.zxg_width)];
    [self.itemsM addObject:btn];
    [self.scrollView addSubview:btn];
    
}

/**
 内容宽度 超过了 指定宽度之后，肯定是以此往后排列的。
 内容宽度 小与 指定宽度时候：
    1.判断有没有设置内容居中，
    2.如果没设置居中的话，再判断是否能够滚动
    3.如果不能滚动的话，均分指定宽度显示。
 */
- (void)setupOtherViews {
    
    self.scrollView.frame = CGRectMake(0, 0, self.configuration.showAddButton ? self.zxg_width - self.zxg_height : self.zxg_width, self.zxg_height);
    [self addSubview:self.scrollView];
    
    if (self.configuration.showAddButton) {
        self.addButton.frame = CGRectMake(self.zxg_width - self.zxg_height, 0, self.zxg_height, self.zxg_height);
        [self addSubview:self.addButton];
    }
    
    /// item 设置frame
    __block CGFloat itemX = 0, itemY = 0, itemW = 0, itemH = self.zxg_height - self.configuration.lineHeight;
    
    [self.itemsM enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            itemX += self.configuration.itemLeftAndRightMargin;
        }
        else {
            itemX += self.configuration.itemMargin + [self.itemsWidthM[idx - 1] floatValue];
        }
        button.frame = CGRectMake(itemX, itemY, [self.itemsWidthM[idx] floatValue], itemH);
    }];
    
    CGFloat scrollSizeWidth = self.configuration.itemLeftAndRightMargin + CGRectGetMaxX([self.itemsM lastObject].frame);
    if (scrollSizeWidth < self.scrollView.zxg_width) {// 不超出屏幕宽度
        itemX = 0;
        itemY = 0;
        itemW = 0;
        
        CGFloat left = 0;
        for (NSNumber *width in self.itemsWidthM) {
            left += [width floatValue];
        }
        left = (self.scrollView.zxg_width - left - self.configuration.itemMargin * (self.itemsWidthM.count - 1)) * 0.5;
        
        /// 居中且有剩余间距
        if (self.configuration.aligmentModeCenter && left >= 0) {
            [self.itemsM enumerateObjectsUsingBlock:^(UIButton  * button, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == 0) {
                    itemX += left;
                }
                else {
                    itemX += self.configuration.itemMargin + [self.itemsWidthM[idx - 1] floatValue];
                }
                
                button.frame = CGRectMake(itemX, itemY, [self.itemsWidthM[idx] floatValue], itemH);
            }];
            
            self.scrollView.contentSize = CGSizeMake(left + CGRectGetMaxX([[self.itemsM lastObject] frame]), self.scrollView.zxg_height);
            
        }
        else { /// 否则按原来样子
            /// 不能滚动则平分
            if (!self.configuration.scrollMenu) {
                [self.itemsM enumerateObjectsUsingBlock:^(UIButton * button, NSUInteger idx, BOOL * _Nonnull stop) {
                    itemW = self.scrollView.zxg_width / self.itemsM.count;
                    itemX = itemW *idx;
                    button.frame = CGRectMake(itemX, itemY, itemW, itemH);
                }];
                
                self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([[self.itemsM lastObject] frame]), self.scrollView.zxg_height);
                
            }
            else {
                self.scrollView.contentSize = CGSizeMake(scrollSizeWidth, self.scrollView.zxg_height);
            }
        }
    }
    else { /// 大于scrollView的width.
        self.scrollView.contentSize = CGSizeMake(scrollSizeWidth, self.scrollView.zxg_height);
    }
    
    
    CGFloat lineX = [[self.itemsM firstObject] zxg_x];
    CGFloat lineY = self.scrollView.zxg_height - self.configuration.lineHeight;
    CGFloat lineW = [[self.itemsM firstObject] zxg_width];
    CGFloat lineH = self.configuration.lineHeight;
    
    if (!self.configuration.scrollMenu &&
        !self.configuration.aligmentModeCenter &&
        self.configuration.lineWidthEqualFontWidth) { ///处理Line宽度等于字体宽度
        lineX = [[self.itemsM firstObject] zxg_x] + ([[self.itemsM firstObject] zxg_width]  - ([self.itemsWidthM.firstObject floatValue])) / 2;
        lineW = [self.itemsWidthM.firstObject floatValue];
    }
    
    /// cover
    if (self.configuration.showCover) {
//        self.converView.frame = CGRectMake(lineX - kYNPageScrollMenuViewConverMarginX, (self.scrollView.zxg_height - self.configuration.coverHeight - self.configuration.lineHeight) * 0.5, lineW + kYNPageScrollMenuViewConverMarginW, self.configuration.coverHeight);
//        [self.scrollView insertSubview:self.converView atIndex:0];
    }
    
    /// bottomline
    if (self.configuration.showBottomLine) {
        self.bottomLine.frame = CGRectMake(self.configuration.bottomLineLeftAndRightMargin, self.zxg_height - self.configuration.bottomLineHeight, self.scrollView.zxg_width - 2 * self.configuration.bottomLineLeftAndRightMargin, self.configuration.bottomLineHeight);
        self.bottomLine.layer.cornerRadius = self.configuration.bottomLineCorner;
        [self insertSubview:self.bottomLine atIndex:0];
    }
    
    if (self.configuration.showScrollLine) {
        self.lineView.frame = CGRectMake(lineX - self.configuration.lineLeftAndRightAddWidth + self.configuration.lineLeftAndRightMargin, lineY - self.configuration.lineBottomMargin, lineW + self.configuration.lineLeftAndRightAddWidth * 2 - 2 * self.configuration.lineLeftAndRightMargin, lineH);
        self.lineView.layer.cornerRadius = self.configuration.lineCorner;
        [self.scrollView addSubview:self.lineView];
    }
    
    if (self.configuration.itemMaxScale > 1) {
        self.itemsM[self.currentIndex].transform = CGAffineTransformMakeScale(self.configuration.itemMaxScale, self.configuration.itemMaxScale);
    }
    
    [self setDefaultTheme];
    
    [self selectedItemIndex:self.currentIndex animated:NO];
    
}

- (void)setDefaultTheme {
    
    UIButton *currentButton = self.itemsM[self.currentIndex];
    
    /// 缩放
    if (self.configuration.itemMaxScale > 1) {
        currentButton.transform = CGAffineTransformMakeScale(self.configuration.itemMaxScale, self.configuration.itemMaxScale);
    }
    
    /// 颜色
    currentButton.selected = YES;
    currentButton.titleLabel.font = self.configuration.selectedItemFont;
    
    /// 线条
    if (self.configuration.showScrollLine) {
        
        self.lineView.zxg_x = currentButton.zxg_x - self.configuration.lineLeftAndRightAddWidth + self.configuration.lineLeftAndRightMargin;
        self.lineView.zxg_width = currentButton.zxg_width + self.configuration.lineLeftAndRightAddWidth *2 - self.configuration.lineLeftAndRightMargin * 2;
        
        if (!self.configuration.scrollMenu &&
            !self.configuration.aligmentModeCenter &&
            self.configuration.lineWidthEqualFontWidth) { /// 处理Line宽度等于字体宽度
            self.lineView.zxg_x = currentButton.zxg_x + ([currentButton zxg_width]  - ([self.itemsWidthM[[[currentButton accessibilityIdentifier] integerValue]] floatValue])) / 2 - self.configuration.lineLeftAndRightAddWidth - self.configuration.lineLeftAndRightAddWidth;
            self.lineView.zxg_width = [self.itemsWidthM[[currentButton.accessibilityIdentifier integerValue]] floatValue] + self.configuration.lineLeftAndRightAddWidth * 2;
        }
    }
    
    /// 遮盖
    if (self.configuration.showCover) {
//        self.converView.zxg_x = currentButton.zxg_x - kYNPageScrollMenuViewConverMarginX;
//        self.converView.zxg_width = currentButton.zxg_width +kYNPageScrollMenuViewConverMarginW;
//
//        if (!self.configuration.scrollMenu &&
//            !self.configuration.aligmentModeCenter &&
//            self.configuration.lineWidthEqualFontWidth) { ///处理conver宽度等于字体宽度
//
//            self.converView.zxg_x = currentButton.zxg_x + ([currentButton zxg_width]  - ([self.itemsWidthArraM[currentButton.tag] floatValue])) / 2 - kYNPageScrollMenuViewConverMarginX;
//            self.converView.zxg_width = [self.itemsWidthArraM[currentButton.tag] floatValue] + kYNPageScrollMenuViewConverMarginW;
//        }
    }
    
    self.lastIndex = self.currentIndex;
}

- (void)selectedItemIndex:(NSInteger)index
                 animated:(BOOL)animated {
    
    self.currentIndex = index;
    
    [self adjustItemAnimate:animated];
}

- (void)adjustItemWithAnimated:(BOOL)animated {
    if (self.lastIndex == self.currentIndex) return;

    [self adjustItemAnimate:animated];
}

// 0.首先是选中动画。
- (void)adjustItemAnimate:(BOOL)animated {
    
    UIButton *lastButton = self.itemsM[self.lastIndex];
    UIButton *currentButton = self.itemsM[self.currentIndex];
    
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        /// 缩放
        if (self.configuration.itemMaxScale > 1) {
            lastButton.transform = CGAffineTransformIdentity;
            currentButton.transform = CGAffineTransformMakeScale(self.configuration.itemMaxScale, self.configuration.itemMaxScale);
        }
        
        /// 颜色
        [self.itemsM enumerateObjectsUsingBlock:^(UIButton  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = NO;
            obj.titleLabel.font = self.configuration.itemFont;
            if (idx == self.itemsM.count - 1) {
                currentButton.selected = YES;
                currentButton.titleLabel.font = self.configuration.selectedItemFont;
            }
        }];
        
        /// 线条
        if (self.configuration.showScrollLine) {
            self.lineView.zxg_x = currentButton.zxg_x - self.configuration.lineLeftAndRightAddWidth + self.configuration.lineLeftAndRightMargin;
            self.lineView.zxg_width = currentButton.zxg_width + self.configuration.lineLeftAndRightAddWidth * 2 - 2 * self.configuration.lineLeftAndRightMargin;
            
            if (!self.configuration.scrollMenu &&
                !self.configuration.aligmentModeCenter &&
                self.configuration.lineWidthEqualFontWidth) {//处理Line宽度等于字体宽度
                
                self.lineView.zxg_x = currentButton.zxg_x + ([currentButton zxg_width]  - ([self.itemsWidthM[[currentButton.accessibilityIdentifier integerValue]] floatValue])) / 2 - self.configuration.lineLeftAndRightAddWidth;;
                self.lineView.zxg_width = [self.itemsWidthM[currentButton.tag] floatValue] + self.configuration.lineLeftAndRightAddWidth * 2;
            }
            
        }
        
        /// 遮盖
        if (self.configuration.showCover) {
//            self.converView.zxg_x = currentButton.zxg_x - kYNPageScrollMenuViewConverMarginX;
//            self.converView.zxg_width = currentButton.zxg_width +kYNPageScrollMenuViewConverMarginW;
//
//            if (!self.configuration.scrollMenu&&!self.configuration.aligmentModeCenter&&self.configuration.lineWidthEqualFontWidth) { /// 处理conver宽度等于字体宽度
//
//                self.converView.zxg_x = currentButton.zxg_x + ([currentButton zxg_width]  - ([self.itemsWidthArraM[currentButton.tag] floatValue])) / 2  - kYNPageScrollMenuViewConverMarginX;
//                self.converView.zxg_width = [self.itemsWidthArraM[currentButton.tag] floatValue] +kYNPageScrollMenuViewConverMarginW;
//            }
        }
        
        self.lastIndex = self.currentIndex;
        
        
    } completion:^(BOOL finished) {
        [self adjustItemPositionWithCurrentIndex:self.currentIndex];
    }];
    
    
}

// 0.然后是居中动画。
- (void)adjustItemPositionWithCurrentIndex:(NSInteger)index {
    
    if (self.scrollView.contentSize.width != self.scrollView.zxg_width + 20) {
        
        UIButton *button = self.itemsM[index];
        
        CGFloat offSex = button.center.x - self.scrollView.zxg_width * 0.5;
        
        offSex = offSex > 0 ? offSex : 0;
        
        CGFloat maxOffSetX = self.scrollView.contentSize.width - self.scrollView.zxg_width;
        
        maxOffSetX = maxOffSetX > 0 ? maxOffSetX : 0;
        
        offSex = offSex > maxOffSetX ? maxOffSetX : offSex;
        
        [self.scrollView setContentOffset:CGPointMake(offSex, 0) animated:YES];
        
    }
}

#pragma mark - Button Event
- (void)itemButtonOnClick:(UIButton *)button {
    
    self.currentIndex = [button.accessibilityIdentifier integerValue];
    
    [self adjustItemWithAnimated:YES];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(menuViewItemOnClick:index:)]) {
        [self.delegate menuViewItemOnClick:button index:self.lastIndex];
    }
    
}

- (void)addButtonAction:(UIButton *)button {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(menuViewAddButtonAction:)]){
        [self.delegate menuViewAddButtonAction:button];
    }
}

#pragma mark - Lazy Method

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = self.configuration.lineColor;
        _lineView.layer.masksToBounds = YES;
    }
    return _lineView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = self.configuration.bottomLineColor;
        _bottomLine.layer.masksToBounds = YES;
    }
    return _bottomLine;
}

- (UIView *)converView {
    if (!_converView) {
        _converView = [[UIView alloc] init];
        _converView.layer.backgroundColor = self.configuration.coverColor.CGColor;
        _converView.layer.cornerRadius = self.configuration.coverCornerRadius;
        _converView.layer.masksToBounds = YES;
        _converView.userInteractionEnabled = NO;
    }
    return _converView;
    
}

- (ZXGPageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[ZXGPageScrollView alloc] init];
        _scrollView.bounces = self.configuration.bounces;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = self.configuration.scrollMenu;
    }
    return _scrollView;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_addButton setBackgroundImage:[UIImage imageNamed:self.configuration.addButtonNormalImageName] forState:UIControlStateNormal];
//        [_addButton setBackgroundImage:[UIImage imageNamed:self.configuration.addButtonHightImageName] forState:UIControlStateHighlighted];
        _addButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _addButton.layer.shadowOffset = CGSizeMake(-1, 0);
        _addButton.layer.shadowOpacity = 0.5;
//        _addButton.backgroundColor = self.configuration.addButtonBackgroundColor;
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
