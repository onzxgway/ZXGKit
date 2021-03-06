//
//  ZXGMomentsController.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/4/12.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsController.h"
#import "ZXGMomentModel.h"
#import "ZXGMomentsLayout.h"
#import "ZXGMomentsCell.h"
#import "NSDictionary+Log.h"
#import "ZXGViewController.h"

@interface ZXGMomentsController () <ZXGMomentsCellDelegate>

@end

@implementation ZXGMomentsController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化视图
    [self moments_InitView];
    
    [self getResourece];
}

#pragma mark - Init
//初始化视图
- (void)moments_InitView {
    //
    self.navigationItem.title = @"朋友圈";
    //
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[GET_IMAGE(@"barbuttonicon_Camera") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationController.view.userInteractionEnabled = NO;
}

- (void)sendStatus {
    ZXGViewController *controller = [[ZXGViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - ZXGMomentsCellDelegate
- (void)cellDidClickCard:(ZXGMomentsCell *)cell {
    
    ZXGBaseWKWebViewController *ctrl = [[ZXGBaseWKWebViewController alloc] init];
    
    ZXGBaseWebViewModel *model = [[ZXGBaseWebViewModel alloc] init];
    model.articleLinkStr = cell.momentsView.layout.momentsModel.url;
    
    ctrl.contentModel = model;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)cellDidClickAll:(ZXGMomentsCell *)cell {
    cell.momentsView.layout.momentsModel.isExpand = !cell.momentsView.layout.momentsModel.isExpand;
    [cell.momentsView.layout layout];
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //update tableView 关闭刷新动画
//    [UIView performWithoutAnimation:^{
//        [_tableView beginUpdates];
//        [_tableView endUpdates];
//    }];
}

#pragma mark - private
- (void)getResourece {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        ZXGBaseTableViewSectionModel *secModel = [[ZXGBaseTableViewSectionModel alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment0" ofType:@"plist"];
        NSArray *sourceArr = [NSArray arrayWithContentsOfFile:plistPath];
        sourceArr = [NSArray modelArrayWithClass:ZXGMomentModel.class json:sourceArr];
        
        for (int i = 0; i < 15; ++i) {
            for (ZXGMomentModel *model in sourceArr) {
                ZXGMomentsLayout *layout = [[ZXGMomentsLayout alloc] initWithMoments:model];
                layout.cellClass = [ZXGMomentsCell class];
                layout.reuseIdentifier = NSStringFromClass(ZXGMomentsCell.class);
                [secModel addCellModel:layout];
            }
        }
        [_dataSource addObject:secModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
    
}

#pragma mark - public
#pragma mark - lazyLoad

@end
