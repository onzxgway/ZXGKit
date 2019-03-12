//
//  CustomTableViewCell.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [UILabel new];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString*)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (![_textLabel superview]) {
        [self addSubview:_textLabel];
    }
    
    _textLabel.frame = CGRectMake(15, 0, self.frame.size.width-15, self.frame.size.height);
}

@end
