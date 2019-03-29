//
//  UploadFileController.m
//  LearnAFN
//
//  Created by onzxgway on 2019/3/29.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "UploadFileController.h"

@interface UploadFileController () <NSURLSessionDelegate>

@end

@implementation UploadFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self uploadImage];
}

// 文件上传
- (void)uploadImage {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:UploadImageURL]];
    
    // 配置请求头和请求体
    NSString *bounary = @"******"; // 分界线
    // 一 配置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;charset=utf-8;boundary=%@", bounary]  forHTTPHeaderField:@"Content-Type"];
    // 二 配置请求体
    NSMutableData *bodyData = [NSMutableData data];
    // 1 开始边界
    NSString *beginBoundary = [NSString stringWithFormat:@"--%@\r\n", bounary];
    [bodyData appendData:[beginBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    // 2 属性 name和服务的name要匹配,相当于服务获取图片的key
    //  filename 服务器图片文件命名
    NSString *serverFileKey = @"image";
    NSString *serverFileName = @"101.png";
    NSString *serverContentTypes = @"image/png";
    
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\" \r\n", serverFileKey, serverFileName];
    [string appendFormat:@"Content-Type: %@\r\n", serverContentTypes];
    [string appendFormat:@"\r\n"];
    [bodyData appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 3 文件数据
    UIImage *image = [UIImage imageNamed:@"1"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [bodyData appendData:imageData];
    
    // 4 结束边界
    NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@", bounary];
    [bodyData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = bodyData;
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

//1 响应头
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    completionHandler(NSURLSessionResponseAllow);
}


// 2 进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    
    NSLog(@"didSendBodyData:: %lld--%lld--%lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
}

// 3 上传结束
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"didReceiveData::%@", infoDict);
    
}

@end
