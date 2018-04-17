//
//  ZXGBaseTableView.h
//  Packaging
//
//  Created by 朱献国 on 2018/4/17.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGBaseTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    @protected
    NSMutableArray *_dataSourceArr;
}

/** 数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end
