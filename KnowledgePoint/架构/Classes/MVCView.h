//
//  MVCView.h
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVCModel.h"

@protocol MVCViewDelegate <NSObject>

- (void)mVCViewTapEvent:(UIView *)mVCView;

@end

@interface MVCView : UIView

@property (nonatomic, strong) MVCModel *mVCModel;

@property (nonatomic, weak  ) id<MVCViewDelegate> delegate;

@end
