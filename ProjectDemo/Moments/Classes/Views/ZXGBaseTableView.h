//
//  ZXGBaseTableView.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXGMomentsLayout;

@interface ZXGRTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    @protected
    NSMutableArray<ZXGMomentsLayout *> *_momentModels;
}

/** 数据源*/
@property (nonatomic, strong) NSMutableArray<ZXGMomentsLayout *> *momentModels;


/**
 子类实现
 */
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
