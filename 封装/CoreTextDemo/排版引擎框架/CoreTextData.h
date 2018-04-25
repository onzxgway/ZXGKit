//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CoreTextData : NSObject

@property (nonatomic) CTFrameRef ctFrame;
@property (nonatomic) CGFloat height;

@property (strong, nonatomic) NSArray * imageArray;
@property (strong, nonatomic) NSArray * linkArray;

@end
