//
//  TwoBreakLoadImageController.m
//  LearnAFN
//
//  Created by onzxgway on 2019/3/28.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "TwoBreakLoadImageController.h"

// NSURLSessionDelegate -> NSURLSessionTaskDelegate -> NSURLSessionDownloadDelegate
@interface TwoBreakLoadImageController ()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@end

@implementation TwoBreakLoadImageController {
    NSString *_tmp;
    NSString *_document;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    NSString *fileName = [[ImageURL componentsSeparatedByString:@"/"] lastObject];
    _document = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self loadImage];
}

// NSURLSessionDownloadTask网络请求，通过代理（NSURLSession代理）或者 block（dataTask回调）获取下载的数据。相比较的话，代理的数据更全面。

// 下载的数据自动写入沙盒下tmp目录中，未下载完的文件会一直保存，下载完成的话，会自动从目录中移除。
- (void)loadImage {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:nil];
    //    ephemeralSessionConfiguration 不带缓存 defaultSessionConfiguration带缓存
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ImageURL]];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:request];
    
    [dataTask resume];
    
}

#pragma mark - NSURLSessionDelegate
//1 响应头  这次网络数据的属性（下载的总数据大小 content-Length, Content-Type）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    completionHandler(NSURLSessionResponseAllow);
}

// 完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSError *error = nil;
    
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:_document] error:&error];
    
    if (error) {
        NSLog(@"%zd", error.code);
    }
}

// 过程
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // bytesWritten 当前包收到的数据 totalBytesWritten已经接受的数据 totalBytesExpectedToWrite图片数据大小
    NSLog(@"URLSession:%lld-%lld-%lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

@end
