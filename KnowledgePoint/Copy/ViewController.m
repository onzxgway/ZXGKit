//
//  ViewController.m
//  copy
//
//  Created by san_xu on 2017/8/10.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Conference.h"
#import "Conferee.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test];
//    [self prcatice];
//    [self prac];
    [self deepCopy];
}

//多层深拷贝
- (void)deepCopy {

    Conferee *conferee1 = [[Conferee alloc] init];
    conferee1.name = @"yuan1";

    Conferee *conferee2 = [[Conferee alloc] init];
    conferee2.name = @"yuan2";

    Conferee *conferee3 = [[Conferee alloc] init];
    conferee3.name = @"yuan3";

    Conferee *conferee4 = [[Conferee alloc] init];
    conferee4.name = @"yuan4";

    Conferee *conferee5 = [[Conferee alloc] init];
    conferee5.name = @"yuan5";

    NSArray *arr = @[conferee1, conferee2, conferee3, conferee4, conferee5];
//    NSArray *mulDeepArr = [arr mutableCopy];
    NSArray *mulDeepArr = [[NSMutableArray alloc] initWithArray:arr copyItems:YES];

    NSLog(@"%p__Top__%p", arr, mulDeepArr);
    NSLog(@"%p__Bottom__%p", [arr firstObject], [mulDeepArr firstObject]);
}

- (void)test {

    /**
    NSString *name = @"abc";
    NSMutableString *muName = [[NSMutableString alloc] initWithFormat:@"123"];

    NSString *nameCopy = [name copy];
    NSMutableString *nameMutableCopy = [name mutableCopy];

    NSString *nameCop = [muName copy];
    NSMutableString *nameMutableCop = [muName mutableCopy];

    NSLog(@"%p____%p", muName, nameMutableCop);
//    NSLog(@"%@____%@", NSStringFromClass(object_getClass(nameCopy)), NSStringFromClass(object_getClass(nameMutableCopy)));
     */

    Conference *conference = [[Conference alloc] init];
    conference.conferenceID = @"part";
    Conference *conferenceCopy = [conference mutableCopy];
    conferenceCopy.conferenceID = @"total";
    
    if (conference == conferenceCopy) {
        NSLog(@"conference[%p] == conferenceCopy[%p]", conference, conferenceCopy);
    }
    else {
        NSLog(@"conference[%p] != conferenceCopy[%p]", conference, conferenceCopy);
        NSLog(@"%@__%@", conference.conferenceID, conferenceCopy.conferenceID);
    }

}

- (void)prcatice {
    /**
    //1,不可变容器 NSCopying返回receiver, 并且receiver的引用计数+1
    NSArray *array = [NSArray array];
    NSArray *arrayCopy = [array copy];
    if (array == arrayCopy) {
        NSLog(@"array[%p] == arrayCopy[%p]", array, arrayCopy);
    }
    else {
        NSLog(@"array[%p] != arrayCopy[%p]", array, arrayCopy);
    }


    //    NSMutableCopying由receiver中的数据构造一个新的可变实例
    NSArray *array = [NSArray array];
    NSMutableArray *arrayCopy = [array mutableCopy];
    if (array == arrayCopy) {
        NSLog(@"array[%p] == arrayCopy[%p]", array, arrayCopy);
    }
    else {
        NSLog(@"array[%p] != arrayCopy[%p]", array, arrayCopy);
    }

    
//    2,如果receiver是可变容器

    //    NSCopying由receiver中的数据构造一个新的不可变实例
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *arrayCopy = [mutableArray copy];
    if (mutableArray == arrayCopy) {
        NSLog(@"array[%p] == arrayCopy[%p]", mutableArray, arrayCopy);
    }
    else {
        NSLog(@"array[%p] != arrayCopy[%p]", mutableArray, arrayCopy);
    }


    //    NSMutableCopying由receiver中的数据构造一个新的可变实例
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSMutableArray *arrayCopy = [mutableArray mutableCopy];
    if (mutableArray == arrayCopy) {
        NSLog(@"array[%p] == arrayCopy[%p]", mutableArray, arrayCopy);
    }
    else {
        NSLog(@"array[%p] != arrayCopy[%p]", mutableArray, arrayCopy);
    }
     */
}

- (void)prac {
    Conferee *conferee = [[Conferee alloc] init];
    conferee.name = @"yuan";
    
    Conference *conference = [[Conference alloc] init];
    conference.conferenceID = @"ID_001";
    [conference.conferees addObject:conferee];
    Conference *conferenceCopy = [conference copy];

    /**
    if (conference == conferenceCopy) {
        NSLog(@"conference[%p] == conferenceCopy[%p]", conference, conferenceCopy);
    }
    else {
        NSLog(@"conference[%p] != conferenceCopy[%p]", conference, conferenceCopy);
    }


    if ([conference.conferees firstObject] == [conferenceCopy.conferees firstObject]) {
        NSLog(@"[conference.conferees firstObject][%p] == [conferenceCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceCopy.conferees firstObject]);
    }
    else {
        NSLog(@"[conference.conferees firstObject][%p] != [conferenceCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceCopy.conferees firstObject]);
    }


    Conference *conferenceShallowCopy = [conference shallowCopy];
    if (conference == conferenceShallowCopy) {
        NSLog(@"conference[%p] == conferenceShallowCopy[%p]", conference, conferenceShallowCopy);
    }
    else {
        NSLog(@"conference[%p] != conferenceShallowCopy[%p]", conference, conferenceShallowCopy);
    }

    if ([conference.conferees firstObject] == [conferenceShallowCopy.conferees firstObject]) {
        NSLog(@"[conference.conferees firstObject][%p] == [conferenceShallowCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceShallowCopy.conferees firstObject]);
    }
    else {
        NSLog(@"[conference.conferees firstObject][%p] != [conferenceShallowCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceShallowCopy.conferees firstObject]);
    }
     */


    Conference *conferenceDeepCopy = [conference deepCopy];
    if (conference == conferenceDeepCopy) {
        NSLog(@"conference[%p] == conferenceDeepCopy[%p]", conference, conferenceDeepCopy);
    }
    else {
        NSLog(@"conference[%p] != conferenceDeepCopy[%p]", conference, conferenceDeepCopy);
    }
    if ([conference.conferees firstObject] == [conferenceDeepCopy.conferees firstObject]) {
        NSLog(@"[conference.conferees firstObject][%p] == [conferenceDeepCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceDeepCopy.conferees firstObject]);
    }
    else {
        NSLog(@"[conference.conferees firstObject][%p] != conferenceDeepCopy.conferees firstObject][%p]", [conference.conferees firstObject], [conferenceDeepCopy.conferees firstObject]);
    }
    
}



@end
