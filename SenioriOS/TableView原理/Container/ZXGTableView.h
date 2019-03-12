//
//  ZXGTableView.h
//  TableView原理
//
//  Created by 朱献国 on 2019/3/12.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ZXGTableView;

@protocol ZXGTableViewDataSource <NSObject>

@required
- (NSInteger)tableView:(ZXGTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CustomTableViewCell *)tableView:(ZXGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(ZXGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZXGTableView : UIScrollView

@property (nonatomic, weak, nullable) id <ZXGTableViewDataSource> dataSource;

- (void)reloadData;

- (CustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
