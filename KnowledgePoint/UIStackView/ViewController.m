//
//  ViewController.m
//  UIStackView
//
//  Created by 朱献国 on 2018/6/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}

- (void)createView {
    /**
     UIStackView本身不展示任何内容,只是用来约束子控件.
     */
    UIStackView *stackView = [[UIStackView alloc] init];
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(400, 18, 6, 18));
    }];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentCenter;
    
    //
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"v_img"];
    [stackView addArrangedSubview:img];
    
    UILabel *one = [[UILabel alloc] init];
    one.textColor = [UIColor blackColor];
    one.font = [UIFont systemFontOfSize:13];
    one.text = @"哈发回复哈哈发货单";
    [stackView addArrangedSubview:one];
}

@end
