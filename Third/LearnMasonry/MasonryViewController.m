//
//  MasonryViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()
@property (nonatomic, strong) NSMutableArray *masonryViewArray; // <#备注#>

@property (nonatomic, strong) NSMutableArray *masonryGreenViewArray; // <#备注#>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIImageView *priceImg;

@property (nonatomic, strong) MASConstraint *consO;
@property (nonatomic, strong) MASConstraint *consT;

@end

@implementation MasonryViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Masonry高级用法";
    
    [self test_masonry_horizontal_fixSpace];
    [self test_masonry_horizontal_fixItemWidth];
    
    [self placeSubViews];
}

#pragma mark - CreateViews
- (void)placeSubViews {
    
    self.priceLab.text = @"￥199.00";
    self.titleLab.text = @"如果标题";
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-120);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-120);
        self.consO = make.right.mas_equalTo(self.priceLab.mas_left).mas_offset(-20).priority(MASLayoutPriorityDefaultHigh);
        self.consT = make.right.mas_equalTo(self.view.mas_right).mas_offset(-20).priority(MASLayoutPriorityDefaultLow);
    }];
    
    /**
    // 设置控件抗拉伸的优先级
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-120);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
        make.right.mas_equalTo(self.priceLab.mas_left).mas_offset(-20);
    }];
    
    [self.titleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.priceLab setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    */
    
    /**
    // 设置抗压缩的优先级
    // 需求：如果标题内容过多与价格标签重叠的话，价格标签优先完全显示，标题标签尾部显示。。。
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-120);
    }];
    
    [self.priceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceLab.mas_left).mas_offset(-6);
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
        make.right.mas_lessThanOrEqualTo(self.priceImg.mas_left).mas_offset(-20);
    }];
    
    // 通俗来讲，不同的优先级，表示显示的完整性的高低，优先级越高，那么在父控件在无越界的情况下，就会优先把优先级高的控件显示完整，然后再依次显示优先级低的
    [self.priceLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.priceImg setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
     */
}

#pragma mark - Private
- (void)test_masonry_horizontal_fixSpace {
    // 实现masonry水平固定间隔方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:22 leadSpacing:22 tailSpacing:22];
    
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.height.mas_equalTo(88);
    }];

}

- (void)test_masonry_horizontal_fixItemWidth {
    
    // 实现masonry水平固定控件宽度方法
    [self.masonryGreenViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:66 leadSpacing:8 tailSpacing:8];
    
    // 设置array的垂直方向的约束
    [self.masonryGreenViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(260);
        make.height.mas_equalTo(88);
    }];
}

#pragma mark - Public
- (void)tapUEvent {
//    [self.priceLab setHidden:YES];
}

#pragma mark - LazyLoad
- (NSMutableArray *)masonryViewArray {
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            [self.view addSubview:view];
            [_masonryViewArray addObject:view];
        }
    }
    return _masonryViewArray;
}

- (NSMutableArray *)masonryGreenViewArray {
    if (!_masonryGreenViewArray) {
        _masonryGreenViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor greenColor];
            [self.view addSubview:view];
            [_masonryGreenViewArray addObject:view];
        }
    }
    return _masonryGreenViewArray;
}

- (UIView *)titleLab {
    if (!_titleLab) {
        [self.view addSubview:_titleLab = [[UILabel alloc] init]];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _titleLab;
}

- (UIView *)priceLab {
    if (!_priceLab) {
        [self.view addSubview:_priceLab = [[UILabel alloc] init]];
        _priceLab.textColor = [UIColor blackColor];
        _priceLab.font = [UIFont systemFontOfSize:12];
        _priceLab.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUEvent)];
        [_priceLab addGestureRecognizer:tap];
        _priceLab.userInteractionEnabled = YES;
    }
    return _priceLab;
}

- (UIImageView *)priceImg {
    if (!_priceImg) {
        [self.view addSubview:_priceImg = [[UIImageView alloc] init]];
        _priceImg.image = [UIImage imageNamed:@"children"];
    }
    return _priceImg;
}

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
