//
//  OneRefreshHeaderState.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshHeader.h"
#import "NSBundle+OneRefresh.h"

@interface OneRefreshHeaderState : OneRefreshHeader

@property (nonatomic, strong, readonly) UILabel *stateLabel;
@property (nonatomic, strong, readonly) UILabel *timeLabel;

@property (nonatomic) CGFloat labelLeftInset;

@end
