//
//  MVVMView.h
//  架构
//
//  Created by feizhu on 2018/3/5.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModel.h"

@interface MVVMView : UIView

@property (nonatomic, strong) MVVMViewModel *viewModel;

@end
