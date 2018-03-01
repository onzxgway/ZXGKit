//
//  ViewController.m
//  SDWebimage
//
//  Created by feizhu on 2018/2/28.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myPic;

@end

@implementation ViewController

/**
 默认情况下非 HTTPS 的网络访问是被禁止。
 打开方式：在info.plist 中配置 ATS
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    [_myPic sd_setImageWithURL:[NSURL URLWithString:@"http://img.ivsky.com/img/tupian/t/201711/28/aerbeisi_xueshan-001.jpg"] placeholderImage:[UIImage imageNamed:@"place_img"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
