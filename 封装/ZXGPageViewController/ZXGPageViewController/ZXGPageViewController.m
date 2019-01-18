//
//  ZXGPageViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGPageViewController.h"
#import "ZXGPageScrollView.h"
#import "UIView+ZXGPageExtend.h"

@interface ZXGPageViewController () <UIScrollViewDelegate>

/// 页面ScrollView
@property (nonatomic, strong) ZXGPageScrollView *pageScrollView;
/// 展示控制器的字典
@property (nonatomic, strong) NSMutableDictionary *displayDictM;
/// 字典控制器的缓存
@property (nonatomic, strong) NSMutableDictionary *cacheDictM;
/// 当前显示的页面
@property (nonatomic, strong) UIScrollView *currentScrollView;
/// 当前控制器
@property (nonatomic, strong) UIViewController *currentViewController;
/// 上次偏移的位置
@property (nonatomic) CGFloat lastPositionX;

@end

@implementation ZXGPageViewController

#pragma mark - Override
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initPageViewControllerWithControllers:@[] titles:@[] config:[ZXGPageConfigration defaultConfig]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initPageViewControllerWithControllers:@[] titles:@[] config:[ZXGPageConfigration defaultConfig]];
}

#pragma mark - Initialize Method

/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray *)controllers
                                           titles:(NSArray *)titles
                                           config:(ZXGPageConfigration *)config {
    
    return [[self alloc] initPageViewControllerWithControllers:controllers
                                                        titles:titles
                                                        config:config];
}

- (instancetype)initPageViewControllerWithControllers:(NSArray *)controllers
                                               titles:(NSArray *)titles
                                               config:(ZXGPageConfigration *)config {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controllersM = controllers.mutableCopy;
        _titlesM = titles.mutableCopy;
        _config = config ?: [ZXGPageConfigration defaultConfig];
        
        _displayDictM = @{}.mutableCopy;
        _cacheDictM = @{}.mutableCopy;
//        self.originInsetBottomDictM = @{}.mutableCopy;
//        self.scrollViewCacheDictionryM = @{}.mutableCopy;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupSubViews];
    [self setSelectedPageIndex:self.pageIndex];
}

#pragma mark - Private Method

- (void)initData {
    
    [self checkParams];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    _headerViewInTableView = YES;
    
}

/// 初始化子View
- (void)setupSubViews {
    
//    [self setupHeaderBgView];
    [self setupPageScrollMenuView];
    [self setupPageScrollView];
}

/// 初始化PageScrollView
- (void)setupPageScrollView {
    
    CGFloat navHeight = self.config.showNavigation ? kZXGPAGE_NAVHEIGHT : 0;
    CGFloat tabHeight = self.config.showTabbar ? kZXGPAGE_TABBARHEIGHT : 0;
    CGFloat cutOutHeight = MAX(self.config.cutOutHeight, 0.f);
    CGFloat contentHeight = ZXGPAGE_SCREEN_HEIGHT - navHeight - tabHeight - cutOutHeight;

//    if ([self isSuspensionTopPauseStyle]) {
//        self.bgScrollView.frame = CGRectMake(0, 0, kYNPAGE_SCREEN_WIDTH, contentHeight);
//        self.bgScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH, contentHeight + self.headerBgView.yn_height - self.config.suspenOffsetY);
//
//        self.scrollMenuView.yn_y = self.headerBgView.yn_bottom;
//
//        self.pageScrollView.frame = CGRectMake(0, self.scrollMenuView.yn_bottom, kYNPAGE_SCREEN_WIDTH, contentHeight - self.config.menuHeight  - self.config.suspenOffsetY);
//
//        self.pageScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * self.controllersM.count, self.pageScrollView.yn_height);
//
//        self.config.contentHeight = self.pageScrollView.yn_height;
//
//        [self.bgScrollView addSubview:self.pageScrollView];
//        if (kLESS_THAN_iOS11) {
//            [self.view addSubview:[UIView new]];
//        }
//        [self.view addSubview:self.bgScrollView];
//
//    } else {
    
        self.pageScrollView.frame = CGRectMake(0, [self isTopStyle] ? self.config.menuHeight : 0, ZXGPAGE_SCREEN_WIDTH, ([self isTopStyle] ? contentHeight - self.config.menuHeight : contentHeight));
        
        self.pageScrollView.contentSize = CGSizeMake(ZXGPAGE_SCREEN_WIDTH * self.controllersM.count, contentHeight - ([self isTopStyle] ? self.config.menuHeight : 0));
        
        self.config.contentHeight = self.pageScrollView.zxg_height - self.config.menuHeight;
//        if (kLESS_THAN_iOS11) {
//            [self.view addSubview:[UIView new]];
//        }
        [self.view addSubview:self.pageScrollView];
//    }
}

