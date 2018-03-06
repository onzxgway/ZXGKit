//
//  MVPView.h
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVPViewDelegate <NSObject>

- (void)mVCViewTapEvent:(UIView *)mVPView;

@end

@interface MVPView : UIView

@property (nonatomic, copy  ) NSString *contentStr;
@property (nonatomic, weak  ) id<MVPViewDelegate> delegate;

@end
