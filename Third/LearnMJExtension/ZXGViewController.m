//
//  ZXGViewController.m
//  Third
//
//  Created by 朱献国 on 2018/5/30.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGViewController.h"
#import "MJUser.h"
#import "MJStatus.h"
#import "MJStatusResult.h"
#import "MJAd.h"
#import "MJStudent.h"
#import "MJBag.h"

@interface ZXGViewController ()

@end

@implementation ZXGViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRandomColor;
    
    [self demo];
}

#pragma mark - CreateViews

#pragma mark - Private
// 简单的字典 -> 模型（key替换，比如ID和id。多级映射，比如 oldName 和 name.oldName）
- (void)demo {
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"好孩子",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{@"nameChangedTime" : @"2013-08-07"}
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"小书包",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    
    // 2.将字典转为MJUser模型
    MJStudent *stu = [MJStudent mj_objectWithKeyValues:dict];
    
    // 3.打印MJUser模型的属性
    // 3.打印MJStudent模型的属性
    NSLog(@"ID=%@, desc=%@, otherName=%@, oldName=%@, nowName=%@, nameChangedTime=%@", stu.ID, stu.desc, stu.otherName, stu.oldName, stu.nowName, stu.nameChangedTime);
    NSLog(@"bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
}

// 复杂的字典 -> 模型 (模型的数组属性里面又装着模型)
- (void)demo4 {
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    // 2.将字典转为MJUser模型
    MJStatusResult *result = [MJStatusResult mj_objectWithKeyValues:dict];
    
    // 3.打印MJStatusResult模型的简单属性
    NSLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    for (MJStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (MJAd *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

// 复杂的字典 -> 模型 (模型里面包含了模型)
- (void)demo3 {
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"text" : @"是啊，今天天气确实不错！",
                           
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           
                           @"retweetedStatus" : @{
                                   @"text" : @"今天天气真不错！",
                                   
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    
    // 2.将字典转为MJUser模型
    MJStatus *status = [MJStatus mj_objectWithKeyValues:dict];
    
    // 3.打印MJUser模型的属性
    NSLog(@"%@", status);
}

// JSON字符串 --> 模型
- (void)demo2 {
    // 1.定义一个JSON字符串
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20, \"height\":333333.7}";
    
    // 2.将字典转为MJUser模型
    MJUser *user = [MJUser mj_objectWithKeyValues:jsonString];
    
    // 3.打印MJUser模型的属性
    NSLog(@"%@", user);
}

// 字典 --> 模型
- (void)demo1 {
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @"20",
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"1"
                           };
    // 2.将字典转为MJUser模型
    MJUser *user = [MJUser mj_objectWithKeyValues:dict];
    
    // 3.打印MJUser模型的属性
    NSLog(@"%@", user);
}

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
