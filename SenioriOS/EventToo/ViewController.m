//
//  ViewController.m
//  EventToo
//
//  Created by 朱献国 on 2018/11/13.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "WhiteGesture.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addGestureRecognizer:[[WhiteGesture alloc] initWithTarget:self action:@selector(wC)]];
}

- (void)wC {
    NSLog(@"%s", __func__);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = [dic.allKeys firstObject];
    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    // 由字符串转为类型的时候  如果类型是自定义的 需要在类型字符串前边加上你的项目的名字！
    Class cla = NSClassFromString([dic.allValues firstObject]);
    [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
}

#pragma mark - lazy load

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
                        @{
                            @"多手势共存和互斥" : @"MultiGestureController"
                            },
                        @{
                            @"hitTest和pointInside应用" : @"PracticeController"
                            },
                        @{
                            @"实际应用" : @"ApplyController"
                            }
                        ];
    }
    return _dataSource;
}


@end