/// 初始化PageScrollMenuView
- (void)setupPageScrollMenuView {
    CGRect frame = CGRectMake(0, 0, self.config.menuWidth, self.config.menuHeight);
    
    ZXGPageScrollMenuView *scrollMenuView = [[ZXGPageScrollMenuView alloc] initWithFrame:frame titles:self.titlesM configration:self.config delegate:self currentIndex:self.pageIndex];
    self.scrollMenuView = scrollMenuView;
    
    switch (self.config.pageStyle) {
        case ZXGPageStyleTop:
        case ZXGPageStyleSuspensionTop:
        case ZXGPageStyleSuspensionCenter:
        {
            [self.view addSubview:self.scrollMenuView];
        }
            break;
        case ZXGPageStyleNavigation:
        {
            UIViewController *vc;
            if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
                vc = self;
            } else {
                vc = self.parentViewController;
            }
            vc.navigationItem.titleView = self.scrollMenuView;
        }
            break;
        case ZXGPageStyleSuspensionTopPause:
        {
//            [self.bgScrollView addSubview:self.scrollMenuView];
        }
            break;
    }
}

///// 初始化背景headerView
//- (void)setupHeaderBgView {
//    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle] || [self isSuspensionTopPauseStyle]) {
//#if DEBUG
//        NSAssert(self.headerView, @"Please set headerView !");
//#endif
//        self.headerBgView = [[YNPageHeaderScrollView alloc] initWithFrame:self.headerView.bounds];
//        self.headerBgView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * 2, self.headerView.yn_height);
//        [self.headerBgView addSubview:self.headerView];
//        self.headerViewOriginHeight = self.headerBgView.yn_height;
//        self.headerBgView.scrollEnabled = !self.config.headerViewCouldScrollPage;
//
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
//    }
//}

#pragma mark - Public Method
- (void)setSelectedPageIndex:(NSInteger)pageIndex {
    
    if (self.cacheDictM.count > 0 && pageIndex == self.pageIndex) return;
    
    if (pageIndex > self.controllersM.count - 1) return;
    
    CGRect frame = CGRectMake(self.pageScrollView.zxg_width * pageIndex, 0, self.pageScrollView.zxg_width, self.pageScrollView.zxg_height);
    if (frame.origin.x == self.pageScrollView.contentOffset.x) {
        [self scrollViewDidScroll:self.pageScrollView];
    }
    else {
        [self.pageScrollView scrollRectToVisible:frame animated:NO];
    }
    
    [self scrollViewDidEndDecelerating:self.pageScrollView];
    
}

/// 检查参数
- (void)checkParams {
#if DEBUG
    NSAssert(self.controllersM.count != 0 || self.controllersM, @"ViewControllers`count is 0 or nil");
    
    NSAssert(self.titlesM.count != 0 || self.titlesM, @"TitleArray`count is 0 or nil,");
    
    NSAssert(self.controllersM.count == self.titlesM.count, @"ViewControllers`count is not equal titleArray!");
#endif
    
    if (![self respondsToCustomCachekey]) {
        BOOL isHasNotEqualTitle = YES;
        for (int i = 0; i < self.titlesM.count; i++) {
            for (int j = i + 1; j < self.titlesM.count; j++) {
                if (i != j && [self.titlesM[i] isEqualToString:self.titlesM[j]]) {
                    isHasNotEqualTitle = NO;
                    break;
                }
            }
        }
#if DEBUG
        NSAssert(isHasNotEqualTitle, @"TitleArray Not allow equal title.");
#endif
    }
}

- (BOOL)respondsToCustomCachekey {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewController:customCacheKeyForIndex:)]) {
        return YES;
    }
    return NO;
}


#pragma mark - Lazy Load

//- (YNPageScrollView *)bgScrollView {
//    if (!_bgScrollView) {
//        _bgScrollView = [[YNPageScrollView alloc] init];
//        _bgScrollView.showsVerticalScrollIndicator = NO;
//        _bgScrollView.showsHorizontalScrollIndicator = NO;
//        _bgScrollView.delegate = self;
//        _bgScrollView.backgroundColor = [UIColor whiteColor];
//        if (@available(iOS 11.0, *)) {
//            _bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//    }
//    return _bgScrollView;
//}

- (ZXGPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[ZXGPageScrollView alloc] init];
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
//        _pageScrollView.scrollEnabled = self.config.pageScrollEnabled;
        _pageScrollView.pagingEnabled = YES;
//        _pageScrollView.bounces = NO;
        _pageScrollView.delegate = self;
        _pageScrollView.backgroundColor = [UIColor blueColor];
        if (@available(iOS 11.0, *)) {
            _pageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _pageScrollView;
}

