//
//  ZXGDBOperation.m
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGDBOperation.h"

@implementation ZXGDBOperation

- (NSString *)dbPath {
    NSString *fileDir = [self fileDirectoryPath:@"database"];
    
    if (fileDir && ![@"" isEqualToString:fileDir]) {
        
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isDir;
        BOOL isExists = [manager fileExistsAtPath:fileDir isDirectory:&isDir];
        if (!isExists || !isDir) {
            [manager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return [fileDir stringByAppendingPathComponent:@"database.sqlite"];
    }
    
    return nil;
}

- (NSString *_Nullable)fileDirectoryPath:(NSString *_Nonnull)pathComponent {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:pathComponent];
}

@end
