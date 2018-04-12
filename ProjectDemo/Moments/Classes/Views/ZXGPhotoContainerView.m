//
//  XVPhotoContainerView.m
//  MaoMeng
//
//  Created by feizhu on 2017/12/26.
//  Copyright © 2017年 xiaov. All rights reserved.
//


#import "ZXGPhotoContainerView.h"
//#import "SDPhotoBrowser.h"
//#import "ResponseDynamicList.h"
//#import "XVDynamicDefines.h"
//#import "ResponseDynamicList.h"

@interface ZXGPhotoContainerView () //<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArr;//配图集合

@property (nonatomic, strong) UIImageView *videoImg; //视频首帧图片

@end

@implementation ZXGPhotoContainerView

#pragma mark - Overwrite
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Initial
- (void)setup {
    self.backgroundColor = kRandomColor;

    //配图
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [tempArr addObject:imageView];
        [self addSubview:imageView];
    }
    
    self.imageViewsArr = [tempArr copy];

    //视频首帧图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    imageView.tag = 10;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    self.videoImg = imageView;
    
    
    //▶️图片
    UIImageView *playImg = [[UIImageView alloc] init];
    playImg.contentMode = UIViewContentModeScaleAspectFit;
    playImg.image = GET_IMAGE(@"video_play");
    [imageView addSubview:playImg];
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(imageView);
        make.width.height.mas_equalTo(38);
    }];
}

#pragma mark - Setter
- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray {
    _picPathStringsArray = picPathStringsArray;
    //隐藏视频配图
    self.videoImg.hidden = YES;
    
    //隐藏不需要显示的imageView
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }

    if (_picPathStringsArray.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        return;
    }

    if (picPathStringsArray.count == 1) {
        CGSize singleImgSize = CGSizeZero;

        CGFloat maxW = SCREEN_WIDTH * 0.6;
        CGFloat maxH = SCREEN_HEIGHT * 0.25;

        CGFloat singleW = [_model.singleWidth floatValue];
        CGFloat singleH = [_model.singleHeight floatValue];
        NSLog(@"—————:%f", singleW);

        if (singleW > singleH) { //以宽为准  横图
            if (singleW >= maxW) {
                singleImgSize = CGSizeMake(maxW, maxW * (singleH / singleW));
                NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
            }
            else if (singleW < maxW) {
                singleImgSize = CGSizeMake(singleW, singleH);
                NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
            }
        }
        else if (singleW < singleH) { //以高为准 竖图
            if (singleH >= maxH) {
                singleImgSize = CGSizeMake(maxH * (singleW / singleH), maxH);
                NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
            }
            else if (singleH < maxH) {
                singleImgSize = CGSizeMake(singleW, singleH);
                NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
            }
        }
        else if (singleW == singleH) { //宽=高 正方形图片
            if (maxW > maxH) {

                if (maxH >= singleH) {
                    singleImgSize = CGSizeMake(singleW, singleH);
                }
                else if (maxH < singleH) {
                    singleImgSize = CGSizeMake(maxH, maxH);
                }
            }
            else if (maxW < maxH) {
                singleImgSize = CGSizeMake(maxW, maxW);

                if (maxW >= singleH) {
                    singleImgSize = CGSizeMake(singleW, singleH);
                }
                else if (maxW < singleH) {
                    singleImgSize = CGSizeMake(maxW, maxW);
                }
            }
            else if (maxW == maxH) {
                if (maxH >= singleH) {
                    singleImgSize = CGSizeMake(singleW, singleH);
                }
                else if (maxH < singleH) {
                    singleImgSize = CGSizeMake(maxH, maxH );
                }
            }
        }

        //兼容老版本图片
        if (CGSizeEqualToSize(CGSizeZero, singleImgSize)) {
            singleImgSize = CGSizeMake(100, 100);
        }

        [_picPathStringsArray enumerateObjectsUsingBlock:^(images *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;

            [imageView sd_setImageWithURL:URL(obj.imageUrl) placeholderImage:PlaceholderImage_Image];

            imageView.frame = CGRectMake(0, 0, singleImgSize.width, singleImgSize.height);
        }];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(singleImgSize);
        }];
    }
    else {

        CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
        //    CGFloat itemH = 0;
        //    if (_picPathStringsArray.count == 1) {
        //        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        //        if (image.size.width) {
        //            itemH = image.size.height / image.size.width * itemW;
        //        }
        //    }
        //    else {
        CGFloat itemH = itemW;
        //    }
        NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];

        [_picPathStringsArray enumerateObjectsUsingBlock:^(images *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            NSInteger columnIndex = idx % perRowItemCount;
            NSInteger rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;

            [imageView sd_setImageWithURL:URL(obj.imageUrl) placeholderImage:PlaceholderImage_Image];

            imageView.frame = CGRectMake(columnIndex * (itemW + ImgMargin), rowIndex * (itemH + ImgMargin), itemW, itemH);
        }];

        CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * ImgMargin;
        int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * ImgMargin;

        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
        }];
    }
}

