//
//  CustonScrollView.h
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTableView, CustomTableViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol CustonTableViewDataSource <NSObject>

@required

- (NSInteger)tableView:(CustomTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CustomTableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(CustomTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface CustomTableView : UIScrollView

@property (nonatomic, weak, nullable) id <CustonTableViewDataSource> dataSource;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
