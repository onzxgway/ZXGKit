//
//  ProductController.m
//  京东商品详情
//
//  Created by 朱献国 on 2018/11/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ProductController.h"
#import "ProductScrollView.h"
#import "ProductDetailView.h"


const CGFloat detailWebViewOffsetY = 70.f;

@interface ProductController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *containerView;

//
@property (nonatomic, strong) UIScrollView *productMainScrollView;
@property (nonatomic, strong) ProductScrollView *productScrollView;
@property (nonatomic, strong) UIView *sonView;
@property (nonatomic, strong) UILabel *displayProductLabel;

//
@property (nonatomic, strong) ProductDetailView *productDetailView;

@end

@implementation ProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.containerView];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (scrollView == self.productMainScrollView) {
        
        NSLog(@"yOffset %f", yOffset);
        // 在滑动过程中，让sonView在上面，有图片的productScrollView在下面
//        [self move:self.productScrollView from:0 by:yOffset/2];
        
    }
//    else {  //productDetailWebView的webView，因为productScrollView只会左右移动
//
//        if (yOffset < -detailWebViewOffsetY) {
//            self.productDetailView.textLabel.text = @"释放回到商品主页";
//        }
//        else {
//            self.productDetailView.textLabel.text = @"下拉回到商品主页";
//        }
//
//    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (decelerate) {
        
        CGFloat yOffset = scrollView.contentOffset.y;
        if (scrollView == self.productMainScrollView) {
            
            CGFloat moveUpOffset = self.view.bounds.size.height + 80.f;
            
            if (yOffset >= moveUpOffset) {  // 达到这个偏移量 那么将商品详情移上来
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.containerView.transform = CGAffineTransformMakeTranslation(0.f, -self.view.bounds.size.height);
//                    self.titleView.contentOffset = CGPointMake(0.f, 44.f);
                    
                } completion:nil];
                
            }
        }
        else {  //往下拉 达到70的偏移量
            
            if (yOffset < -detailWebViewOffsetY) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.containerView.transform = CGAffineTransformIdentity;
//                    self.titleView.contentOffset = CGPointMake(0.f, 0.f);
                    
                } completion:nil];
                
            }
            
        }
        
    }
}

#pragma mark - 设置图片的偏移
- (void)move:(UIView *)view from:(CGFloat)start by:(CGFloat)y {
    CGRect frame = view.frame;
    frame.origin.y = y - start;
    view.frame = frame;
}

#pragma mark - getter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 2 * self.view.bounds.size.height)];
        _containerView.backgroundColor = [UIColor lightGrayColor];
        
        [_containerView addSubview:self.productMainScrollView];
        [_containerView addSubview:self.productDetailView];
    }
    return _containerView;
}

- (UIScrollView *)productMainScrollView {
    if (!_productMainScrollView) {
        _productMainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
        _productMainScrollView.showsVerticalScrollIndicator = YES;
        _productMainScrollView.backgroundColor = [UIColor yellowColor];
        _productMainScrollView.delegate = self;
        _productMainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 2 * self.view.bounds.size.height);
        
        // 轮播图
        [_productMainScrollView addSubview:self.productScrollView];
        
        
        CGFloat displayProductLabelHeight = 40.f;
//        _sonView = [[UIView alloc] initWithFrame:CGRectMake(0.f, _productScrollView.eoc_bottomY, self.view.bounds.size.width, 2 * self.view.bounds.size.height - _productScrollView.eoc_bottomY-displayProductLabelHeight)];
//        _sonView.layer.shadowOffset = CGSizeMake(0.f, -1.f);
//        _sonView.layer.shadowOpacity = 0.8f;
//        _sonView.layer.shadowColor = [[UIColor grayColor] CGColor];
//        _sonView.backgroundColor = [UIColor grayColor];
//        [_productMainScrollView addSubview:_sonView];
//
        // 添加上拉显示商品详情label
        _displayProductLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.productScrollView.frame), self.view.bounds.size.width, displayProductLabelHeight)];
        _displayProductLabel.textAlignment = NSTextAlignmentCenter;
        _displayProductLabel.text = @"上拉显示商品详情";
        [_productMainScrollView addSubview:_displayProductLabel];
        
    }
    return _productMainScrollView;
}


- (ProductScrollView *)productScrollView {
    if (!_productScrollView) {
        //添加轮播图片数组
//        NSArray *imageArr = @[@"product_1", @"product_0", @"product_1", @"product_0", @"product_1", @"product_0"];
        _productScrollView = [[ProductScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.width)];
        _productScrollView.backgroundColor = [UIColor blueColor];
//        _productScrollView.imageArr = imageArr;
        
    }
    return _productScrollView;
}

- (ProductDetailView *)productDetailView {
    if (!_productDetailView) {
        _productDetailView = [[ProductDetailView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(self.productMainScrollView.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
        _productDetailView.showTextLabel = YES;
        _productDetailView.webView.scrollView.delegate = self;
    }
    return _productDetailView;
}


@end
