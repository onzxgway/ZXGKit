//
//  main.m
//  ScrollView回收键盘方式
//
//  Created by 朱献国 on 2018/5/20.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //0.设置ScrollView的keyboardDismissMode属性(前提是ScrollView可以滚动)
        self.ScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        //1.自定义ScrollView类，在内部重写touchesBegan等方法。
        
        //2.加蒙版
        NSLog(@"Hello, World!");
    }
    return 0;
}
