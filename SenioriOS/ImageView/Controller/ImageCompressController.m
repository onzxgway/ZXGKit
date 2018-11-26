//
//  ImageCompressController.m
//  ImageView
//
//  Created by 朱献国 on 2018/11/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ImageCompressController.h"

@interface ImageCompressController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImage *_albumImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *pngImageV;
@property (weak, nonatomic) IBOutlet UIImageView *jpgImageV;

@end

@implementation ImageCompressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"压缩相册图片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum:)];
}

/**
 
 图片 是像素点的集合，每个像素点是一个独立明了的颜色RGBA。当成千上万的像素点合到一起以后，就构成了图片。
 
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    _albumImage = [UIImage imageNamed:@"3.jpg"]; // 原图 836 kb CGSizeMake(4288, 2848)
//    _albumImage = [self scaleImage:[UIImage imageNamed:@"3.jpg"] size:_albumImage.size];
    
    if (_albumImage) {
        [self imageDataLoad];
    }
    
}

// 图片压缩 压缩图片质量
// 直接格式转换压缩 png(RGBA) jpg(RGB)
// 文件属性格式并不会压缩，压缩的是图片内容（像素）
- (void)imageDataLoad {
    
    NSData *pngImageData = UIImagePNGRepresentation(_albumImage);           // 压缩后 18Mb 427Kb
    NSData *jpgImageData = UIImageJPEGRepresentation(_albumImage, 0.1);     // 通过UIImage和NSData的相互转化，减小 JPEG 图片的质量来压缩图片。UIImageJPEGRepresentation::第二个参数compression 取值 0.0~1.0，值越小表示图片质量越低，图片文件自然越小。
    
    _pngImageV.image = [UIImage imageWithData:pngImageData];
    _jpgImageV.image = [UIImage imageWithData:jpgImageData];
    
    NSLog(@"png::%@", [self length:pngImageData.length]);
    NSLog(@"jpg::%@", [self length:jpgImageData.length]);
    
}

// 图片压缩 压缩图片尺寸
// Context重新绘制
// bitmap
- (UIImage *)scaleImage:(UIImage *)image size:(CGSize)imageSize {
    
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

// 获取图片的大小
- (NSString *)length:(NSUInteger)length {
    
    if (length > 1024 * 1024) { // M
        
        unsigned long mb = length / (1024*1024);
        unsigned long kb = (length % (1024*1024)) / 1024;
        return [NSString stringWithFormat:@"%luMb %luKb", mb, kb];
    }
    else { // K
        return [NSString stringWithFormat:@"%luKb", length / 1024];
    }
    
    return @"";
}


/**
 两种压缩方式对比：
 
 1.压缩图片质量
 优点：尽可能保留图片清晰度，图片不会明显模糊；
 缺点：不能保证图片压缩后小于指定大小；
 
 2.压缩图片尺寸
 优点：可以使图片小于指定大小；
 缺点：图片明显模糊(比压缩图片质量模糊)；
 */

- (void)openAlbum:(id)sender{
    
    UIImagePickerController *imagePickerContr = [[UIImagePickerController alloc] init];
    imagePickerContr.delegate = self;
    imagePickerContr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerContr animated:YES completion:nil];
    
}

#pragma mark - UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%s", __func__);
    
    _albumImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    NSLog(@"%s", __func__);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
