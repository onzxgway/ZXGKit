//
//  ViewController.m
//  NSCache
//
//  Created by feizhu on 2018/2/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;
@end

@implementation ViewController

/**
 NSCache是苹果官方提供的 内存缓存类，类似于 NSDictionary 集合，key-value形似存储。

 NSCache优于NSDictionary之处在于:

 1.当内存资源将要耗尽时，它可以自动删减缓存。普通的字典需要在系统发出“低内存”通知时手工删减缓存。
   NSCache类结合了各种自动删除策略，以确保不会占用过多的系统内存。如果其它应用需要内存时，系统自动执行这些策略。当调用这些策略时，会从缓存中删除一些对象，以最大限度减少内存的占用。
 2.NSCache是线程安全的，我们可以在不同的线程中添加、删除和查询缓存中的对象，而不需要锁定缓存区域。
 3.不像NSMutableDictionary对象，一个缓存对象不会拷贝key对象。很多时候，键都是不支持拷贝操作的对象来充当的。因此，NSCache不会自动拷贝键，所以说，在键不支持拷贝操作的情况下，该类用起来比字典更方便。

 总结：1.自动删减功能。2.线程安全的。3.不会拷贝键。4.可以指定缓存的数量和成本的概念。
 */
- (IBAction)clicked:(id)sender {
}

/**
使用场景:
    1.临时存储短时间使用但创建昂贵的对象。重用这些对象可以优化性能，因为它们的值不需要重新计算。比如那些需要从网络获取或从磁盘读取的数据。
    2.这些对象对于程序来说不是紧要的，在内存紧张时会被丢弃。如果对象被丢弃了，则下次使用时需要重新计算。
*/
- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"我是第%d个",i];
        [self.cache setObject:str forKey:@(i)];
        NSLog(@"%@", [self.cache objectForKey:@(i)]);
    }
}

- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 5;
        _cache.delegate = self;
    }
    return _cache;
}

#pragma mark - NSCacheDelegate
// 缓存将要删除对象时调用，不能在此方法中修改缓存
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"被删除的对象是:%@",obj);
    /**
     从运行结果能看出,_cache只保存了最新的5个字符串,最先加入的5个字符串后来被删除掉了,但是文档也指出了countLimit并不是一个严格的限制,如果cache数量超出了limit,那么cache中的对象有可能立刻被清理出去,或者稍后,或者永远都不会被清理掉,而这个时机依赖于cache的实现细节
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
