//
//  CoreTextLinkData.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * url;
@property (nonatomic) NSRange range;

@end
