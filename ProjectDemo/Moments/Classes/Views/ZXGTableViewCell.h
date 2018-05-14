//
//  ZXGTableViewCell.h
//  Moments
//
//  Created by 朱献国 on 2018/5/14.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXGCustomTextView.h"

@interface ZXGTableViewCell : UITableViewCell

@property (strong, nonatomic) ZXGCustomTextView *textView;
@property (nonatomic, strong) UILabel *title;

@end
