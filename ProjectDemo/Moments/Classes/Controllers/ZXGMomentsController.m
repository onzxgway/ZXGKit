//
//  ZXGMomentsController.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/4/12.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsController.h"
#import "ZXGDynamicModel.h"
#import "ZXGMomentsLayout.h"
#import "ZXGMomentsCell.h"

@interface ZXGMomentsController ()
//@property (nonatomic, strong) ZXGMomentsOperationMenu *vies;
@end

@implementation ZXGMomentsController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化视图
    [self moments_InitView];
    
    [self getResourece];
}

#pragma mark - Init
//初始化视图
- (void)moments_InitView {
    //
    self.navigationItem.title = @"朋友圈";
    //
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[GET_IMAGE(@"barbuttonicon_Camera") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem = rightItem;
//    self.navigationController.view.userInteractionEnabled = NO;
    
//    ZXGMomentsOperationMenu *vies = [[ZXGMomentsOperationMenu alloc] init];
//    vies.origin = CGPointMake(80, 80);
//    [self.view addSubview:vies];
//    self.vies = vies;
}

- (void)sendStatus {
    
}


#pragma mark - createViews
#pragma mark - private
- (void)getResourece {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        ZXGBaseTableViewSectionModel *secModel = [[ZXGBaseTableViewSectionModel alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment0" ofType:@"plist"];
        NSArray *sourceArr = [NSArray arrayWithContentsOfFile:plistPath];
        sourceArr = [NSArray modelArrayWithClass:ZXGDynamicModel.class json:sourceArr];
        
        for (ZXGDynamicModel *model in sourceArr) {
            ZXGMomentsLayout *layout = [[ZXGMomentsLayout alloc] initWithMoments:model];
            layout.cellClass = [ZXGMomentsCell class];
            layout.reuseIdentifier = NSStringFromClass(ZXGMomentsCell.class);
            [secModel addCellModel:layout];
        }
        [_dataSource addObject:secModel];
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", sourceArr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
    
}

#pragma mark - public
#pragma mark - lazyLoad

@end
