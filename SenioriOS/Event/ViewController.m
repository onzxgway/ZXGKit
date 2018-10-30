//
//  ViewController.m
//  Event
//
//  Created by 朱献国 on 2018/10/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
    
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
    
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
    
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
                          @"hitTest和pointInside原理" : @"ResponderController"
                          },
                         @{
                          @"hitTest和pointInside应用" : @"PracticeController"
                          },
                         @{
                          @"Open, Public, Internal, File-private, Private" : @"AuthorityController"
                          },
                         @{
                          @"在 Swift 中，怎样理解是 copy-on-write？" : @"CopyonwriteController"
                          },
                         @{
                          @"什么是属性观察（Property Observer）？" : @"PropertyObserverController"
                          },
                         @{
                          @"Swift 实战题" : @"ReallyController"
                          }
                        
                        ];
    }
    return _dataSource;
}
    
@end
