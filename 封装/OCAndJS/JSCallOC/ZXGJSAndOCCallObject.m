//
//  ZXGJSAndOCInterObject.m
//  OCAndJS
//
//  Created by 朱献国 on 2018/4/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGJSAndOCCallObject.h"

@implementation ZXGJSAndOCCallObject

#pragma mark - JSExport Methods
- (void)calculateWithNumber:(NSNumber *)number {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calculateWithNumber:)]) {
        return [self.delegate calculateWithNumber:number];
    }
    
}

//上传开通会员的值
- (NSString *)getData {
    
    return nil;
}

- (void)pushViewController:(NSString *)view title:(NSString *)title {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:title:)]) {
        return [self.delegate pushViewController:view title:title];
    }
}

@end
