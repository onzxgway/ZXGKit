//
//  WBStatusController.m
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "WBStatusController.h"
#import "WBStatusLayout.h"
#import "WBModel.h"

@interface WBStatusController ()

@end

@implementation WBStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:GET_IMAGE(@"toolbar_compose_highlighted") style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    rightItem.tintColor = UIColorHex(fd8224);
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationController.view.userInteractionEnabled = NO;

    //字典转模型放在后台线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        [NSThread sleepForTimeInterval:2.f];
        ZXGBaseTableViewSectionModel *secModel = [[ZXGBaseTableViewSectionModel alloc] init];
        for (int i = 0; i <= 7; i++) {
            NSData *data = [self dataNamed:[NSString stringWithFormat:@"weibo_%d.json",i]];
            WBTimelineItem *item = [WBTimelineItem modelWithJSON:data];
            for (WBStatus *status in item.statuses) {
//                WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
//                [_layouts addObject:layout];
            }
            ZXGBaseTableViewCellModel *model = [[ZXGBaseTableViewCellModel alloc] init];
            model.reuseIdentifier = @"ZXGBaseTableViewCell";
            model.cellClass = [ZXGBaseTableViewCell class];
            model.rowHeight = 88;
            [secModel addCellModel:model];
        }
        
        [self.dataSource addObject:secModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.view.userInteractionEnabled = YES;
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - Overwrite
#pragma mark - Properties
#pragma mark - Lazy Load
#pragma mark - Singleton
#pragma mark - Init
#pragma mark - Dealloc
#pragma mark - Setter
#pragma mark - Private
- (void)sendStatus {
    
}

- (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}
#pragma mark - Public
#pragma mark - APIs
#pragma mark - Events



@end
