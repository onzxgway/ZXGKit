//
//  ZXGPerson.h
//  零碎知识点
//
//  Created by feizhu on 2018/3/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXGPerson : NSObject {
    //默认访问权限是 protected
    //1.
    @private
    NSString *_name;
}

//@property (nonatomic, copy  ) NSString *name; 这句话相当于
@property (nonatomic) CGFloat height;
@property (nonatomic) NSInteger age;

//2.
- setName:(NSString *)name;

- (NSString *)name;

@end
