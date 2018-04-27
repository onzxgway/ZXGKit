//
//  WBStatusController.m
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGWBStatusController.h"
#import "WBStatusCell.h"

@interface ZXGWBStatusController ()

@end

@implementation ZXGWBStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:GET_IMAGE(@"toolbar_compose_highlighted") style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    rightItem.tintColor = UIColorHex(fd8224);
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationController.view.userInteractionEnabled = NO;

    //字典转模型放在后台线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        ZXGBaseTableViewSectionModel *secModel = [[ZXGBaseTableViewSectionModel alloc] init];
        for (int i = 0; i <= 7; i++) {
            NSData *data = [self dataNamed:[NSString stringWithFormat:@"weibo_%d.json",i]];
            ZXGWBTimelineItem *item = [ZXGWBTimelineItem modelWithJSON:data];
            for (ZXGWBStatus *status in item.statuses) {
                ZXGWBStatusLayout *layout = [[ZXGWBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
                layout.reuseIdentifier = NSStringFromClass([WBStatusCell class]);
                layout.cellClass = [WBStatusCell class];
                [secModel addCellModel:layout];
            }
        }
        [_dataSource addObject:secModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.view.userInteractionEnabled = YES;
            [_tableView reloadData];
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
