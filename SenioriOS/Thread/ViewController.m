//
//  ViewController.m
//  Thread
//
//  Created by 朱献国 on 2019/1/9.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "GCDTwoViewController.h"
#import "GCDOneViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(indexPath.row == 0) {
        cell.textLabel.text = @"GCD";
    }
    else if(indexPath.row == 1) {
        cell.textLabel.text = @"GCD_Two";
    }
    else if(indexPath.row == 2) {
        cell.textLabel.text = @"锁机制";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *viewCtr = nil;
    if(indexPath.row == 0) {
        viewCtr = [GCDOneViewController new];
    }
    else if(indexPath.row == 1) {
        viewCtr = [GCDTwoViewController new];
    }
    else if(indexPath.row == 2) {
        viewCtr = [GCDTwoViewController new];
    }
    [self.navigationController pushViewController:viewCtr animated:YES];
    
}



@end
