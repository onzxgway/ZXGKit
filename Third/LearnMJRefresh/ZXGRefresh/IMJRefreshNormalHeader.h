//
//  IMJRefreshNormalHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "IMJRefreshStateHeader.h"

@interface IMJRefreshNormalHeader : IMJRefreshStateHeader

@property (nonatomic, readonly, weak  ) UIImageView *arrowView;
@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;  // 菊花的样式

@end
