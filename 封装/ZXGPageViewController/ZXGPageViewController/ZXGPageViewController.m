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

@interface ZXGPageViewController ()

/// 页面ScrollView
@property (nonatomic, strong) ZXGPageScrollView *pageScrollView;

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
        
//        self.displayDictM = @{}.mutableCopy;
//        self.cacheDictM = @{}.mutableCopy;
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
//    [self setSelectedPageIndex:self.pageIndex];
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

/// 初始化ScrollView
- (void)setupPageScrollMenuView {
    CGRect frame = CGRectMake(0, 0, self.config.menuWidth, self.config.menuHeight);
    
    ZXGPageScrollMenuView *scrollMenuView = [[ZXGPageScrollMenuView alloc] initWithFrame:frame titles:self.titlesM configration:self.config delegate:self currentIndex:self.pageIndex];
    self.scrollMenuView = scrollMenuView;
    scrollMenuView.backgroundColor = [UIColor greenColor];
    
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
        _pageScrollView.backgroundColor = [UIColor greenColor];
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


@end
