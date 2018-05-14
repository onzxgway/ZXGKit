//
//  ZXGTableViewCell.m
//  Moments
//
//  Created by 朱献国 on 2018/5/14.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import "ZXGTableViewCell.h"

@implementation ZXGTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView {
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(40);
    }];
    __weak typeof(self) ws = self;
    self.textView.textHeightChangeBlock = ^(CGFloat height) {
        [ws.textView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(height);
        }];
        [ws.contentView updateConstraints];
        [ws.contentView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [ws.contentView layoutIfNeeded];
        }];
        UITableView *tableView = [ws tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
    };
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.textView.mas_left).mas_offset(-15);
    }];
}

- (UITableView *)tableView {
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (ZXGCustomTextView *)textView {
    if (!_textView) {
        _textView = [[ZXGCustomTextView alloc] init];
        _textView.initLine = 1;
        _textView.maxLine = 3;
        _textView.placeholder= @"请输入";
    }
    return _textView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"电动机啊";
        _title.textColor = kBlackColor;
    }
    return _title;
}

@end
