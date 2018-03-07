//
//  ViewController.m
//  SDWebimage
//
//  Created by feizhu on 2018/3/6.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myPic;
@property (weak, nonatomic) IBOutlet UIImageView *btmPic;
@end

@implementation ViewController

/**
 系统默认只支持 https 请求。
 如果要想兼容 http 请求，必须配置ATS
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520327520385&di=2cb827ea8713b791dd94651f8c474ea1&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fbf096b63f6246b60553a62a0e1f81a4c510fa22a.jpg"];
    [_myPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"test"]];

    NSURL *urll = [NSURL URLWithString:@"http://imgsrc.baidu.com/imgad/pic/item/9f2f070828381f30d4d16a80a2014c086f06f0cb.jpg"];
    [_btmPic sd_setImageWithURL:urll placeholderImage:[UIImage imageNamed:@"test"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
