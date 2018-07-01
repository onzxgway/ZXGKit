//
//  ZXGItemOneController.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGItemOneController.h"
#import "ZXGOnePushController.h"
#import "ZXGExpandAbleLabel.h"
#import "Masonry.h"

@interface ZXGItemOneController ()
@property (nonatomic, strong) ZXGExpandAbleLabel *expandAbleLabel; // <#备注#>
@end

@implementation ZXGItemOneController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"One";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStylePlain target:self action:@selector(pushClicked)];
    
    [self createViews];
}

#pragma mark - CreateViews
- (void)createViews {
    
    [self.view addSubview:self.expandAbleLabel];
    [self.expandAbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_lessThanOrEqualTo(300);
//        make.height.mas_equalTo(66);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *testStr = @"中国是世界四大文明古国之一，有着悠久的历史，距今约5000年前，以中原地区为中心开始出现聚落组";
        NSString *testStr = @"2018年俄罗斯世界杯是国际足联世界杯足球赛举办的第21届赛事。比赛于2018年6月14日至7月15日在俄罗斯举行，这是世界杯首次在俄罗斯境内举行，亦是世界杯首次在东欧国家举行";
        self.expandAbleLabel.text = testStr;
//        NSLog(@"**%@**", NSStringFromCGRect(self.expandAbleLabel.frame));
    });
}

#pragma mark - Private
- (void)pushClicked {
    [self.navigationController pushViewController:[ZXGOnePushController new] animated:YES];
}

#pragma mark - Public

#pragma mark - LazyLoad
- (ZXGExpandAbleLabel *)expandAbleLabel {
    if (!_expandAbleLabel) {
        _expandAbleLabel = [[ZXGExpandAbleLabel alloc] init];
        _expandAbleLabel.backgroundColor = [UIColor greenColor];
        _expandAbleLabel.foldLines = 3;
        _expandAbleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _expandAbleLabel;
}

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
