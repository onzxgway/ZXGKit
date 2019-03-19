//
//  LearnScrollViewController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "LearnScrollViewController.h"
#import "ZXGCollectionViewFlowLayout.h"
#import "ZXGCollectionViewCell.h"
#import "MJExtension.h"
#import "DecorationCollectionViewLayout.h"
#import "CustomCollectionView.h"

@interface LearnScrollViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ZXGWaterFlowDelegate, UICollectionViewDelegateFlowLayout, DecorationCollectionViewLayoutDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *rView;
@property (nonatomic, strong) CustomCollectionView *collectView;

@property (nonatomic, strong) NSMutableArray<ShopModel *> *shops;

@end

@implementation LearnScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(38, 188, 318, 198);
    
    [self.scrollView addSubview:self.rView];
    self.rView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height);
    
    /**
     1.请说明并比较以下关键词：contentInset，contentSize，contentOffset。
     */
    // contentSize 指 UIScrollView 上显示内容的区域大小。
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height);
    // contentInset 是指 内容区域 与 UIScrollView 的边界。指 内容区域 的四条边到 UIScrollView 的对应边的距离，分别为 top，bottom，left，right。
    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // contentOffset 是当前 内容区域 浏览位置左上角点的坐标。它是相对于整个 UIScrollView 左上角为左边原点而言。默认为 CGPointZero。
    self.scrollView.contentOffset = CGPointMake(-20, -20);
    
    
    /**
     2. 请说明 UITableViewCell 的重用机制?
     
        UITableView 内部会维护两个缓存池，一个是 cell重用池，一个是 正在显示的cell缓存池。 列表初始化的时候，去重用池中取cell，没有的话就新建cell对象，添加到正在显示的cell缓存池中。列表滑动的时候，消失了的cell，从 正在显示的cell缓存池 -> cell重用池,将要显示的cell呢，根据identifier去 cell重用池 中取出。有 cell重用池 -> 正在显示的cell缓存池.
     */
    
    
    /**
     
     3. 请说明并比较以下协议：UITableViewDelegate，UITableViewDataSource?
     
        一般在 UIViewController 上配置 UITableView，都会用到这 2 个协议，这 2 个协议由当前 UIVIewController 实现。
        UITableViewDataSource 用来管控 UITableView 的实际数据：例如有多少 section，每个 section 有多少行，每行用哪种 UITableViewCell。其中 numOfRows 和 cellForRowAtIndexPath 这两个方法必须被实现，numOfSections 默认为 1。
        UITableViewDelegate 用来处理 UITableView 的 UI 和交互：例如设置 UITableView 的 header 和 footer，点击、拖动、删除某个 UITableViewCell 对应的操作。它所有的方法都是可选方法，有默认实现。
     */
    
    /**
     4. 请说明并比较以下协议：UICollectionViewDelegate，UICollectionViewDataSource，UICollectionViewDelegateFlowLayout
     
     一般在 UIViewController 上配置 UICollectionView，都会用到这 3 个协议，这 3 个协议由当前 UIVIewController 实现。
     UICollectionViewDataSource 用来管控 UICollectionView 的实际数据：例如有多少 section，每个 section 有多少个 item，每个 item 对应的 UI 如何 。其中 numOfItems 和 cellForItemAtIndexPath 这两个方法必须被实现，numOfSections 默认为 1。
     UICollectionViewDelegate 用来处理交互：例如设置点击、拖动、高亮某个 item 对应的操作。它所有的方法都是可选方法，有默认实现。
     UICollectionViewDelegateFlowLayout 用来处理 UICollectionView 的布局及其行为。比如具体 item 的尺寸大小， item 之间的间距，header 和 footer 的大小和间距，以及 UICollectionView 的滚动方向。这个协议的所有方法也都是可选方法，有默认实现。
     */
    
    
    /**
     瀑布流
     */
    
    //初始化数据
    NSArray *shopsArray = [ShopModel objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopsArray];
    
//    ZXGCollectionViewFlowLayout *layOut = [[ZXGCollectionViewFlowLayout alloc] init];
//    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(88, 88);
//    flowLayout.minimumLineSpacing = 10.f;
//    flowLayout.minimumInteritemSpacing = 10.f;
//    layOut.degelate = self;
    
    DecorationCollectionViewLayout *layOut = [[DecorationCollectionViewLayout alloc] init];
    layOut.decorationDelegate = self;
    layOut.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    layOut.minimumLineSpacing = 15;
    layOut.minimumInteritemSpacing = 8;
    layOut.itemSize = CGSizeMake((self.view.bounds.size.width - 30) / 3.3, 50);
    
    CustomCollectionView *collectView = [[CustomCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    collectView.backgroundColor = [UIColor whiteColor];
    self.collectView = collectView;
    collectView.delegate = self;
    collectView.dataSource = self;
    [collectView registerNib:[UINib nibWithNibName:@"ZXGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [collectView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UIView"];
    [collectView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UIViewF"];
    [self.view addSubview:collectView];
    
    [collectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:collectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:collectView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:collectView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:collectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[top, left, right, bottom]];
    
}

/**
 
 Decoration Views 是装饰视图。完全跟数据没有关系的视图，负责给 cell 或者 supplementary Views 添加辅助视图用的，例如给单个 section 或整个 UICollectionView 的背景（background）设置就属于 Decoration Views。
 
 */
/// 指定section是否显示卡片装饰图，默认值为false
- (BOOL)collectionView:(UICollectionView *)collectionView
  collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
decorationDisplayedForSectionAtSection:(NSInteger)section {
    return YES;
}

/// 指定section卡片装饰图颜色，默认为白色
- (UIColor *)collectionView:(UICollectionView *)collectionView
       collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
decorationColorForSectionAtSection:(NSInteger)section {
    return [UIColor redColor];
}

/// 指定section卡片装饰图间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
          collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
decorationInsetForSectionAtSection:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

/// 指定section卡片装饰图是否显示袖标，默认值为false
- (BOOL)collectionView:(UICollectionView *)collectionView
  collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandDisplayedForSectionAtSection:(NSInteger)section {
    return YES;
}

/// 指定section的袖标图标本地图片名字，默认为nil
- (NSString *)collectionView:(UICollectionView *)collectionView
        collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandImageForSectionAtSection:(NSInteger)section {
    return @"armband";
}

/// 指定section的袖标距离卡片的TopOffsetp
- (CGFloat)collectionView:(UICollectionView *)collectionView
     collectionViewLayout:(DecorationCollectionViewLayout *)collectionViewLayout
armbandTopOffsetForSectionAtSection:(NSInteger)section {
    return 18;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3.f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shops.count - 46;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.shopModel = self.shops[indexPath.item];
    return cell;
}

/**
 Supplementary Views 是补充视图。一般用来设置每个 Seciton 的 Header View 或者Footer View，用来标记 Section 的 View。
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *v = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UIView" forIndexPath:indexPath];
        v.backgroundColor = [UIColor blueColor];
        return v;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *v = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UIViewF" forIndexPath:indexPath];
        v.backgroundColor = [UIColor greenColor];
        return v;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(0, 88.f);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 28.f);
}

- (CGFloat)waterFlow:(ZXGCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach {
    ShopModel *shop = self.shops[indexPach.item];
    return shop.h / shop.w * width;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UIView *)rView {
    if (!_rView) {
        _rView = [UIView new];
        _rView.backgroundColor = [UIColor redColor];
    }
    return _rView;
}

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

@end
