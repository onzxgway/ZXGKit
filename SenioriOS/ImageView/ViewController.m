//
//  ViewController.m
//  ImageView
//
//  Created by 朱献国 on 2018/11/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ImageCompressController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"相册图片压缩";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"图片处理";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"截图";
    }else  {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *viewCtr = nil;
    if (indexPath.row == 0) {
        viewCtr = [ImageCompressController new];
    }else if (indexPath.row == 1){
//        viewCtr = [ImageFilterVC new];
    }else if (indexPath.row == 3){
//        viewCtr = [ShotScreenImageVC new];
    }else{
        
    }
    [self.navigationController pushViewController:viewCtr animated:YES];
}

@end
