//
//  DemoController.m
//  京东商品详情
//
//  Created by 朱献国 on 2018/12/3.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "DemoController.h"

#define kYNPAGE_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define kYNPAGE_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface DemoController ()

@property (nonatomic, strong) UIScrollView *pageScrollView;

/// 一个HeaderView的背景View
@property (nonatomic, strong) UIScrollView *headerBgView;

/// 上次偏移的位置
@property (nonatomic, assign) CGFloat lastPositionX;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupHeaderBgView];
    [self setupPageScrollView];
    [self setSelectedPageIndex:2];
}

/// 初始化背景headerView
- (void)setupHeaderBgView {
    
        self.headerBgView = [[UIScrollView alloc] initWithFrame:self.headerView.bounds];
        self.headerBgView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * 2, self.headerView.bounds.size.height);
        [self.headerBgView addSubview:self.headerView];
    
//        self.headerViewOriginHeight = self.headerBgView.bounds.size.height;
//        self.headerBgView.scrollEnabled = !self.config.headerViewCouldScrollPage;
    
//        if (self.config.headerViewCouldScale && self.scaleBackgroundView) {
//            [self.headerBgView insertSubview:self.scaleBackgroundView atIndex:0];
//            self.scaleBackgroundView.userInteractionEnabled = NO;
//        }
//        self.config.tempTopHeight = self.headerBgView.yn_height + self.config.menuHeight;
//
//        _insetTop = self.headerBgView.yn_height + self.config.menuHeight;
//
//        _scrollMenuViewOriginY = _headerView.yn_height;
//
//        if ([self isSuspensionTopPauseStyle]) {
//            _insetTop = self.headerBgView.yn_height - self.config.suspenOffsetY;
//            [self.bgScrollView addSubview:self.headerBgView];
//        }
}

/// 初始化PageScrollView
- (void)setupPageScrollView {
    
    CGFloat contentHeight = kYNPAGE_SCREEN_HEIGHT;
    self.pageScrollView.frame = CGRectMake(0, 0, kYNPAGE_SCREEN_WIDTH, contentHeight);
    self.pageScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * 5, contentHeight);
    [self.view addSubview:self.pageScrollView];

}

- (void)setSelectedPageIndex:(NSInteger)pageIndex {
    
    CGRect frame = CGRectMake(self.pageScrollView.bounds.size.width * pageIndex, 0, self.pageScrollView.bounds.size.width, self.pageScrollView.bounds.size.height);
    if (frame.origin.x == self.pageScrollView.contentOffset.x) {
        [self scrollViewDidScroll:self.pageScrollView];
    }
    else {
        [self.pageScrollView scrollRectToVisible:frame animated:NO];
    }
    
    [self scrollViewDidEndDecelerating:self.pageScrollView];
    
}

/// scrollView滚动ing
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (scrollView == self.bgScrollView) {
//        [self calcuSuspendTopPauseWithBgScrollView:scrollView];
//        [self invokeDelegateForScrollWithOffsetY:scrollView.contentOffset.y];
//        return;
//    }
    
    CGFloat currentPostion = scrollView.contentOffset.x;
    
    CGFloat offsetX = currentPostion / kYNPAGE_SCREEN_WIDTH;
    
    CGFloat offX = currentPostion > self.lastPositionX ? ceilf(offsetX) : offsetX;
    
//    [self replaceHeaderViewFromTableView];
//
//    [self initViewControllerWithIndex:offX];
    
    CGFloat progress = offsetX - (NSInteger)offsetX;
    
    self.lastPositionX = currentPostion;
    
//    [self.scrollMenuView adjustItemWithProgress:progress lastIndex:floor(offsetX) currentIndex:ceilf(offsetX)];
    
    if (floor(offsetX) == ceilf(offsetX)) {
//        [self.scrollMenuView adjustItemAnimate:YES];
    }
    
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didScroll:progress:formIndex:toIndex:)]) {
    //        [self.delegate pageViewController:self didScroll:scrollView progress:progress formIndex:floor(offsetX) toIndex:ceilf(offsetX)];
    //    }
    
}

/// scrollView滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    if (scrollView == self.bgScrollView) return;
//    if ([self isSuspensionTopPauseStyle]) {
//        self.currentScrollView.scrollEnabled = YES;
//    }
//    [self replaceHeaderViewFromView];
//    [self removeViewController];
//    [self.scrollMenuView adjustItemPositionWithCurrentIndex:self.pageIndex];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didEndDecelerating:)]) {
//        [self.delegate pageViewController:self didEndDecelerating:scrollView];
//    }
}

- (UIScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] init];
        _pageScrollView.showsVerticalScrollIndicator = YES;
        _pageScrollView.showsHorizontalScrollIndicator = YES;
        _pageScrollView.scrollEnabled = YES;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.bounces = NO;
        _pageScrollView.delegate = self;
        _pageScrollView.backgroundColor = [UIColor blueColor];
        if (@available(iOS 11.0, *)) {
            _pageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _pageScrollView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kYNPAGE_SCREEN_WIDTH, 200.f)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}


@end
