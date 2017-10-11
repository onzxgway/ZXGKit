//
//  main.m
//  项目配置文件
//
//  Created by san_xu on 2017/10/11.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 项目中的常见文件
void projectFile() {
    //获取项目的配置文件(项目配置都在该文件中) info.plist文件
    //方式一：
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    //    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //方式二：
    NSDictionary *Info = [NSBundle mainBundle].infoDictionary;
    
    NSLog(@"%@",Info);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        projectFile();
    }
    return 0;
}