- (void)setCoverUrl:(NSString *)coverUrl {
    _coverUrl = coverUrl;

    //隐藏所有的配图imageView
    for (long i = 0; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }

    CGSize singleImgSize = CGSizeZero;

    CGFloat maxW = SCREEN_WIDTH * 0.6;
    CGFloat maxH = SCREEN_HEIGHT * 0.25;

    CGFloat singleW = [_model.singleWidth floatValue];
    CGFloat singleH = [_model.singleHeight floatValue];

    if (singleW > singleH) { //以宽为准  横图
        if (singleW >= maxW) {
            singleImgSize = CGSizeMake(maxW, maxW * (singleH / singleW));
            NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
        }
        else if (singleW < maxW) {
            singleImgSize = CGSizeMake(singleW, singleH);
            NSLog(@"以宽为准:%@",NSStringFromCGSize(singleImgSize));
        }
    }
    else if (singleW < singleH) { //以高为准 竖图
        if (singleH >= maxH) {
            singleImgSize = CGSizeMake(maxH * (singleW / singleH), maxH);
            NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
        }
        else if (singleH < maxH) {
            singleImgSize = CGSizeMake(singleW, singleH);
            NSLog(@"以高为准:%@",NSStringFromCGSize(singleImgSize));
        }
    }
    else if (singleW == singleH) { //宽=高 正方形图片
        if (maxW > maxH) {

            if (maxH >= singleH) {
                singleImgSize = CGSizeMake(singleW, singleH);
            }
            else if (maxH < singleH) {
                singleImgSize = CGSizeMake(maxH, maxH);
            }
        }
        else if (maxW < maxH) {
            singleImgSize = CGSizeMake(maxW, maxW);

            if (maxW >= singleH) {
                singleImgSize = CGSizeMake(singleW, singleH);
            }
            else if (maxW < singleH) {
                singleImgSize = CGSizeMake(maxW, maxW);
            }
        }
        else if (maxW == maxH) {
            if (maxH >= singleH) {
                singleImgSize = CGSizeMake(singleW, singleH);
            }
            else if (maxH < singleH) {
                singleImgSize = CGSizeMake(maxH, maxH);
            }
        }
    }

    //兼容老版本图片
    if (CGSizeEqualToSize(CGSizeZero, singleImgSize)) {
        singleImgSize = CGSizeMake(100, 100);
    }

    //首帧
    self.videoImg.hidden = NO;
    self.videoImg.frame = CGRectMake(0, 0,  singleImgSize.width, singleImgSize.height);

    [self.videoImg sd_setImageWithURL:URL(coverUrl) placeholderImage:PlaceholderImage_Image];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(singleImgSize);
    }];
}

#pragma mark - Events
- (void)tapImageView:(UITapGestureRecognizer *)tap {

//    if (tap.view.tag == 10) {
//        if (self.playCallback) {
//            self.playCallback();
//        }
//        return;
//    }
//
//    UIView *imageView = tap.view;
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    browser.currentImageIndex = imageView.tag;
//    browser.sourceImagesContainerView = self;
//    browser.imageCount = self.picPathStringsArray.count;
//    browser.delegate = self;
//    [browser show:_model.comments];
}

#pragma mark - Private
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array {

    if (array.count == 1) {
        return 120;
    }
    else {
        return (PicsAndCommentW - 2 * ImgMargin) / 3;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array {

    if (array.count < 3) {
        return array.count;
    }
    else if (array.count <= 4) {
        return 2;
    }
    else {
        return 3;
    }
}

#pragma mark - SDPhotoBrowser Delegate
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
//
//    NSString *imageName = self.picPathStringsArray[index];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
//    return url;
//}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {

    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