#pragma mark - 样式取值
- (BOOL)isTopStyle {
    return self.config.pageStyle == ZXGPageStyleTop;
}

- (NSString *)titleWithIndex:(NSInteger)index {
    return self.titlesM[index];
}

- (NSInteger)getPageIndexWithTitle:(NSString *)title {
    return [self.titlesM indexOfObject:title];
}

- (NSString *)getKeyWithTitle:(NSString *)title {
    if ([self respondsToCustomCachekey]) {
        NSString *ID = [self.dataSource pageViewController:self customCacheKeyForIndex:self.pageIndex];
        return ID;
    }
    return title;
};

#pragma mark - UIScrollViewDelegate
/// scrollView滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    if (scrollView == self.bgScrollView) return;
    
//    if ([self isSuspensionTopPauseStyle]) {
//        self.currentScrollView.scrollEnabled = YES;
//    }
    [self replaceHeaderViewFromView];
    [self removeViewController];
//    [self.scrollMenuView adjustItemPositionWithCurrentIndex:self.pageIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didEndDecelerating:)]) {
        [self.delegate pageViewController:self didEndDecelerating:scrollView];
    }
}

/// scrollView滚动ing
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (scrollView == self.bgScrollView) {
//        [self calcuSuspendTopPauseWithBgScrollView:scrollView];
//        [self invokeDelegateForScrollWithOffsetY:scrollView.contentOffset.y];
//        return;
//    }
    
    CGFloat currentPostion = scrollView.contentOffset.x;
    
    CGFloat offsetX = currentPostion / ZXGPAGE_SCREEN_WIDTH;
    
    CGFloat offX = currentPostion > self.lastPositionX ? ceilf(offsetX) : offsetX;
    
    [self replaceHeaderViewFromTableView];
    
    [self initViewControllerWithIndex:offX];
    
    CGFloat progress = offsetX - (NSInteger)offsetX;
    
    self.lastPositionX = currentPostion;
    
    [self.scrollMenuView adjustItemWithProgress:progress lastIndex:floor(offsetX) currentIndex:ceilf(offsetX)];
    
    if (floor(offsetX) == ceilf(offsetX)) {
        [self.scrollMenuView adjustItemAnimate:YES];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didScroll:progress:formIndex:toIndex:)]) {
        [self.delegate pageViewController:self didScroll:scrollView progress:progress formIndex:floor(offsetX) toIndex:ceilf(offsetX)];
    }
}

/// 将headerView 从 view 上 放置 tableview 上
- (void)replaceHeaderViewFromView {
//    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
//        if (!_headerViewInTableView) {
//
//            UIScrollView *scrollView = self.currentScrollView;
//
//            CGFloat headerViewY = [self.headerBgView.superview convertRect:self.headerBgView.frame toView:scrollView].origin.y;
//            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:scrollView].origin.y;
//
//            [self.headerBgView removeFromSuperview];
//            [self.scrollMenuView removeFromSuperview];
//
//            self.headerBgView.yn_y = headerViewY;
//            self.scrollMenuView.yn_y = scrollMenuViewY;
//
//            [scrollView addSubview:self.headerBgView];
//            [scrollView addSubview:self.scrollMenuView];
//
//            _headerViewInTableView = YES;
//        }
//    }
}

/// 将headerView 从 tableview 上 放置 view 上
- (void)replaceHeaderViewFromTableView {
    
//    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
//        if (_headerViewInTableView) {
//
//            CGFloat headerViewY = [self.headerBgView.superview convertRect:self.headerBgView.frame toView:self.pageScrollView].origin.y;
//            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:self.pageScrollView].origin.y;
//
//            [self.headerBgView removeFromSuperview];
//            [self.scrollMenuView removeFromSuperview];
//            self.headerBgView.yn_y = headerViewY;
//            self.scrollMenuView.yn_y = scrollMenuViewY;
//
//            [self.view insertSubview:self.headerBgView aboveSubview:self.pageScrollView];
//            [self.view insertSubview:self.scrollMenuView aboveSubview:self.headerBgView];
//
//            _headerViewInTableView = NO;
//        }
//    }
}

/// 移除缓存控制器
- (void)removeViewController {
    NSString *title = [self titleWithIndex:self.pageIndex];
    NSString *displayKey = [self getKeyWithTitle:title];
    for (NSString *key in self.displayDictM.allKeys) {
        if (![key isEqualToString:displayKey]) {
            [self removeViewControllerWithChildVC:self.displayDictM[key] key:key];
        }
    }
}

