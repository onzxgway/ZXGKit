//
//  ZXGBaseTableViewController.h
//  Packaging
//
//  Created by 朱献国 on 2018/4/17.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGBaseTableView.h"

@interface ZXGBaseTableViewController : UIViewController {
    @protected
    ZXGBaseTableView *_baseTableView;
    NSMutableArray *_dataSource;
}

/** 列表对象*/
@property (nonatomic, strong) ZXGBaseTableView *baseTableView;
/** 数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
