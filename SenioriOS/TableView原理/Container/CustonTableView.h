//
//  CustonScrollView.h
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustonTableView, CustomTableViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol CustonTableViewDataSource<NSObject>

@required

- (NSInteger)tableView:(CustonTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CustomTableViewCell *)tableView:(CustonTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface CustonTableView : UIScrollView

@property (nonatomic, weak, nullable) id <CustonTableViewDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
