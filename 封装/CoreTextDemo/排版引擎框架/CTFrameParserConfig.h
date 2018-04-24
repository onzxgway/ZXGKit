//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFrameParserConfig : NSObject

@property (nonatomic) CGFloat width;    //排版区域的宽度
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;

@end