#pragma mark - 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    
    self.currentViewController = self.controllersM[index];
    
    self.pageIndex = index;
    NSString *title = [self titleWithIndex:index];
    if ([self.displayDictM objectForKey:[self getKeyWithTitle:title]]) return;
    
    UIViewController *cacheViewController = [self.cacheDictM objectForKey:[self getKeyWithTitle:title]];
    [self addViewControllerToParent:cacheViewController ?: self.controllersM[index] index:index];
    
}

/// 添加到父类控制器中
- (void)addViewControllerToParent:(UIViewController *)viewController index:(NSInteger)index {
    
    [self addChildViewController:self.controllersM[index]];
    
    viewController.view.frame = CGRectMake(ZXGPAGE_SCREEN_WIDTH * index, 0, self.pageScrollView.zxg_width, self.pageScrollView.zxg_height);
    
    [self.pageScrollView addSubview:viewController.view];
    
    NSString *title = [self titleWithIndex:index];
    
    [self.displayDictM setObject:viewController forKey:[self getKeyWithTitle:title]];
    
    UIScrollView *scrollView = self.currentScrollView;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewController:heightForScrollViewAtIndex:)]) {
        CGFloat scrollViewHeight = [self.dataSource pageViewController:self heightForScrollViewAtIndex:index];
        scrollView.frame = CGRectMake(0, 0, viewController.view.zxg_width, scrollViewHeight);
    }
    else {
        scrollView.frame = viewController.view.bounds;
    }
    
    [viewController didMoveToParentViewController:self];
    
//    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
//        
//        if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
//            CGFloat bottom = scrollView.contentInset.bottom > 2 * kDEFAULT_INSET_BOTTOM ? 0 : scrollView.contentInset.bottom;
//            [self.originInsetBottomDictM setValue:@(bottom) forKey:[self getKeyWithTitle:title]];
//            
//            /// 设置TableView内容偏移
//            scrollView.contentInset = UIEdgeInsetsMake(_insetTop, 0, scrollView.contentInset.bottom + 3 * kDEFAULT_INSET_BOTTOM, 0);
//        }
//        if ([self isSuspensionBottomStyle]) {
//            scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_insetTop, 0, 0, 0);
//        }
//        
//        if (self.cacheDictM.count == 0) {
//            /// 初次添加headerView、scrollMenuView
//            self.headerBgView.yn_y = - _insetTop;
//            self.scrollMenuView.yn_y = self.headerBgView.yn_bottom;
//            [scrollView addSubview:self.headerBgView];
//            [scrollView addSubview:self.scrollMenuView];
//            /// 设置首次偏移量置顶
//            [scrollView setContentOffset:CGPointMake(0, -_insetTop) animated:NO];
//            
//        } else {
//            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:self.view].origin.y;
//            
//            if (self.supendStatus) {
//                /// 首次已经悬浮 设置初始化 偏移量
//                if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
//                    [scrollView setContentOffset:CGPointMake(0, -self.config.menuHeight - self.config.suspenOffsetY) animated:NO];
//                } else {
//                    /// 再次悬浮 已经加载过 设置偏移量
//                    if (scrollView.contentOffset.y < -self.config.menuHeight - self.config.suspenOffsetY) {
//                        [scrollView setContentOffset:CGPointMake(0, -self.config.menuHeight - self.config.suspenOffsetY) animated:NO];
//                    }
//                }
//            } else {
//                CGFloat scrollMenuViewDeltaY = _scrollMenuViewOriginY - scrollMenuViewY;
//                scrollMenuViewDeltaY = -_insetTop +  scrollMenuViewDeltaY;
//                /// 求出偏移了多少 未悬浮 (多个ScrollView偏移量联动)
//                scrollView.contentOffset = CGPointMake(0, scrollMenuViewDeltaY);
//            }
//        }
//    }
    /// 缓存控制器
    if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
        [self.cacheDictM setObject:viewController forKey:[self getKeyWithTitle:title]];
    }
}

/// 从父类控制器移除控制器
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC key:(NSString *)key {
    
    [self removeViewControllerWithChildVC:childVC];
    
    [self.displayDictM removeObjectForKey:key];
    
    if (![self.cacheDictM objectForKey:key]) {
        [self.cacheDictM setObject:childVC forKey:key];
    }
}

/// 添加子控制器
- (void)addChildViewControllerWithChildVC:(UIViewController *)childVC parentVC:(UIViewController *)parentVC {
    [parentVC addChildViewController:childVC];
    [parentVC didMoveToParentViewController:childVC];
    [parentVC.view addSubview:childVC.view];
}

/// 子控制器移除自己
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC {
    [childVC.view removeFromSuperview];
    [childVC willMoveToParentViewController:nil];
    [childVC removeFromParentViewController];
}

@end
