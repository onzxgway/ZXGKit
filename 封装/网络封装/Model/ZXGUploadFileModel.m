//
//  ZXGUploadFileModel.m
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGUploadFileModel.h"
#import "JZStringMacrocDefine.h"

@implementation ZXGUploadFileModel

+ (ZXGUploadFileModel *)fileWithImage:(UIImage *)image {
    return [[self alloc] initWithImage:image];
    
}
+ (ZXGUploadFileModel *)fileWithImageData:(NSData *)imageData {
    return [[self alloc] initWithImageData:imageData];
    
}
+ (ZXGUploadFileModel *)fileWithFileFullPath:(NSString *)filePath {
    return [[self alloc] initWithFileFullPath:filePath];
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

- (instancetype)initWithImageData:(NSData *)imageData {
    self = [super init];
    if (self) {
        self.fileData = imageData;
    }
    return self;
}

- (instancetype)initWithFileFullPath:(NSString *)filePath {
    self = [super init];
    if (self) {
        self.fileFullPath = filePath;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.fileData = UIImageJPEGRepresentation(image, 0.75);
}

- (void)setFileData:(NSData *)fileData {
    _fileData = fileData;
//    if (!fileData) {
//        _fileType = @"png";
//        _fileName = [NSString stringWithFormat:@"%@%@.%@",[JZDataHandler currentTimeString],[self randomNameString],self.fileType];
//        return;
//    }
//    YYImageType imageType =  YYImageDetectType((__bridge CFDataRef)fileData);
//    NSString * fileType = YYImageTypeGetExtension(imageType);
//    if (!JZStringIsNull(fileType)) {
//        self.fileType = fileType;
//    }else{
//        self.fileType = @"png";
//    }
//    self.fileName = [NSString stringWithFormat:@"%@%@.%@",[JZDataHandler currentTimeString],[self randomNameString],self.fileType];
//
}

- (void)setFileFullPath:(NSString *)fileFullPath {
    _fileFullPath = fileFullPath;
    if (JZStringIsNull(fileFullPath)) {
//        self.fileType = @"mp4";
//        self.fileName = [NSString stringWithFormat:@"%@%@.%@",[JZDataHandler currentTimeString],[self randomNameString],self.fileType];
        return;
    }
    NSString *extension = [fileFullPath pathExtension];
    if (!JZStringIsNull(extension)) {
//        self.fileType = extension;
    }
    NSString *lastPathComponent = [fileFullPath lastPathComponent];
    if (!JZStringIsNull(lastPathComponent)) {
//        self.fileName = lastPathComponent;
    }
}

@end
