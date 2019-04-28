//
//  ZXGTableViewController.m
//  UISearchController
//
//  Created by onzxgway on 2019/4/28.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTableViewController.h"

@interface ZXGTableViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *baseSearchController;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ZXGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    [self addSearchController];
}

- (void)addSearchController
{
    //    self.searchResultViewController = [[[self searchResultControllerClass] alloc]init];
    
    self.baseSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.baseSearchController.delegate = self;
    //    self.baseSearchController.searchResultsUpdater = self.searchResultViewController;
    [self.baseSearchController.searchBar sizeToFit];    //必须要让searchBar自适应才会显示
    //    self.baseSearchController.searchBar.delegate = self.searchResultViewController;
    self.baseSearchController.searchBar.placeholder = @"搜索";
    [self.baseSearchController.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭系统自动大写功能
    //    self.baseSearchController.searchBar.backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xf5f5f5)];
    self.baseSearchController.view.backgroundColor = [UIColor yellowColor];
    
    UITextField *searchField = [self.baseSearchController.searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        searchField.font = [UIFont boldSystemFontOfSize:18.f];
        //        searchField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xcw_coach_searchIcon"]];
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 19.0f;
        searchField.layer.masksToBounds = YES;
    }
    self.searchBar = self.baseSearchController.searchBar;
    
    self.definesPresentationContext = NO;
    
    self.tableView.tableHeaderView = self.searchBar;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.sectionHeaderHeight = 0.f;
        tableView.sectionFooterHeight = 10.f;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
        
        _tableView = tableView;
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    else {
        cell.contentView.backgroundColor = [UIColor greenColor];
    }
    return cell;
}


@end
