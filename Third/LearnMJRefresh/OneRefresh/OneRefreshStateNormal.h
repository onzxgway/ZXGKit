//
//  OneRefreshStateNormal.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/7.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshHeaderState.h"

@interface OneRefreshStateNormal : OneRefreshHeaderState

@property (nonatomic, weak  , readonly) UIImageView *arrowImage;

@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end
