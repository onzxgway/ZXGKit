//
//  ZXGViewController.m
//  GCD_Basic
//
//  Created by feizhu on 2018/3/15.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGViewController.h"
#import "ZXGDemoController.h"

@interface ZXGViewController ()
@property (nonatomic, strong) NSArray *arrs;
@end

@implementation ZXGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrs =  @[
  @{
        @"title"   : @"队列",
        @"children": @[
                      @{@"title"   : @"串行队列",
                        @"children": @"",
                        @"selector": @"serialQueue"},
                      @{@"title"   : @"并发队列",
                        @"children": @"",
                        @"selector": @"concurrentQueue"},
                      @{@"title"   : @"主队列",
                        @"children": @"",
                        @"selector": @"mainQueue"}
                      ]
  },
  @{
      @"title"   : @"任务添加到队列的方式",
      @"children": @[
                     @{@"title"   : @"同步执行",
                       @"children": @"",
                       @"selector": @"sync"},
                     @{@"title"   : @"异步执行",
                       @"children": @"",
                       @"selector": @"async"}
                     ]
  },
  @{
      @"title"   : @"队列与任务组合",
      @"children":@[
                    @{@"title"   : @"同步执行 ➕ 并发队列",
                      @"children": @"",
                      @"selector": @"syncAndConcurrent"},
                    @{@"title"   : @"异步执行 ➕ 并发队列",
                      @"children": @"",
                      @"selector": @"asyncAndConcurrent"},
                    @{@"title"   : @"同步执行 ➕ 串行队列",
                      @"children": @"",
                      @"selector": @"syncAndSerial"},
                    @{@"title"   : @"异步执行 ➕ 串行队列",
                      @"children": @"",
                      @"selector": @"asyncAndSerial"},
                    @{@"title"   : @"同步执行 ➕ 主队列",
                      @"children": @"",
                      @"selector": @"syncAndMain"},
                    @{@"title"   : @"同步执行 ➕ 主队列",
                      @"children": @"",
                      @"selector": @"othersyncAndMain"},
                    @{@"title"   : @"异步执行 ➕ 主队列",
                      @"children": @"",
                      @"selector": @"asyncAndMain"}
                    ]
 },
 @{
      @"title"   : @"GCD其它常用API",
      @"children": @[
                     @{@"title"   : @"dispatch_set_target_queue",
                       @"children": @"",
                       @"selector": @"dispatch_set_target_queue"},
                     @{@"title"   : @"dispatch_after",
                       @"children": @"",
                       @"selector": @"dispatch_after"},
                     @{@"title"   : @"dispatch_once",
                       @"children": @"",
                       @"selector": @"dispatchOnce"},
                     @{@"title"   : @"dispatch_apply",
                       @"children": @"",
                       @"selector": @"dispatch_apply"},
                     @{@"title"   : @"dispatch_group",
                       @"children": @"",
                       @"selector": @"dispatch_group"},
                     @{@"title"   : @"dispatch_semaphore",
                       @"children": @"",
                       @"selector": @"dispatch_semaphore"},
                     @{@"title"   : @"dispatch_barrier_async",
                       @"children": @"",
                       @"selector": @"dispatch_barrier_async"},
                     @{@"title"   : @"dispatch_suspend/dispatchp_resume",
                       @"children": @"",
                       @"selector": @"dispatch_suspend"}
                     ]
 },
];

    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.arrs[section] objectForKey:@"children"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"commonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSArray *arr = [self.arrs[indexPath.section] objectForKey:@"children"];
    NSDictionary *dict =  arr[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.arrs[section] objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ZXGDemoController *vc = [[ZXGDemoController alloc] init];
    NSArray *arr = [self.arrs[indexPath.section] objectForKey:@"children"];
    vc.selectorStr = [arr[indexPath.row] objectForKey:@"selector"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
