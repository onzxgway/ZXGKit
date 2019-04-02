//
//  InputStreamController.m
//  LearnAFN
//
//  Created by onzxgway on 2019/4/2.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "InputStreamController.h"

@interface InputStreamController () <NSURLSessionDataDelegate>

@end

@implementation InputStreamController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self inputStream];
}

- (void)inputStream {
    NSString *str = @"name=kobe&age=38";
    
    NSInputStream *input = [NSInputStream inputStreamWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [input open];
    
    // 读取小等于指定字节的数据，放入指定缓存中
    uint8_t buffer[256];
    memset(buffer, 0, 256); // 新申请的内存做初始化工作
    [input read:buffer maxLength:5];
    NSLog(@"%s", buffer);
    
    memset(buffer, 0, 256); // 新申请的内存做初始化工作
    [input read:buffer maxLength:4];
    NSLog(@"%s", buffer);
    
    [input close];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self netLoadDelegate];
}

- (void)netLoadDelegate {
    NSString *bodyStr = @"versions_id=1&system_type=1";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLPath]];
    [request setValue:@"en;q=1" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"LoadUpdateNet/1.0 (iPhone; iOS 11.1; Scale/3.00)" forHTTPHeaderField:@"User-Agent"];
    request.HTTPMethod = @"POST";
    
    
//    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSInputStream *inputS = [[NSInputStream alloc] initWithData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBodyStream = inputS; // 请求的时候，系统底层会对NSInputStream执行read操作
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 反序列化
    NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", infoDict);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
}

@end
