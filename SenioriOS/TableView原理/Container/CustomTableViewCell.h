//
//  CustomTableViewCell.h
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UIView

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) UILabel *textLabel;

- (instancetype)initWithReuseIdentifier:(NSString*)identifier;

@end
