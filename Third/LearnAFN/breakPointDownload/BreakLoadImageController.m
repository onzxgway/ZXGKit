//
//  BreakLoadImageController.m
//  LearnAFN
//
//  Created by onzxgway on 2019/3/28.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "BreakLoadImageController.h"
// NSURLSessionDelegate -> NSURLSessionTaskDelegate -> NSURLSessionDataDelegate
@interface BreakLoadImageController () <NSURLSessionDelegate>

@end

@implementation BreakLoadImageController {
    NSString *_tmp;
    NSString *_document;
    NSOutputStream *_outputStream;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    NSString *fileName = [[ImageURL componentsSeparatedByString:@"/"] lastObject];
    _document = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    _tmp = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    _outputStream = [[NSOutputStream alloc] initToFileAtPath:_tmp append:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self loadImage];
}

// NSURLSessionDataTask网络请求，通过代理（NSURLSession代理）或者 block（dataTask回调）获取下载的数据。相比较的话，代理的数据更全面。
- (void)loadImage {
    
//    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
//    ephemeralSessionConfiguration 不带缓存 defaultSessionConfiguration带缓存
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ImageURL]];
    
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:_tmp error:nil];
    long fileSize = [[fileInfo objectForKey:NSFileSize] longValue];
    [request setValue:[NSString stringWithFormat:@"bytes=%ld-", fileSize] forHTTPHeaderField:@"Range"];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
//    [_outputStream open];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [_outputStream write:[data bytes] maxLength:data.length];
//    }];
    
    [dataTask resume];
    
}

#pragma mark - NSURLSessionDelegate
// 响应头  这次网络数据的属性（下载的总数据大小 content-Length, Content-Type）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [_outputStream open];
    completionHandler(NSURLSessionResponseAllow);
}

// 数据接收
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    // 重复开启关闭流通道，及其耗费性能
//    NSMutableData *doneData = [NSMutableData dataWithContentsOfFile:_tmp];
//    if (!doneData) {
//        doneData = [NSMutableData data];
//    }
//    [doneData appendData:data];
//    [doneData writeToFile:_tmp atomically:YES];
    [_outputStream write:[data bytes] maxLength:data.length];
}

// 完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
    [_outputStream close];
    [[NSFileManager defaultManager] moveItemAtPath:_tmp toPath:_document error:nil];
    
}

@end
