//
//  MemoryLeakController.m
//  Memory
//
//  Created by 朱献国 on 2018/10/9.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "MemoryLeakController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <CoreText/CoreText.h>
#import <MLeaksFinder.h>

@interface TestNSTimer: NSObject

@property (nonatomic, strong) NSTimer *timer;

- (void)cleanTimer;

@end

@implementation TestNSTimer

- (instancetype)init {
    if(self = [super init]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeRefresh:(NSTimer *)timer {
    NSLog(@"TimeRefresh...");
}

- (void)cleanTimer {
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)dealloc {
    NSLog(@"NSTimer对象 销毁了");
    [self cleanTimer];
}

@end


@interface MemoryLeakController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TestNSTimer *timer;

@end

// AAAAA 产生内存泄露的原因

/**
 一、三方框架使用不当
 
 二、Block循环引用
 
 三、delegate循环引用
 
 四、NSTimer循环引用
 
 五、非OC对象内存处理
 
 六、地图类处理
 
 七、大次数循环内存暴涨问题
 */

// AAAAA 如何使用Xcode检测内存泄露
/**
 一、Product -> Analyze
 
 二、debug memory graph
 
 三、instruments Leak
 */

// AAAAA 如何使用三方工具检测内存泄露
/**
 一、MLeaksFinder 只对 UIView 和 UIViewController 对象有效。
 */

@implementation MemoryLeakController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self two];
    
}

// 七、大次数循环内存暴涨问题
/**
 该循环内产生大量的临时对象，直至循环结束才释放，可能导致内存泄漏，解决方法为在循环中创建自己的autoReleasePool，及时释放占用内存大的临时变量，减少内存占用峰值。
 */
- (void)seven {
    
    for(int i = 0; i < 100000; i++) {
        
        @autoreleasepool {
            NSString *string = @"Abc";
            
            string = [string lowercaseString];
            
            string = [string stringByAppendingString:@"xyz"];
            
            NSLog(@"%@", string);
        }
        
    }
    
}

// 五、非OC对象内存处理 == 非ARC管辖范围的对象
/**
 CoreFoundation框架 ,CoreText框架等等
 */
- (void)five {
    
    CFStringRef stringRef = CFStringCreateWithCString(kCFAllocatorDefault, "Hello world!", kCFStringEncodingUTF8);
    CFRetain(stringRef);
    NSLog(@"%zd", CFGetRetainCount(stringRef));
    
    CGFloat fontSize = 14.f;
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    
    CFRelease(stringRef);
    CFRelease(stringRef);
    CFRelease(fontRef);
    
}

// 四、NSTimer循环引用
/**
 当前类销毁执行dealloc的前提是定时器需要停止并滞空，而定时器停止并滞空的时机在当前类调用dealloc方法时，这样就造成了互相等待的场景，从而内存一直无法释放。因此需要注意cleanTimer的调用时机从而避免内存无法释放，如上的解决方案为将cleanTimer方法外漏，在外部调用即可。
 */
- (void)four {
   self.timer = [[TestNSTimer alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer cleanTimer];

}

// 二、Block循环引用
- (void)two {
    
    __weak typeof(MemoryLeakController *) ws = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        __strong typeof(MemoryLeakController *) ss = ws;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            self.tableView.backgroundColor = UIColor.redColor;
        });
        
    }];
    
}


// 一、三方框架使用不当
/**
 1.在使用 AFNetworking 的时候，会出现内存泄漏的问题。（通过 debug memory graph 和 instruments leak 都可以检测出内存泄露）
 
   解决方案：在封装网络请求类时需注意的是要将请求队列管理者AFHTTPSessionManager声明为单例创建形式。对于该问题，AFNetWorking的作者在gitHub上也指出建议使用者在相同配置下保证AFHTTPSessionManager只有一个，进行全局管理，因此我们可以通过单例形式进行解决。
 */
- (void)one {
    [self GET:@"https://www.baidu.com" parameters:nil returnData:nil];
    
    [self GET1:@"https://www.baidu.com" parameters:nil returnData:nil];
    
    [self GET2:@"https://www.baidu.com" parameters:nil returnData:nil];
}

- (AFHTTPSessionManager *)defaultNetManager {
    
    static AFHTTPSessionManager *manager;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHTTPSessionManager alloc] init];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    
return manager;
    
}
    
- (void)GET:(NSString *)url parameters:(NSDictionary *)parameter returnData:(void(^)(NSData *resultData, NSError *error))returnBlock {
    
    // 请求队列管理者 单例形式创建 防止内存泄漏
    AFHTTPSessionManager *manager = [self defaultNetManager];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (returnBlock) returnBlock(responseObject,nil);
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (returnBlock) returnBlock(nil,error);
        }];
    
}

- (void)GET1:(NSString *)url parameters:(NSDictionary *)parameter returnData:(void(^)(NSData *resultData, NSError *error))returnBlock {
    
    // 请求队列管理者 单例形式创建 防止内存泄漏
    AFHTTPSessionManager *manager = [self defaultNetManager];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (returnBlock) returnBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (returnBlock) returnBlock(nil,error);
    }];
    
}

- (void)GET2:(NSString *)url parameters:(NSDictionary *)parameter returnData:(void(^)(NSData *resultData, NSError *error))returnBlock {
    
    // 请求队列管理者 单例形式创建 防止内存泄漏
    AFHTTPSessionManager *manager = [self defaultNetManager];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (returnBlock) returnBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (returnBlock) returnBlock(nil,error);
    }];
    
}

@end
