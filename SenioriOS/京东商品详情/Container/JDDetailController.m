//
//  JDDetailController.m
//  京东商品详情
//
//  Created by 朱献国 on 2018/11/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "JDDetailController.h"
#import "JZNavigationTitleView.h"
#import "ProductController.h"
#import "DetailController.h"
#import "CommentController.h"

@interface JDDetailController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) JZNavigationTitleView *titleView;

@property (nonatomic, strong) ProductController *productCtrl;
@property (nonatomic, strong) DetailController *detailCtrl;
@property (nonatomic, strong) CommentController *commentCtrl;

@end

@implementation JDDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainScrollView];
    
    // 定制导航栏
    [self customNavView];
    
    // 在mainScrollView上添加商品页、商品详情页、评价页面
    [self.mainScrollView addSubview:self.productCtrl.view];
    [self.mainScrollView addSubview:self.detailCtrl.view];
    [self.mainScrollView addSubview:self.commentCtrl.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)dealloc {
    [self.mainScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)customNavView {
    
    _titleView = [[JZNavigationTitleView alloc] init];
    _titleView.titles = @[@"商品", @"详情", @"评价"];
    self.navigationItem.titleView = _titleView;
    
    __weak typeof(self) weakSelf = self;
    _titleView.itemClickedCallback = ^(NSInteger index) {
        [weakSelf.mainScrollView scrollRectToVisible:CGRectMake(index * weakSelf.view.bounds.size.width, 0.f, weakSelf.view.bounds.size.width, weakSelf.view.bounds.size.height) animated:YES];
    };
    
    // titleView添加对mainScrollView的观察
    [self.mainScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
//    __weak typeof(_titleView)weakTitleView = _titleView;
//    [_titleView eocObserver:_mainScrollView keyPath:@"contentOffset" block:^{
//
//        UIScrollView *scrollView = (UIScrollView *)weakSelf.mainScrollView;
//        CGFloat xOffset = scrollView.contentOffset.x;
//        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//        //        int index = xOffset/screenWidth;  如果用这个数值，往右滑没问题，但往左滑有问题，可以算一下边界，左边随便移动一下，index值就改变了
//
//        int index;
//        if (xOffset == screenWidth) {
//
//            index = 1;
//            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
//
//        } else if (xOffset == 2*screenWidth) {
//
//            index = 2;
//            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
//
//        } else if (xOffset == 0) {
//
//            index = 0;
//            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
//
//        }
//
//    }];
    
    
    // 新建分享和更多两个按钮，注意如果使用[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)] 则不能调整大小、间距； 当然你也可以设置一个view 上面添加两个button
    //        UIBarButtonItem* shareButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    //
    //        UIBarButtonItem* moreButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];

    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];

    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
//    [moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];

    self.navigationItem.rightBarButtonItems = @[moreButtonItem, shareButtonItem];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSLog(@"%@", NSStringFromCGPoint([change[NSKeyValueChangeNewKey] CGPointValue]));
        
        CGFloat x = [change[NSKeyValueChangeNewKey] CGPointValue].x;
        
        CGFloat percent = x / self.mainScrollView.bounds.size.width;
        
        [self.titleView scrollToPercent:percent];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark - getter方法
- (UIScrollView *)mainScrollView {
    
    if (!_mainScrollView) {
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
        _mainScrollView.backgroundColor = [UIColor redColor];
        _mainScrollView.contentSize = CGSizeMake(3 * self.view.bounds.size.width, 0);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        
    }
    
    return _mainScrollView;
}


- (ProductController *)productCtrl {
    if (!_productCtrl) {
        _productCtrl = [[ProductController alloc] init];
        [self addChildViewController:_productCtrl];
    }
    return _productCtrl;
}

- (DetailController *)detailCtrl {
    if (!_detailCtrl) {
        _detailCtrl = [[DetailController alloc] init];
        _detailCtrl.view.frame = CGRectMake(self.view.bounds.size.width, 0.f, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
        [self addChildViewController:_detailCtrl];
    }
    return _detailCtrl;
}

- (CommentController *)commentCtrl {
    if (!_commentCtrl) {
        _commentCtrl = [[CommentController alloc] init];
        _commentCtrl.view.frame = CGRectMake(2 * self.view.bounds.size.width, 0.f, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
        [self addChildViewController:_commentCtrl];
    }
    return _commentCtrl;
}

@end
