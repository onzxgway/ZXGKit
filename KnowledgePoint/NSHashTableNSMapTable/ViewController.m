//
//  ViewController.m
//  NSHashTableNSMapTable
//
//  Created by feizhu on 2018/3/6.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Favourite.h"

@interface ViewController ()
@property (nonatomic, strong) NSMapTable *mapTable;
@end

/**
    1.NSDictionary有一个可变的类型即NSMutableDictionary，然而NSMapTable没有另外一个可变类，因为它本身就是可变的。
    2.NSDictionary或者NSMutableDictionary中对于key和value的内存管理是，对key进行copy，对value进行强引用。而NSMapTable可以设定key和value的内存管理类型，


 NSDictionary 的局限性:

 NSDictionary 提供了 key -> object 的映射。从本质上讲，NSDictionary 中存储的 object 位置是由 key 来索引的。
 由于对象存储在特定位置，NSDictionary 中要求 key 的值不能改变（否则 object 的位置会错误）。为了保证这一点，NSDictionary 会始终复制 key 到自己私有空间。

 这个 key 的复制行为也是 NSDictionary 如何工作的基础，但这也有一些限制：
 1.你只能使用 OC 对象作为 NSDictionary 的 key，并且必须支持 NSCopying 协议。
 2.key 应该是小且高效的，以至于复制的时候不会对 CPU 和内存造成负担。

 这意味着，NSDictionary 中真的只适合将值类型的对象作为 key（如简短字符串和数字）。并不适合自己的模型类来做对象到对象的映射。


 对象到对象的映射:

 NSMapTable更适合于一般来说的映射概念。这取决于它的设计方式，NSMapTable 可以处理的 key -> obj 式映射如 NSDictionary，但它也可以处理 obj -> obj 的映射 - 也被称为 “关联数组” 或简称为 “map”。

 比如一个 NSMapTable 的构造如下：
 NSMapTable *keyToObjectMapping =
 [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn
 valueOptions:NSMapTableStrongMemory];
 这将会和 NSMutableDictionary 用起来一样一样的，复制 key，并对它的 object 引用计数 +1。

 一个真正的对象到对象(object-to-object)的映射可以构造如下：
 NSMapTable *objectToObjectMapping = [NSMapTable mapTableWithStrongToStrongObjects];
 一个对象到对象(object-to-object)的行为可能以前可以用 NSDictionary 来模拟，如果所有的 key 都是一个 NSNumber 来指向该映射的源对象的内存地址，但这些内存地址都是不可控的，Cocoa 中首次提供了一个真正的对象到对象的映射集合类型那就是 NSMapTable。
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self NSMapTable];
}

- (void)NSHashTable {

}

- (void)NSMapTable {
    Person *p1 = [[Person alloc] initWithName:@"jack"];
    Favourite *f1 = [[Favourite alloc] initWithName:@"ObjC"];

    Person *p2 = [[Person alloc] initWithName:@"rose"];
    Favourite *f2 = [[Favourite alloc] initWithName:@"Swift"];

    NSMapTable *MapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
    _mapTable = MapTable;
    // 设置对应关系表
    // p1 => f1;
    // p2 => f2
    [MapTable setObject:f1 forKey:p1];
    [MapTable setObject:f2 forKey:p2];

    NSLog(@"%@ %@", p1, [MapTable objectForKey:p1]);
    NSLog(@"%@ %@", p2, [MapTable objectForKey:p2]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%zd", [_mapTable count]);
}


@end
