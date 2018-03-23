//
//  WBStatusController.m
//  SinaWeibo
//
//  Created by feizhu on 2018/3/21.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "WBStatusController.h"
#import "ZXGTableView.h"
#import "WBStatusLayout.h"
#import "WBModel.h"

@interface WBStatusController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZXGTableView *tableView;
@property (nonatomic, strong) NSMutableArray *layouts;
@end

@implementation WBStatusController

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.view addSubview:_tableView];
    self.view.backgroundColor = kWBCellBackgroundColor;


    //字典转模型放在后台线程
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        for (int i = 0; i <= 7; i++) {
//            NSData *data = [self dataNamed:[NSString stringWithFormat:@"weibo_%d.json",i]];
//            WBTimelineItem *item = [WBTimelineItem modelWithJSON:data];
//            for (WBStatus *status in item.statuses) {
//                WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
//                [_layouts addObject:layout];
//            }
//        }
//    });
}

#pragma mark - Overwrite
#pragma mark - Properties
#pragma mark - Lazy Load
- (ZXGTableView *)tableView {
    if (!_tableView) {
        _tableView = [ZXGTableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSMutableArray *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}
#pragma mark - Singleton
#pragma mark - Init
#pragma mark - Dealloc
#pragma mark - Setter
#pragma mark - Private
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
