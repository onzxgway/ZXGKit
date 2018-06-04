//
//  NewTableViewCell.h
//  LearnMasonry
//
//  Created by 朱献国 on 2018/6/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CellType) {
    CellType1111,
    CellType1110,
    CellType0111,
    CellType0011,
    CellType0010,
    CellType1101
};

@interface NewTableViewCell : UITableViewCell

@property (nonatomic) CellType type;

@end
