//
//  ViewController.m
//  ZXGPageViewController
//
//  Created by onzxgway on 2019/1/17.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGCenterViewController.h"
#import "ZXGTestController.h"

typedef NS_ENUM(NSInteger, ZXGVCType) {
    ZXGVCTypeSuspendCenterPageVC = 1,
    ZXGVCTypeSuspendTopPageVC = 2,
    ZXGVCTypeTopPageVC = 3,
    ZXGVCTypeSuspendTopPausePageVC = 4,
    ZXGVCTypeSuspendCustomNavOrSuspendPosition = 5,
    ZXGVCTypeNavPageVC = 6,
    ZXGVCTypeScrollMenuStyleVC = 7,
    ZXGVCTypeLoadPageVC = 8,
    ZXGVCTypeYNTestPageVC = 100
};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArrayM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demos";
    
    self.dataArrayM = @[@{@"title" : @"悬浮样式--下拉刷新在顶部(QQ联系人样式)", @"type" :       @(ZXGVCTypeSuspendTopPausePageVC)},
                        @{@"title" : @"悬浮样式--下拉刷新在中间", @"type" : @(ZXGVCTypeSuspendCenterPageVC)},
                        @{@"title" : @"悬浮样式--下拉刷新在顶部", @"type" : @(ZXGVCTypeSuspendTopPageVC)},
                        @{@"title" : @"悬浮样式--自定义导航条或自定义悬浮位置", @"type" : @(ZXGVCTypeSuspendCustomNavOrSuspendPosition)},
                        @{@"title" : @"加载数据后显示页面(隐藏导航条)", @"type" : @(ZXGVCTypeLoadPageVC)},
                        @{@"title" : @"顶部样式", @"type" : @(ZXGVCTypeTopPageVC)},
                        @{@"title" : @"导航条样式", @"type" : @(ZXGVCTypeNavPageVC)},
                        @{@"title" : @"菜单栏样式", @"type" : @(ZXGVCTypeScrollMenuStyleVC)},
                        @{@"title" : @"测试专用", @"type" : @(ZXGVCTypeYNTestPageVC)}
                        ].mutableCopy;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    NSString *title = dict[@"title"];
    ZXGVCType type = [dict[@"type"] integerValue];
    UIViewController *vc = nil;
    switch (type) {
        case ZXGVCTypeSuspendTopPageVC:
        {
            vc = [ZXGTestController new] ;
        }
            break;
        case ZXGVCTypeSuspendCenterPageVC:
        {
            vc = [ZXGCenterViewController centerVC];
        }
            break;
        case ZXGVCTypeSuspendTopPausePageVC:
        {
            vc = [ZXGTestController new];
        }
            break;
        case ZXGVCTypeSuspendCustomNavOrSuspendPosition:
        {
            vc = [ZXGCenterViewController new];
        }
            break;
        case ZXGVCTypeTopPageVC:
        {
            vc = [ZXGCenterViewController new];
        }
            break;
        case ZXGVCTypeNavPageVC:
        {
            vc = [ZXGCenterViewController new];
        }
            break;
        case ZXGVCTypeLoadPageVC:
        {
            vc = [ZXGPageViewController new];
        }
            break;
        case ZXGVCTypeScrollMenuStyleVC: {
            vc = [ZXGPageViewController new];
        }
            break;
        case ZXGVCTypeYNTestPageVC:
        {
            vc = [ZXGPageViewController new];
        }
            break;
    }
    if (vc) {
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
