//
//  Book.m
//  RAC
//
//  Created by feizhu on 2018/3/1.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [[Book alloc] init];

    book.title = dict[@"title"];
    book.subtitle = dict[@"subtitle"];
    
    return book;
}


@end
