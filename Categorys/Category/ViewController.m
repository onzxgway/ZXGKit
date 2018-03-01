//
//  ViewController.m
//  Categorys
//
//  Created by feizhu on 2018/1/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "iOSDeviceConfig.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self testStringFun];
    [self testImageFun];

    NSLog(@"__%zd__", [iOSDeviceConfig sharedConfig].isIOS11Later);
}

- (void)testStringFun {

    NSString *res = [@"\naaa  bbb ccc\n" trim];
    NSLog(@"__%@__", res);
}

- (void)testImageFun {
    // 1.获取指定颜色和大小的图片
    //    self.rightImg.image = [UIImage imageWithColor:kBlueColor];
    //    UIImage *img = [UIImage imageWithColor:kBlueColor size:CGSizeMake(50, 50)];
    //    self.rightImg.image = img;

    // 2.获取指定大小的随机颜色图片
    //    UIImage *img = [UIImage randomColorImageWith:CGSizeMake(50, 50)];
    //    self.rightImg.image = img;

    // 3.裁剪图片 (原图的左上角是坐标原点)
    // ------------- 原图 -----------
        UIImage *originImg = GET_IMAGE(@"aaa.png");
        self.leftLab.text = STRING_FORMAT(@"原图size:%@", NSStringFromCGSize(originImg.size));
        self.leftImg.image = originImg;


    // ------------- cropImage: -----------
    //    UIImage *croppedImg = [originImg cropImage:CGRectMake(0, 0, 80, 80)];

    // ------------- cropToRectImage: -----------
    //    UIImage *croppedImg = [originImg cropToRectImage:CGRectMake(0, 0, 80, 80)];

    // ------------- thumbnailWithSize: -----------
    //    UIImage *croppedImg = [originImg thumbnailWithSize:CGSizeMake(46, 356)];

    // ------------- rescaleImageToSize: -----------
    //    UIImage *croppedImg = [originImg rescaleImageToSize:CGSizeMake(46, 56)];

    // ------------- rescaleImageToSize: -----------


    // ------------- rotateDirection: -----------
    //    UIImage *croppedImg = [originImg rotateDirection:UIImageOrientationDown];

    //    UIImage *croppedImg = [UIImage imageWithColor:[originImg colorAtPixel:CGPointMake(30, 190)] size:CGSizeMake(50, 50)];

    //    UIImage *croppedImg = [UIImage imageFromView:self.leftImg];

    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"gif"];
    //    self.rightImg.image = [UIImage imageWithGIFURL:[NSURL fileURLWithPath:path]];
    //    self.rightImg.image = [UIImage imageWithGIFData:[NSData dataWithContentsOfFile:path]];

    //    UIImage *croppedImg = [UIImage mergeImage:GET_IMAGE(@"aaa") withImage:GET_IMAGE(@"bbb")];
    //     NSArray<UIImage *> *imgs = [UIImage splitImageIntoTwoParts:originImg];

//        UIImage *croppedImg = [originImg cutImageWithRadius:6];
//        self.rightLab.text = STRING_FORMAT(@"裁剪图size:%@", NSStringFromCGSize(croppedImg.size));
//        self.rightImg.image = croppedImg;

}


@end
