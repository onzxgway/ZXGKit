//
//  MJRefreshNormalHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/25.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshNormalHeader : MJRefreshStateHeader

@property (nonatomic, weak  , readonly) UIImageView *arrowView;
@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;  // 菊花的样式

@end
