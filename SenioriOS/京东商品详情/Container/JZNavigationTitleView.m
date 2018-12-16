//
//  JZNavigationTitleView.m
//  onzxgway
//
//  Created by zxg on 2018/11/29.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "JZNavigationTitleView.h"

static const CGFloat kItemHeight = 44.f;
static const CGFloat kItemWidth = 40.f;
static const CGFloat kItemMargin = 20.f;

@interface JZNavigationTitleView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;
@property (nonatomic) NSInteger preSelectedIndex;
@property (nonatomic, strong) UILabel *indicatorLabel;

@end

@implementation JZNavigationTitleView

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentSize = CGSizeMake(frame.size.width, 2 * frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
//        self.scrollEnabled = NO;
        self.preSelectedIndex = -1;
        self.pagingEnabled = YES;
    }
    return self;
}

#pragma mark - setter
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    CGFloat itemW = 0;
    CGFloat itemH = 0;
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        itemW = kItemWidth;
        itemH = kItemHeight;
        self.bounds = CGRectMake(0, 0, itemW * _titles.count + (_titles.count - 1) * kItemMargin, itemH);
        self.contentSize = CGSizeMake(self.bounds.size.width, 2 * self.bounds.size.height);
    }
    else {
        itemW = (CGRectGetWidth(self.frame) - (_titles.count - 1) * kItemMargin) / _titles.count;
        itemH = CGRectGetHeight(self.frame);
    }
    
    
    for (NSInteger i = 0; i < _titles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (itemW + kItemMargin), 0.f, itemW, itemH);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.accessibilityValue = [NSString stringWithFormat:@"%ld", (long)i];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:btn];
        [self.btns addObject:btn];
        
        // 添加黑色指示线
        if (i == 0) {
            [self addSubview:self.indicatorLabel];
            self.indicatorLabel.frame = ({
                CGRect frame = btn.frame;
                frame.origin.y = frame.size.height - 2.f;
                frame.size.height = 2.f;
                frame.size.width = [btn.titleLabel sizeThatFits:CGSizeZero].width;
                frame;
            });
            [self selectedItem:0];
        }
    }
    
    // 图文详情
    UIView *bgTitleView = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.indicatorLabel.frame), CGRectGetWidth(self.frame), itemH)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:bgTitleView.bounds];
    titleLabel.text = @"图文详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgTitleView addSubview:titleLabel];
    [self addSubview:bgTitleView];
    
}

#pragma mark - apis
//- (void)scrollToPercent:(CGFloat)percent {

//    NSInteger index = floor(percent);
//    
//    if (index >= _titles.count - 1) return;
//    
//    UIButton *curB = [self.btns objectAtIndex:index];
//    UIButton *nextB = [self.btns objectAtIndex:index + 1];
//    CGFloat marginH = CGRectGetMidX(curB.frame) - CGRectGetMidX(nextB.frame);
//    
//    self.indicatorLabel.transform = CGAffineTransformMakeTranslation(-marginH * (percent - index), 0.f);
//}

#pragma mark - private
- (void)selectedItem:(NSInteger)index {
    
    if (self.btns.count <= index || index < 0) return;
    
    UIButton *selectedBtn = [self.btns objectAtIndex:index];
    selectedBtn.selected = YES;
    selectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:selectedBtn.titleLabel.font.pointSize];
    
    if (self.preSelectedIndex >= 0) {
        UIButton *preSelectedBtn = [self.btns objectAtIndex:self.preSelectedIndex];
        if (preSelectedBtn != selectedBtn) {
            preSelectedBtn.selected = NO;
            preSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:selectedBtn.titleLabel.font.pointSize];
        }
    }
    
    self.preSelectedIndex = index;
    
    CGPoint fr = selectedBtn.center;
    CGFloat w = self.indicatorLabel.bounds.size.width;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorLabel.transform = CGAffineTransformMakeTranslation(fr.x - w * 0.5, 0.f);
    }];
    
}

#pragma mark - event
- (void)btnAction:(UIButton *)btn {
    
    NSInteger index = btn.accessibilityValue.integerValue;
    [self selectedItem:index];
    
    if (_itemClickedCallback) {
        _itemClickedCallback(index);
    }
    
}

#pragma mark - getter
- (UILabel *)indicatorLabel {
    if (!_indicatorLabel) {
        _indicatorLabel = [[UILabel alloc] init];
        _indicatorLabel.backgroundColor = [UIColor redColor];
    }
    return _indicatorLabel;
}

- (NSMutableArray<UIButton *> *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
