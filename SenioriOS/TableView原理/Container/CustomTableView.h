//
//  CustomTableView.h
//  TableView原理
//
//  Created by 朱献国 on 2019/3/13.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CustomTableView;
@class CustomTableViewCell;

@protocol CustomTableViewDataSource <NSObject>

@required
- (NSInteger)tableView:(CustomTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CustomTableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(CustomTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 UITableView 的底层实现
 */
@interface CustomTableView : UIScrollView

@property (nonatomic, weak, nullable) id <CustomTableViewDataSource> dataSource;

- (void)reloadData;

- (CustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
