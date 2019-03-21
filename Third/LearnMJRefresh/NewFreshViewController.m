//
//  NewFreshViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewFreshViewController.h"
#import "NewRefreshHeader.h"
#import "NewRefreshStateHeader.h"
#import "NewRefreshNormalHeader.h"

@interface NewFreshViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NewFreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"EndRefresh" style:UIBarButtonItemStyleDone target:self action:@selector(endRefresh)];
    
    self.table.refreshView = [NewRefreshNormalHeader refreshWithBlock:^{
        NSLog(@"Refreshing");
    }];
    
}

- (void)endRefresh {
    [self.table.refreshView endRefresh];
}

@end
