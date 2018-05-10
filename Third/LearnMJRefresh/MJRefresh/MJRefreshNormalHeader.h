//
//  MJRefreshNormalHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/10.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshNormalHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
