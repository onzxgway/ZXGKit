//
//  ZXGTableViewCell.m
//  Moments
//
//  Created by 朱献国 on 2018/5/14.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import "ZXGTableViewCell.h"

static NSInteger const count = 4;

@interface ZXGTableViewCell () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation ZXGTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView {
    
    [self.contentView addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.bottom.mas_equalTo(self.contentView);
        if (count <= 3) {
            make.height.mas_equalTo(66 * count);
        }
        else {
            make.height.mas_equalTo(66 * 3);
        }
    }];
    
//    [self.contentView addSubview:self.textView];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
//        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
//        make.height.mas_equalTo(40);
//    }];
//    __weak typeof(self) ws = self;
//    self.textView.textHeightChangeBlock = ^(CGFloat height) {
//        [ws.textView mas_updateConstraints:^(MASConstraintMaker *make) {
//             make.height.mas_equalTo(height);
//        }];
//        [ws.contentView updateConstraints];
//        [ws.contentView updateConstraintsIfNeeded];
//        [UIView animateWithDuration:0.25 animations:^{
//            [ws.contentView layoutIfNeeded];
//        }];
//        UITableView *tableView = [ws tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
//    };
//    
//    [self.contentView addSubview:self.title];
//    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.textView.mas_centerY);
//        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
//        make.right.mas_equalTo(self.textView.mas_left).mas_offset(-15);
//    }];
}

//- (UITableView *)tableView {
//    UIView *tableView = self.superview;
//    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
//        tableView = tableView.superview;
//    }
//    return (UITableView *)tableView;
//}
//
//- (ZXGCustomTextView *)textView {
//    if (!_textView) {
//        _textView = [[ZXGCustomTextView alloc] init];
//        _textView.initLine = 1;
//        _textView.maxLine = 3;
//        _textView.placeholder= @"请输入";
//    }
//    return _textView;
//}
//
//- (UILabel *)title {
//    if (!_title) {
//        _title = [[UILabel alloc] init];
//        _title.text = @"电动机啊";
//        _title.textColor = kBlackColor;
//    }
//    return _title;
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    cell.textLabel.text = @"abcdefg";
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        if (count <= 3) {
            _table.scrollEnabled = NO;
        }
        else {
            _table.scrollEnabled = YES;
        }
    }
    return _table;
}

@end
